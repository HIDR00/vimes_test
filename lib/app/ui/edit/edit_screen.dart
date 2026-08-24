import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:base/domain/domain.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import 'bloc/edit.dart';

@RoutePage()
class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    this.document,
  });

  final Document? document;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends BasePage<EditScreen, EditBloc> {
  late final TextEditingController _unitController;
  late final TextEditingController _departmentController;
  late final TextEditingController _numberController;
  late final TextEditingController _debitController;
  late final TextEditingController _creditController;
  late final TextEditingController _deliverController;
  late final TextEditingController _referenceController;
  late final TextEditingController _warehouseController;
  late final TextEditingController _locationController;
  late final TextEditingController _amountTextController;
  late final TextEditingController _attachedController;
  late DateTime _receiptDate;
  final List<_DocumentItemForm> _itemForms = [];

  bool get _isEditMode => widget.document != null;

  @override
  void initState() {
    super.initState();

    final document = widget.document;
    _receiptDate = document?.createdDate ?? DateTime.now();
    _unitController =
        TextEditingController(text: document?.unit ?? 'Công ty VIMES');
    _departmentController =
        TextEditingController(text: document?.department ?? 'Kho vật tư');
    _numberController = TextEditingController(
      text: document?.number ?? _generateReceiptNumber(_receiptDate),
    );
    _debitController =
        TextEditingController(text: document?.debitAccount ?? '156 - Hàng hóa');
    _creditController = TextEditingController(
      text: document?.creditAccount ?? '331 - Phải trả người bán',
    );
    _deliverController = TextEditingController(text: document?.deliverer ?? '');
    _referenceController =
        TextEditingController(text: document?.reference ?? '');
    _warehouseController =
        TextEditingController(text: document?.warehouse ?? 'Kho chính');
    _locationController = TextEditingController(text: document?.location ?? '');
    _amountTextController =
        TextEditingController(text: document?.amountInWords ?? '');
    _attachedController =
        TextEditingController(text: document?.attachedDocumentCount ?? '01');

    if (document == null) {
      _itemForms.add(_DocumentItemForm.empty());
    } else {
      _itemForms.addAll(document.items.map(_DocumentItemForm.fromItem));
      if (_itemForms.isEmpty) {
        _itemForms.add(_DocumentItemForm.empty());
      }
    }
  }

  @override
  void dispose() {
    _unitController.dispose();
    _departmentController.dispose();
    _numberController.dispose();
    _debitController.dispose();
    _creditController.dispose();
    _deliverController.dispose();
    _referenceController.dispose();
    _warehouseController.dispose();
    _locationController.dispose();
    _amountTextController.dispose();
    _attachedController.dispose();
    for (final itemForm in _itemForms) {
      itemForm.dispose();
    }
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Sửa phiếu nhập' : 'Tạo phiếu nhập'),
        actions: [
          TextButton.icon(
            onPressed: _saveDocument,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Lưu'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSection(
                context,
                title: 'Thông tin chứng từ',
                icon: Icons.receipt_long_outlined,
                children: [
                  _buildTextField('Đơn vị', _unitController),
                  _buildTextField('Bộ phận', _departmentController),
                  _buildTextField('Số phiếu', _numberController),
                  _buildDateField(context),
                  _buildTextField('Nợ', _debitController),
                  _buildTextField('Có', _creditController)
                ],
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Thông tin nhập kho',
                icon: Icons.warehouse_outlined,
                children: [
                  _buildTextField('Họ tên người giao', _deliverController),
                  _buildTextField('Theo chứng từ', _referenceController),
                  _buildTextField('Nhập tại kho', _warehouseController),
                  _buildTextField('Địa điểm', _locationController),
                ],
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Hàng hóa nhập kho',
                icon: Icons.inventory_2_outlined,
                children: [
                  for (var index = 0; index < _itemForms.length; index++) ...[
                    _buildProductRow(index),
                    const SizedBox(height: 12),
                  ],
                  OutlinedButton.icon(
                    onPressed: _addItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm hàng hóa'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: 'Tổng kết',
                icon: Icons.summarize_outlined,
                children: [
                  _buildTotalLine(context, 'Tổng số lượng thực nhập',
                      '$_totalActualQuantity'),
                  _buildTotalLine(
                      context, 'Tổng tiền', '${_formatMoney(_totalAmount)} đ'),
                  _buildTextField(
                      'Tổng số tiền bằng chữ', _amountTextController),
                  _buildTextField(
                      'Số chứng từ gốc kèm theo', _attachedController),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int get _totalActualQuantity {
    return _itemForms.fold(0, (sum, item) => sum + item.actualQuantity);
  }

  int get _totalAmount {
    return _itemForms.fold(0, (sum, item) => sum + item.totalAmount);
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: _fieldDecoration(label),
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: _receiptDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2035),
          );
          if (selectedDate == null) return;
          setState(() {
            _receiptDate = selectedDate;
          });
        },
        child: InputDecorator(
          decoration: _fieldDecoration('Ngày lập').copyWith(
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          child: Text(_formatDate(_receiptDate)),
        ),
      ),
    );
  }

  Widget _buildProductRow(int index) {
    final itemForm = _itemForms[index];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: Text('${index + 1}'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Dòng hàng hóa ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                onPressed: () => _removeItem(index),
                tooltip: 'Xóa dòng',
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: itemForm.nameController,
            decoration: _fieldDecoration('Tên, nhãn hiệu, quy cách phẩm chất'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: itemForm.codeController,
            decoration: _fieldDecoration('Mã số'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: itemForm.unitController,
            decoration: _fieldDecoration('Đơn vị tính'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: itemForm.expectedQuantityController,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            decoration: _fieldDecoration('Theo chứng từ'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: itemForm.actualQuantityController,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            decoration: _fieldDecoration('Thực nhập'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: itemForm.priceController,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            decoration: _fieldDecoration('Đơn giá'),
          ),
          const SizedBox(height: 10),
          InputDecorator(
            decoration: _fieldDecoration('Thành tiền'),
            child: Text('${_formatMoney(itemForm.totalAmount)} đ'),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      isDense: true,
    );
  }

  Widget _buildTotalLine(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    setState(() {
      _itemForms.add(_DocumentItemForm.empty());
    });
  }

  void _removeItem(int index) {
    if (_itemForms.length == 1) {
      _itemForms[index].clear();
      setState(() {});
      return;
    }

    setState(() {
      final removedItem = _itemForms.removeAt(index);
      removedItem.dispose();
    });
  }

  Future<void> _saveDocument() async {
    if (_numberController.text.trim().isEmpty) {
      _showMessage('Vui lòng nhập số phiếu.');
      return;
    }

    final items = _itemForms
        .map((itemForm) => itemForm.toDocumentItem())
        .where((item) => item.name.trim().isNotEmpty)
        .toList();
    if (items.isEmpty) {
      _showMessage('Vui lòng nhập ít nhất một dòng hàng hóa.');
      return;
    }

    final document = Document(
      id: widget.document?.id,
      number: _numberController.text.trim(),
      createdDate: _receiptDate,
      unit: _unitController.text.trim(),
      department: _departmentController.text.trim(),
      debitAccount: _debitController.text.trim(),
      creditAccount: _creditController.text.trim(),
      deliverer: _deliverController.text.trim(),
      reference: _referenceController.text.trim(),
      warehouse: _warehouseController.text.trim(),
      location: _locationController.text.trim(),
      amountInWords: _amountTextController.text.trim(),
      attachedDocumentCount: _attachedController.text.trim(),
      items: items,
    );

    final completer = Completer<void>();
    bloc.add(EditEventSaveDocument(document, completer));

    try {
      await completer.future;
      _showMessage('Lưu phiếu thành công');
      navigator.maybePop(true);
    } catch (_) {
      _showMessage('Không thể lưu phiếu nhập. Vui lòng thử lại.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _generateReceiptNumber(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return 'PN${date.year}$month${day}_$hour$minute';
  }

  String _formatMoney(int value) {
    final raw = value.toString();
    final buffer = StringBuffer();

    for (var i = 0; i < raw.length; i++) {
      final reverseIndex = raw.length - i;
      buffer.write(raw[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write('.');
      }
    }

    return buffer.toString();
  }
}

class _DocumentItemForm {
  _DocumentItemForm({
    required String name,
    required String code,
    required String unit,
    required int expectedQuantity,
    required int actualQuantity,
    required int price,
  })  : nameController = TextEditingController(text: name),
        codeController = TextEditingController(text: code),
        unitController = TextEditingController(text: unit),
        expectedQuantityController =
            TextEditingController(text: '$expectedQuantity'),
        actualQuantityController =
            TextEditingController(text: '$actualQuantity'),
        priceController =
            TextEditingController(text: price == 0 ? '' : '$price');

  factory _DocumentItemForm.empty() {
    return _DocumentItemForm(
      name: '',
      code: '',
      unit: '',
      expectedQuantity: 0,
      actualQuantity: 0,
      price: 0,
    );
  }

  factory _DocumentItemForm.fromItem(DocumentItem item) {
    return _DocumentItemForm(
      name: item.name,
      code: item.code,
      unit: item.unit,
      expectedQuantity: item.expectedQuantity,
      actualQuantity: item.actualQuantity,
      price: item.price,
    );
  }

  final TextEditingController nameController;
  final TextEditingController codeController;
  final TextEditingController unitController;
  final TextEditingController expectedQuantityController;
  final TextEditingController actualQuantityController;
  final TextEditingController priceController;

  int get actualQuantity => _parseNumber(actualQuantityController.text);

  int get totalAmount => actualQuantity * _parseNumber(priceController.text);

  void clear() {
    nameController.clear();
    codeController.clear();
    unitController.clear();
    expectedQuantityController.clear();
    actualQuantityController.clear();
    priceController.clear();
  }

  DocumentItem toDocumentItem() {
    return DocumentItem(
      name: nameController.text.trim(),
      code: codeController.text.trim(),
      unit: unitController.text.trim(),
      expectedQuantity: _parseNumber(expectedQuantityController.text),
      actualQuantity: _parseNumber(actualQuantityController.text),
      price: _parseNumber(priceController.text),
    );
  }

  void dispose() {
    nameController.dispose();
    codeController.dispose();
    unitController.dispose();
    expectedQuantityController.dispose();
    actualQuantityController.dispose();
    priceController.dispose();
  }

  static int _parseNumber(String value) {
    final normalized = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(normalized) ?? 0;
  }
}
