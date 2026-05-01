import 'package:barq_recharge/data/db/app_database.dart';
import 'package:drift/drift.dart';

class PendingSmsQueueRepository {
  const PendingSmsQueueRepository(this._database);

  final AppDatabase _database;

  Future<int> enqueue({
    required String reference,
    required String serviceKey,
    required String destinationNumber,
    required String smsBody,
    required String status,
  }) {
    return _database.into(_database.pendingSmsQueue).insert(
          PendingSmsQueueCompanion(
            reference: Value(reference),
            serviceKey: Value(serviceKey),
            destinationNumber: Value(destinationNumber),
            smsBody: Value(smsBody),
            status: Value(status),
          ),
        );
  }

  Future<void> updateStatus({
    required String reference,
    required String status,
    DateTime? processedAt,
  }) async {
    await (_database.update(_database.pendingSmsQueue)
          ..where((table) => table.reference.equals(reference)))
        .write(
      PendingSmsQueueCompanion(
        status: Value(status),
        processedAt: Value(processedAt),
      ),
    );
  }

  Future<List<PendingSmsQueueData>> fetchPending() {
    return (_database.select(_database.pendingSmsQueue)
          ..where((table) => table.status.equals('pending')))
        .get();
  }
}
