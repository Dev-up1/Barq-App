import 'package:barq_recharge/data/db/app_database.dart';
import 'package:drift/drift.dart';

class TransactionsRepository {
  const TransactionsRepository(this._database);

  final AppDatabase _database;

  Future<int> createTransaction(TransactionsCompanion transaction) {
    return _database.into(_database.transactions).insert(transaction);
  }

  Future<void> updateTransactionStatus({
    required String reference,
    required String status,
    DateTime? syncedAt,
  }) async {
    await (_database.update(_database.transactions)
          ..where((table) => table.reference.equals(reference)))
        .write(
      TransactionsCompanion(
        status: Value(status),
        syncedAt: Value(syncedAt),
      ),
    );
  }

  Future<List<Transaction>> fetchRecentTransactions({int limit = 20}) {
    return (_database.select(_database.transactions)
          ..orderBy([(table) => OrderingTerm.desc(table.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<int> sumTotalsForRange({
    required DateTime start,
    required DateTime end,
  }) async {
    final expr = _database.transactions.totalAmountMinor.sum();
    final row = await (_database.selectOnly(_database.transactions)
          ..addColumns([expr])
          ..where(
            _database.transactions.createdAt.isBiggerOrEqualValue(start) &
                _database.transactions.createdAt.isSmallerThanValue(end),
          ))
        .getSingle();
    return row.read(expr) ?? 0;
  }
}
