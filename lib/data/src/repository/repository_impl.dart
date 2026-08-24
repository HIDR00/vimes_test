import 'package:base/data/data.dart';
import 'package:base/data/src/mapper/import_receipt_mapper.dart';
import 'package:base/domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  RepositoryImpl(
    this._apiService, [
    ImportReceiptFirestoreService? importReceiptFirestoreService,
  ]) : _importReceiptFirestoreService =
            importReceiptFirestoreService ?? ImportReceiptFirestoreService();

  final ApiService _apiService;
  final ImportReceiptFirestoreService _importReceiptFirestoreService;

  @override
  Future<String> ping() async {
    final response = await _apiService.ping();
    return response?.message ?? '';
  }

  @override
  Future<List<Document>> getImportReceipts() async {
    final documents = await _importReceiptFirestoreService.getDocuments();
    return documents.map((document) => document.toEntity()).toList();
  }

  @override
  Future<Document?> getImportReceiptById(String id) async {
    final document = await _importReceiptFirestoreService.getDocumentById(id);
    return document?.toEntity();
  }

  @override
  Future<Document> createImportReceipt(Document document) async {
    final savedDocument = await _importReceiptFirestoreService.createDocument(
      document.toModel(),
    );
    return savedDocument.toEntity();
  }

  @override
  Future<Document> updateImportReceipt(Document document) async {
    final savedDocument = await _importReceiptFirestoreService.updateDocument(
      document.toModel(),
    );
    return savedDocument.toEntity();
  }

  @override
  Future<void> deleteImportReceipt(Document document) {
    return _importReceiptFirestoreService.deleteDocument(document.toModel());
  }
}
