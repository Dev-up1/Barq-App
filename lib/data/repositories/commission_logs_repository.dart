import 'package:barq_recharge/data/db/app_database.dart';
import 'package:drift/drift.dart';

class CommissionLogsRepository {
  const CommissionLogsRepository(this._database);

  final AppDatabase _database;

  Future<int> insertLog({
    required String transactionReference,
    required String serviceKey,
    required int baseAmountMinor,
    required int totalAmountMinor,
    required int commissionAmountMinor,
  }) {
    return _database.into(_database.commissionLogs).insert(
          CommissionLogsCompanion.insert(
            transactionReference: transactionReference,
            serviceKey: serviceKey,
            baseAmountMinor: baseAmountMinor,
            totalAmountMinor: totalAmountMinor,
            commissionAmountMinor: commissionAmountMinor,
          ),
        );
  }

  Future<List<CommissionLog>> fetchAllForMonth(DateTime month) {
    final start = DateTime(month.year, month.month);
    final end = DateTime(month.year, month.month + 1);
    return (_database.select(_database.commissionLogs)
          ..where((table) =>
              table.createdAt.isBiggerOrEqualValue(start) &
              table.createdAt.isSmallerThanValue(end)))
        .get();
  }

  Future<int> totalSalesForRange(DateTime start, DateTime end) async {
    final expr = _database.commissionLogs.totalAmountMinor.sum();
    final row = await (_database.selectOnly(_database.commissionLogs)
          ..addColumns([expr])
          ..where(
            _database.commissionLogs.createdAt.isBiggerOrEqualValue(start) &
                _database.commissionLogs.createdAt.isSmallerThanValue(end),
          ))
        .getSingle();
    return row.read(expr) ?? 0;
  }

  Future<int> totalCommissionForRange(DateTime start, DateTime end) async {
    final expr = _database.commissionLogs.commissionAmountMinor.sum();
    final row = await (_database.selectOnly(_database.commissionLogs)
          ..addColumns([expr])
          ..where(
            _database.commissionLogs.createdAt.isBiggerOrEqualValue(start) &
                _database.commissionLogs.createdAt.isSmallerThanValue(end),
          ))
        .getSingle();
    return row.read(expr) ?? 0;
  }
}
