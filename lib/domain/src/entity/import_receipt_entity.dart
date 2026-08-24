class Document {
  const Document({
    this.id,
    required this.number,
    required this.createdDate,
    required this.unit,
    required this.department,
    required this.debitAccount,
    required this.creditAccount,
    required this.deliverer,
    required this.reference,
    required this.warehouse,
    required this.location,
    required this.amountInWords,
    required this.attachedDocumentCount,
    required this.items,
  });

  final String? id;
  final String number;
  final DateTime createdDate;
  final String unit;
  final String department;
  final String debitAccount;
  final String creditAccount;
  final String deliverer;
  final String reference;
  final String warehouse;
  final String location;
  final String amountInWords;
  final String attachedDocumentCount;
  final List<DocumentItem> items;

  String get provider => 'Người giao: $deliverer';

  int get totalActualQuantity {
    return items.fold(0, (sum, item) => sum + item.actualQuantity);
  }

  int get totalAmount {
    return items.fold(0, (sum, item) => sum + item.totalAmount);
  }

  String get formattedTotalAmount {
    return '${_formatMoney(totalAmount)} đ';
  }

  Document copyWith({
    String? id,
    String? number,
    DateTime? createdDate,
    String? unit,
    String? department,
    String? debitAccount,
    String? creditAccount,
    String? deliverer,
    String? reference,
    String? warehouse,
    String? location,
    String? amountInWords,
    String? attachedDocumentCount,
    List<DocumentItem>? items,
  }) {
    return Document(
      id: id ?? this.id,
      number: number ?? this.number,
      createdDate: createdDate ?? this.createdDate,
      unit: unit ?? this.unit,
      department: department ?? this.department,
      debitAccount: debitAccount ?? this.debitAccount,
      creditAccount: creditAccount ?? this.creditAccount,
      deliverer: deliverer ?? this.deliverer,
      reference: reference ?? this.reference,
      warehouse: warehouse ?? this.warehouse,
      location: location ?? this.location,
      amountInWords: amountInWords ?? this.amountInWords,
      attachedDocumentCount:
          attachedDocumentCount ?? this.attachedDocumentCount,
      items: items ?? this.items,
    );
  }
}

class DocumentItem {
  const DocumentItem({
    required this.name,
    required this.code,
    required this.unit,
    required this.expectedQuantity,
    required this.actualQuantity,
    required this.price,
  });

  final String name;
  final String code;
  final String unit;
  final int expectedQuantity;
  final int actualQuantity;
  final int price;

  int get totalAmount => actualQuantity * price;

  String get formattedPrice => _formatMoney(price);

  String get formattedTotalAmount => _formatMoney(totalAmount);

  DocumentItem copyWith({
    String? name,
    String? code,
    String? unit,
    int? expectedQuantity,
    int? actualQuantity,
    int? price,
  }) {
    return DocumentItem(
      name: name ?? this.name,
      code: code ?? this.code,
      unit: unit ?? this.unit,
      expectedQuantity: expectedQuantity ?? this.expectedQuantity,
      actualQuantity: actualQuantity ?? this.actualQuantity,
      price: price ?? this.price,
    );
  }
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
