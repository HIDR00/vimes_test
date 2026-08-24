import '../entity/import_receipt_entity.dart';

abstract class Repository {
  Future<String> ping();
  Future<List<Document>> getImportReceipts();
  Future<Document?> getImportReceiptById(String id);
  Future<Document> createImportReceipt(Document document);
  Future<Document> updateImportReceipt(Document document);
  Future<void> deleteImportReceipt(Document document);
}
