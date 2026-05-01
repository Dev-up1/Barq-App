import 'package:barq_recharge/data/db/app_database.dart';
import 'package:drift/drift.dart';

class LocalWalletRepository {
  const LocalWalletRepository(this._database);

  final AppDatabase _database;

  Future<LocalWallet?> fetchCurrentWallet() {
    return (_database.select(_database.localWallets)
          ..orderBy([(table) => OrderingTerm.desc(table.id)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> upsertWallet({
    int? id,
    required String agentName,
    required int availableBalanceMinor,
    required int reservedBalanceMinor,
    int? dailySpendingLimitMinor,
    int? monthlySpendingLimitMinor,
    DateTime? lastSyncedAt,
  }) {
    final companion = LocalWalletsCompanion(
      id: Value(id ?? 1),
      agentName: Value(agentName),
      availableBalanceMinor: Value(availableBalanceMinor),
      reservedBalanceMinor: Value(reservedBalanceMinor),
      dailySpendingLimitMinor: Value(dailySpendingLimitMinor ?? 500000),
      monthlySpendingLimitMinor: Value(monthlySpendingLimitMinor ?? 5000000),
      lastSyncedAt: Value(lastSyncedAt),
    );

    return _database.into(_database.localWallets).insertOnConflictUpdate(
          companion,
        );
  }

  Future<void> updateLimits({
    required int dailySpendingLimitMinor,
    required int monthlySpendingLimitMinor,
  }) async {
    await (_database.update(_database.localWallets)
          ..where((table) => table.id.equals(1)))
        .write(
      LocalWalletsCompanion(
        dailySpendingLimitMinor: Value(dailySpendingLimitMinor),
        monthlySpendingLimitMinor: Value(monthlySpendingLimitMinor),
      ),
    );
  }
}
