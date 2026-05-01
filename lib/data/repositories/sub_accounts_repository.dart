import 'package:barq_recharge/data/db/app_database.dart';
import 'package:drift/drift.dart';

class SubAccountsRepository {
  const SubAccountsRepository(this._database);

  final AppDatabase _database;

  Future<int> createSubAccount({
    required String displayName,
    required String pinCode,
    required int dailySpendingLimitMinor,
    required int monthlySpendingLimitMinor,
  }) {
    return _database.into(_database.subAccounts).insert(
          SubAccountsCompanion.insert(
            displayName: displayName,
            pinCode: pinCode,
            dailySpendingLimitMinor: Value(dailySpendingLimitMinor),
            monthlySpendingLimitMinor: Value(monthlySpendingLimitMinor),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<List<SubAccount>> fetchAll() {
    return (_database.select(_database.subAccounts)
          ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
        .get();
  }

  Future<List<SubAccount>> fetchActive() {
    return (_database.select(_database.subAccounts)
          ..where((table) => table.isActive.equals(true)))
        .get();
  }

  Future<SubAccount?> findById(int id) {
    return (_database.select(_database.subAccounts)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> updateSubAccount({
    required int id,
    String? displayName,
    String? pinCode,
    bool? isActive,
    int? dailySpendingLimitMinor,
    int? monthlySpendingLimitMinor,
  }) async {
    await (_database.update(_database.subAccounts)
          ..where((table) => table.id.equals(id)))
        .write(
      SubAccountsCompanion(
        displayName:
            displayName == null ? const Value.absent() : Value(displayName),
        pinCode: pinCode == null ? const Value.absent() : Value(pinCode),
        isActive: isActive == null ? const Value.absent() : Value(isActive),
        dailySpendingLimitMinor: dailySpendingLimitMinor == null
            ? const Value.absent()
            : Value(dailySpendingLimitMinor),
        monthlySpendingLimitMinor: monthlySpendingLimitMinor == null
            ? const Value.absent()
            : Value(monthlySpendingLimitMinor),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> removeSubAccount(int id) async {
    await (_database.delete(_database.subAccounts)
          ..where((table) => table.id.equals(id)))
        .go();
  }
}
