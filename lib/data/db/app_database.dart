import 'dart:io';

import 'package:barq_recharge/core/taxation/tax_classification.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class LocalWallets extends Table {
  IntColumn get id => integer()();
  TextColumn get agentName => text().withLength(min: 1, max: 120)();
  IntColumn get availableBalanceMinor => integer()();
  IntColumn get reservedBalanceMinor => integer().withDefault(const Constant(0))();
  IntColumn get dailySpendingLimitMinor =>
      integer().withDefault(const Constant(500000))();
  IntColumn get monthlySpendingLimitMinor =>
      integer().withDefault(const Constant(5000000))();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get reference => text().unique()();
  TextColumn get serviceKey => text()();
  TextColumn get serviceType => text()();
  IntColumn get psiCode => integer()();
  TextColumn get targetIdentifier => text()();
  IntColumn get baseAmountMinor => integer()();
  IntColumn get taxAmountMinor => integer()();
  IntColumn get totalAmountMinor => integer()();
  TextColumn get status => text()();
  TextColumn get channel => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}

class ServicesCatalog extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serviceKey => text().unique()();
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text()();
  TextColumn get category => text()();
  TextColumn get provider => text()();
  IntColumn get psiCode => integer()();
  TextColumn get taxClass => text().map(const TaxClassificationConverter())();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastUpdatedAt => dateTime().nullable()();
}

class PendingSmsQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get reference => text().unique()();
  TextColumn get serviceKey => text()();
  TextColumn get destinationNumber => text()();
  TextColumn get smsBody => text()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get processedAt => dateTime().nullable()();
}

class SubAccounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get displayName => text()();
  TextColumn get pinCode => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get dailySpendingLimitMinor =>
      integer().withDefault(const Constant(50000))();
  IntColumn get monthlySpendingLimitMinor =>
      integer().withDefault(const Constant(500000))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class CommissionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get transactionReference => text().unique()();
  TextColumn get serviceKey => text()();
  IntColumn get baseAmountMinor => integer()();
  IntColumn get totalAmountMinor => integer()();
  IntColumn get commissionAmountMinor => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    LocalWallets,
    Transactions,
    ServicesCatalog,
    PendingSmsQueue,
    SubAccounts,
    CommissionLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(pendingSmsQueue);
          }

          if (from < 3) {
            await m.addColumn(
              localWallets,
              localWallets.dailySpendingLimitMinor,
            );
            await m.addColumn(
              localWallets,
              localWallets.monthlySpendingLimitMinor,
            );
            await m.createTable(subAccounts);
            await m.createTable(commissionLogs);
          }
        },
      );

  @override
  int get schemaVersion => 3;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'barq_recharge.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

class TaxClassificationConverter
    extends TypeConverter<TaxClassification, String> {
  const TaxClassificationConverter();

  @override
  TaxClassification fromSql(String fromDb) {
    return TaxClassification.fromKey(fromDb);
  }

  @override
  String toSql(TaxClassification value) {
    return value.key;
  }
}
