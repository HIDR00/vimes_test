import 'package:base/domain/domain.dart';

import '../repository/source/api/model/import_receipt_model.dart';

extension ImportReceiptModelMapper on ImportReceiptModel {
  Document toEntity() {
    return Document(
      id: id,
      number: number,
      createdDate: createdDate,
      unit: unit,
      department: department,
      debitAccount: debitAccount,
      creditAccount: creditAccount,
      deliverer: deliverer,
      reference: reference,
      warehouse: warehouse,
      location: location,
      amountInWords: amountInWords,
      attachedDocumentCount: attachedDocumentCount,
      items: items.map((item) => item.toEntity()).toList(),
    );
  }
}

extension ImportReceiptItemModelMapper on ImportReceiptItemModel {
  DocumentItem toEntity() {
    return DocumentItem(
      name: name,
      code: code,
      unit: unit,
      expectedQuantity: expectedQuantity,
      actualQuantity: actualQuantity,
      price: price,
    );
  }
}

extension ImportReceiptEntityMapper on Document {
  ImportReceiptModel toModel() {
    return ImportReceiptModel(
      id: id,
      number: number,
      createdDate: createdDate,
      unit: unit,
      department: department,
      debitAccount: debitAccount,
      creditAccount: creditAccount,
      deliverer: deliverer,
      reference: reference,
      warehouse: warehouse,
      location: location,
      amountInWords: amountInWords,
      attachedDocumentCount: attachedDocumentCount,
      items: items.map((item) => item.toModel()).toList(),
    );
  }
}

extension ImportReceiptItemEntityMapper on DocumentItem {
  ImportReceiptItemModel toModel() {
    return ImportReceiptItemModel(
      name: name,
      code: code,
      unit: unit,
      expectedQuantity: expectedQuantity,
      actualQuantity: actualQuantity,
      price: price,
    );
  }
}
