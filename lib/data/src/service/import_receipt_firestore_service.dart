import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../repository/source/api/model/import_receipt_model.dart';

@LazySingleton()
class ImportReceiptFirestoreService {
  ImportReceiptFirestoreService() : _firestore = FirebaseFirestore.instance;

  ImportReceiptFirestoreService.withFirestore(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection {
    return _firestore.collection('import_receipts');
  }

  Future<List<ImportReceiptModel>> getDocuments() async {
    final snapshot =
        await _collection.orderBy('createdDate', descending: true).get();

    return Future.wait(snapshot.docs.map(_documentFromSnapshot));
  }

  Future<ImportReceiptModel?> getDocumentById(String id) async {
    if (id.trim().isEmpty) return null;

    final snapshot = await _collection.doc(id).get();
    if (!snapshot.exists) return null;

    return _documentFromSnapshot(snapshot);
  }

  Future<ImportReceiptModel> createDocument(ImportReceiptModel document) async {
    final receiptRef = await _collection.add(
      _receiptMap(
        document,
        createdAt: FieldValue.serverTimestamp(),
        updatedAt: FieldValue.serverTimestamp(),
      ),
    );

    await _replaceItems(receiptRef, document.items);
    return document.copyWith(id: receiptRef.id);
  }

  Future<ImportReceiptModel> updateDocument(ImportReceiptModel document) async {
    final id = document.id;
    if (id == null) {
      return createDocument(document);
    }

    final receiptRef = _collection.doc(id);
    await receiptRef.update(
      _receiptMap(
        document,
        updatedAt: FieldValue.serverTimestamp(),
      ),
    );
    await _replaceItems(receiptRef, document.items);
    return document;
  }

  Future<void> deleteDocument(ImportReceiptModel document) async {
    final id = document.id;
    if (id == null) return;

    final receiptRef = _collection.doc(id);
    await _deleteItems(receiptRef);
    await receiptRef.delete();
  }

  Future<ImportReceiptModel> _documentFromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) async {
    final data = snapshot.data() ?? {};
    final itemSnapshot =
        await snapshot.reference.collection('items').orderBy('order').get();
    final items = itemSnapshot.docs.map((itemDoc) {
      return _itemFromMap(itemDoc.data());
    }).toList();

    return ImportReceiptModel(
      id: snapshot.id,
      number: _string(data['number']),
      createdDate: _date(data['createdDate']),
      unit: _string(data['unit']),
      department: _string(data['department']),
      debitAccount: _string(data['debitAccount']),
      creditAccount: _string(data['creditAccount']),
      deliverer: _string(data['deliverer']),
      reference: _string(data['reference']),
      warehouse: _string(data['warehouse']),
      location: _string(data['location']),
      amountInWords: _string(data['amountInWords']),
      attachedDocumentCount: _string(data['attachedDocumentCount']),
      items: items,
    );
  }

  Map<String, dynamic> _receiptMap(
    ImportReceiptModel document, {
    Object? createdAt,
    Object? updatedAt,
  }) {
    return {
      'number': document.number,
      'createdDate': Timestamp.fromDate(document.createdDate),
      'unit': document.unit,
      'department': document.department,
      'debitAccount': document.debitAccount,
      'creditAccount': document.creditAccount,
      'deliverer': document.deliverer,
      'reference': document.reference,
      'warehouse': document.warehouse,
      'location': document.location,
      'amountInWords': document.amountInWords,
      'attachedDocumentCount': document.attachedDocumentCount,
      'totalActualQuantity': document.totalActualQuantity,
      'totalAmount': document.totalAmount,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }

  Map<String, dynamic> _itemMap(ImportReceiptItemModel item, int order) {
    return {
      'order': order,
      'name': item.name,
      'code': item.code,
      'unit': item.unit,
      'expectedQuantity': item.expectedQuantity,
      'actualQuantity': item.actualQuantity,
      'price': item.price,
      'totalAmount': item.totalAmount,
    };
  }

  ImportReceiptItemModel _itemFromMap(Map<String, dynamic> data) {
    return ImportReceiptItemModel(
      name: _string(data['name']),
      code: _string(data['code']),
      unit: _string(data['unit']),
      expectedQuantity: _int(data['expectedQuantity']),
      actualQuantity: _int(data['actualQuantity']),
      price: _int(data['price']),
    );
  }

  Future<void> _replaceItems(
    DocumentReference<Map<String, dynamic>> receiptRef,
    List<ImportReceiptItemModel> items,
  ) async {
    await _deleteItems(receiptRef);

    final batch = _firestore.batch();
    for (var i = 0; i < items.length; i++) {
      final itemRef = receiptRef.collection('items').doc();
      batch.set(itemRef, _itemMap(items[i], i));
    }
    await batch.commit();
  }

  Future<void> _deleteItems(
    DocumentReference<Map<String, dynamic>> receiptRef,
  ) async {
    final itemSnapshot = await receiptRef.collection('items').get();
    if (itemSnapshot.docs.isEmpty) return;

    final batch = _firestore.batch();
    for (final itemDoc in itemSnapshot.docs) {
      batch.delete(itemDoc.reference);
    }
    await batch.commit();
  }

  String _string(Object? value) {
    return value?.toString() ?? '';
  }

  int _int(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  DateTime _date(Object? value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    return DateTime.now();
  }
}
