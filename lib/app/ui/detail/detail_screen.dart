import 'package:auto_route/auto_route.dart';
import 'package:base/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import '../../navigation/routers/app_router.gr.dart';
import 'bloc/detail.dart';

@RoutePage()
class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.document,
  });

  final Document document;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends BasePage<DetailScreen, DetailBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(DetailEventInit(widget.document));
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        final document = state.document ?? widget.document;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Chi tiết phiếu nhập'),
            actions: [
              IconButton(
                onPressed: () {
                  _editDocument(document);
                },
                tooltip: 'Chỉnh sửa',
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () {
                  _deleteDocument(document);
                },
                tooltip: 'Xóa',
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildReceiptHeader(context, document),
                  const SizedBox(height: 16),
                  _buildSection(
                    context,
                    title: 'Thông tin chứng từ',
                    child: Column(
                      children: [
                        _InfoRow(label: 'Đơn vị', value: document.unit),
                        _InfoRow(label: 'Bộ phận', value: document.department),
                        _InfoRow(label: 'Số phiếu', value: document.number),
                        _InfoRow(
                          label: 'Ngày lập',
                          value: _formatDate(document.createdDate),
                        ),
                        _InfoRow(label: 'Nợ', value: document.debitAccount),
                        _InfoRow(label: 'Có', value: document.creditAccount),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    context,
                    title: 'Thông tin nhập kho',
                    child: Column(
                      children: [
                        _InfoRow(
                          label: 'Họ tên người giao',
                          value: document.deliverer,
                        ),
                        _InfoRow(label: 'Theo', value: document.reference),
                        _InfoRow(
                            label: 'Nhập tại kho', value: document.warehouse),
                        _InfoRow(label: 'Địa điểm', value: document.location),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSection(
                    context,
                    title: 'Danh sách hàng hóa',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowHeight: 44,
                            dataRowMinHeight: 52,
                            dataRowMaxHeight: 64,
                            columns: const [
                              DataColumn(label: Text('STT')),
                              DataColumn(label: Text('Tên hàng hóa')),
                              DataColumn(label: Text('Mã số')),
                              DataColumn(label: Text('ĐVT')),
                              DataColumn(label: Text('Theo CT')),
                              DataColumn(label: Text('Thực nhập')),
                              DataColumn(label: Text('Đơn giá')),
                              DataColumn(label: Text('Thành tiền')),
                            ],
                            rows: document.items.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;

                              return DataRow(
                                cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(Text(item.name)),
                                  DataCell(Text(item.code)),
                                  DataCell(Text(item.unit)),
                                  DataCell(Text('${item.expectedQuantity}')),
                                  DataCell(Text('${item.actualQuantity}')),
                                  DataCell(Text(item.formattedPrice)),
                                  DataCell(Text(item.formattedTotalAmount)),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                        const Divider(height: 28),
                        _InfoRow(
                          label: 'Tổng số tiền',
                          value: document.formattedTotalAmount,
                        ),
                        _InfoRow(
                          label: 'Bằng chữ',
                          value: document.amountInWords,
                        ),
                        _InfoRow(
                          label: 'Số chứng từ gốc kèm theo',
                          value: document.attachedDocumentCount,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSignatures(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptHeader(BuildContext context, Document document) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            'PHIẾU NHẬP KHO',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 6),
          const Text('Mẫu số 01 - VT'),
          const SizedBox(height: 10),
          Text(
            'Ngày ${document.createdDate.day} tháng ${document.createdDate.month} năm ${document.createdDate.year}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildSignatures(BuildContext context) {
    final signatures = [
      'Người lập phiếu',
      'Người giao hàng',
      'Thủ kho',
      'Kế toán trưởng',
    ];

    return _buildSection(
      context,
      title: 'Xác nhận',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: signatures
            .map(
              (title) => SizedBox(
                width: 150,
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '(Ký, họ tên)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 42),
                    const Divider(),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _editDocument(Document document) async {
    final saved = await navigator.push<bool>(
      EditRoute(document: document),
    );
    if (saved == true) {
      bloc.add(DetailEventGetDetail(id: document.id ?? ''));
    }
  }

  Future<void> _deleteDocument(Document document) async {
    await showDialog(
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
                bloc.add(DetailEventDeleteReceipt(document: document));
                navigator.replaceAll([HomeRoute()]);
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
