import 'package:auto_route/auto_route.dart';
import 'package:base/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/routers/app_router.gr.dart';
import 'bloc/home.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePage<HomeScreen, HomeBloc> {
  final _searchController = TextEditingController();
  String? _loadError;

  bool get _hasActiveFilter {
    return bloc.state.searchText.trim().isNotEmpty ||
        bloc.state.selectedWarehouse != null ||
        bloc.state.fromDate != null ||
        bloc.state.toDate != null;
  }

  @override
  void initState() {
    super.initState();
    bloc.add(HomeEventInitial());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phiếu nhập kho'),
        centerTitle: false,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildOverview(context, state),
                const SizedBox(height: 16),
                _buildHeader(state),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildImportReceiptList(state),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEditRoute(),
        icon: const Icon(Icons.add),
        label: const Text('Tạo phiếu nhập'),
      ),
    );
  }

  Widget _buildOverview(BuildContext context, HomeState state) {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            context,
            icon: Icons.receipt_long,
            label: 'Tổng phiếu',
            value: '${state.lDocument.length}',
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            context,
            icon: Icons.playlist_add_check,
            label: 'Mặt hàng',
            value: state.totalItem.toString(),
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildMetricCard(
            context,
            icon: Icons.warehouse_outlined,
            label: 'Kho',
            value: state.warehouses.length.toString(),
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(HomeState state) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm phiếu nhập...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: bloc.state.searchText.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        bloc.add(HomeEventSearchTextChange(value: ''));
                        _searchController.clear();
                      },
                      tooltip: 'Xóa tìm kiếm',
                      icon: const Icon(Icons.close),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
            ),
            onChanged: (value) {
              bloc.add(HomeEventSearchTextChange(value: value));
            },
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {
            _showFilterSheet(state);
          },
          icon: Icon(_hasActiveFilter ? Icons.filter_alt : Icons.filter_list),
          label: Text(_hasActiveFilter ? 'Đang lọc' : 'Lọc'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImportReceiptList(HomeState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_loadError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, size: 48, color: Colors.grey.shade500),
            const SizedBox(height: 12),
            const Text(
              'Không tải được dữ liệu Firestore',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                _loadError!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                bloc.add(HomeEventInitial());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (state.lFilterDocument.isEmpty) {
      final message = _hasActiveFilter
          ? 'Không tìm thấy phiếu nhập phù hợp'
          : 'Chưa có phiếu nhập nào';

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey.shade500),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            if (_hasActiveFilter)
              TextButton.icon(
                onPressed: _clearFilters,
                icon: const Icon(Icons.refresh),
                label: const Text('Xóa tìm kiếm và bộ lọc'),
              )
            else
              TextButton.icon(
                onPressed: () => _openEditRoute(),
                icon: const Icon(Icons.add),
                label: const Text('Tạo phiếu nhập đầu tiên'),
              ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: state.lFilterDocument.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final document = state.lFilterDocument[index];

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                color: Colors.black,
              ),
            ),
            title: Text(
              document.number,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(document.provider),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _buildBadge(
                        Icons.calendar_today_outlined,
                        _formatDate(document.createdDate),
                      ),
                      _buildBadge(
                        Icons.inventory_outlined,
                        document.warehouse,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            trailing: PopupMenuButton<String>(
              tooltip: 'Tùy chọn',
              onSelected: (value) {
                if (value == 'edit') {
                  _openEditRoute(document: document);
                } else if (value == 'delete') {
                  _confirmDelete(document);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Sửa'),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete_outline),
                    title: Text('Xóa'),
                  ),
                ),
              ],
            ),
            onTap: () {
              navigator.push(DetailRoute(document: document));
            },
          ),
        );
      },
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade700),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<bool> _confirmDelete(Document document) async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Xóa phiếu nhập'),
          content: Text('Bạn có chắc muốn xóa phiếu ${document.number}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            FilledButton.icon(
              onPressed: () {
                bloc.add(HomeEventDeleteReceipt(document: document));
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text('Xóa'),
            ),
          ],
        );
      },
    );

    return confirmed ?? false;
  }

  Future<void> _showFilterSheet(HomeState state) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Bộ lọc phiếu nhập',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String?>(
                  initialValue: state.selectedWarehouse,
                  decoration: _filterDecoration('Kho'),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Tất cả kho'),
                    ),
                    ...state.warehouses.map(
                      (warehouse) => DropdownMenuItem<String?>(
                        value: warehouse,
                        child: Text(warehouse),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    bloc.add(HomeEventWareHouseChange(value: value));
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateFilterField(
                        context,
                        label: 'Từ ngày',
                        date: state.fromDate,
                        onPick: (date) {
                          bloc.add(HomeEventFromDateChange(fromDate: date));
                        },
                        onClear: () {
                          bloc.add(HomeEventFromDateChange(fromDate: null));
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateFilterField(
                        context,
                        label: 'Đến ngày',
                        date: state.toDate,
                        onPick: (date) {
                          bloc.add(HomeEventToDateChange(toDate: date));
                        },
                        onClear: () {
                          bloc.add(HomeEventToDateChange(toDate: null));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          bloc.add(HomeEventWareHouseChange());
                          bloc.add(HomeEventFromDateChange(fromDate: null));
                          bloc.add(HomeEventToDateChange(toDate: null));
                          bloc.add(
                            HomeEventFilterDocument(),
                          );
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Đặt lại'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          bloc.add(
                            HomeEventFilterDocument(),
                          );
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Áp dụng'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateFilterField(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required ValueChanged<DateTime> onPick,
    required VoidCallback onClear,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
        );
        if (selectedDate == null) return;
        onPick(selectedDate);
      },
      child: InputDecorator(
        decoration: _filterDecoration(label).copyWith(
          suffixIcon: date == null
              ? const Icon(Icons.calendar_today_outlined)
              : IconButton(
                  onPressed: onClear,
                  tooltip: 'Xóa ngày',
                  icon: const Icon(Icons.close),
                ),
        ),
        child: Text(date == null ? 'Chọn ngày' : _formatDate(date)),
      ),
    );
  }

  InputDecoration _filterDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      isDense: true,
    );
  }

  void _clearFilters() {
    _searchController.clear();
    bloc.add(HomeEventSearchTextChange(value: ''));
    bloc.add(HomeEventWareHouseChange());
    bloc.add(HomeEventFromDateChange(fromDate: null));
    bloc.add(HomeEventToDateChange(toDate: null));
    bloc.add(HomeEventFilterDocument());
  }

  Future<void> _openEditRoute({Document? document}) async {
    final saved = await navigator.push<bool>(
      EditRoute(document: document),
    );
    if (saved == true) {
      bloc.add(HomeEventInitial());
    }
  }
}
