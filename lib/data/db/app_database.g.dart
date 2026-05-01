// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalWalletsTable extends LocalWallets
    with TableInfo<$LocalWalletsTable, LocalWallet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalWalletsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _agentNameMeta =
      const VerificationMeta('agentName');
  @override
  late final GeneratedColumn<String> agentName = GeneratedColumn<String>(
      'agent_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 120),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _availableBalanceMinorMeta =
      const VerificationMeta('availableBalanceMinor');
  @override
  late final GeneratedColumn<int> availableBalanceMinor = GeneratedColumn<int>(
      'available_balance_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _reservedBalanceMinorMeta =
      const VerificationMeta('reservedBalanceMinor');
  @override
  late final GeneratedColumn<int> reservedBalanceMinor = GeneratedColumn<int>(
      'reserved_balance_minor', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _dailySpendingLimitMinorMeta =
      const VerificationMeta('dailySpendingLimitMinor');
  @override
  late final GeneratedColumn<int> dailySpendingLimitMinor =
      GeneratedColumn<int>('daily_spending_limit_minor', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(500000));
  static const VerificationMeta _monthlySpendingLimitMinorMeta =
      const VerificationMeta('monthlySpendingLimitMinor');
  @override
  late final GeneratedColumn<int> monthlySpendingLimitMinor =
      GeneratedColumn<int>('monthly_spending_limit_minor', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(5000000));
  static const VerificationMeta _lastSyncedAtMeta =
      const VerificationMeta('lastSyncedAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
      'last_synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        agentName,
        availableBalanceMinor,
        reservedBalanceMinor,
        dailySpendingLimitMinor,
        monthlySpendingLimitMinor,
        lastSyncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_wallets';
  @override
  VerificationContext validateIntegrity(Insertable<LocalWallet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('agent_name')) {
      context.handle(_agentNameMeta,
          agentName.isAcceptableOrUnknown(data['agent_name']!, _agentNameMeta));
    } else if (isInserting) {
      context.missing(_agentNameMeta);
    }
    if (data.containsKey('available_balance_minor')) {
      context.handle(
          _availableBalanceMinorMeta,
          availableBalanceMinor.isAcceptableOrUnknown(
              data['available_balance_minor']!, _availableBalanceMinorMeta));
    } else if (isInserting) {
      context.missing(_availableBalanceMinorMeta);
    }
    if (data.containsKey('reserved_balance_minor')) {
      context.handle(
          _reservedBalanceMinorMeta,
          reservedBalanceMinor.isAcceptableOrUnknown(
              data['reserved_balance_minor']!, _reservedBalanceMinorMeta));
    }
    if (data.containsKey('daily_spending_limit_minor')) {
      context.handle(
          _dailySpendingLimitMinorMeta,
          dailySpendingLimitMinor.isAcceptableOrUnknown(
              data['daily_spending_limit_minor']!,
              _dailySpendingLimitMinorMeta));
    }
    if (data.containsKey('monthly_spending_limit_minor')) {
      context.handle(
          _monthlySpendingLimitMinorMeta,
          monthlySpendingLimitMinor.isAcceptableOrUnknown(
              data['monthly_spending_limit_minor']!,
              _monthlySpendingLimitMinorMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
          _lastSyncedAtMeta,
          lastSyncedAt.isAcceptableOrUnknown(
              data['last_synced_at']!, _lastSyncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalWallet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalWallet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      agentName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agent_name'])!,
      availableBalanceMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}available_balance_minor'])!,
      reservedBalanceMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}reserved_balance_minor'])!,
      dailySpendingLimitMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}daily_spending_limit_minor'])!,
      monthlySpendingLimitMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}monthly_spending_limit_minor'])!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_synced_at']),
    );
  }

  @override
  $LocalWalletsTable createAlias(String alias) {
    return $LocalWalletsTable(attachedDatabase, alias);
  }
}

class LocalWallet extends DataClass implements Insertable<LocalWallet> {
  final int id;
  final String agentName;
  final int availableBalanceMinor;
  final int reservedBalanceMinor;
  final int dailySpendingLimitMinor;
  final int monthlySpendingLimitMinor;
  final DateTime? lastSyncedAt;
  const LocalWallet(
      {required this.id,
      required this.agentName,
      required this.availableBalanceMinor,
      required this.reservedBalanceMinor,
      required this.dailySpendingLimitMinor,
      required this.monthlySpendingLimitMinor,
      this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['agent_name'] = Variable<String>(agentName);
    map['available_balance_minor'] = Variable<int>(availableBalanceMinor);
    map['reserved_balance_minor'] = Variable<int>(reservedBalanceMinor);
    map['daily_spending_limit_minor'] = Variable<int>(dailySpendingLimitMinor);
    map['monthly_spending_limit_minor'] =
        Variable<int>(monthlySpendingLimitMinor);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  LocalWalletsCompanion toCompanion(bool nullToAbsent) {
    return LocalWalletsCompanion(
      id: Value(id),
      agentName: Value(agentName),
      availableBalanceMinor: Value(availableBalanceMinor),
      reservedBalanceMinor: Value(reservedBalanceMinor),
      dailySpendingLimitMinor: Value(dailySpendingLimitMinor),
      monthlySpendingLimitMinor: Value(monthlySpendingLimitMinor),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory LocalWallet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalWallet(
      id: serializer.fromJson<int>(json['id']),
      agentName: serializer.fromJson<String>(json['agentName']),
      availableBalanceMinor:
          serializer.fromJson<int>(json['availableBalanceMinor']),
      reservedBalanceMinor:
          serializer.fromJson<int>(json['reservedBalanceMinor']),
      dailySpendingLimitMinor:
          serializer.fromJson<int>(json['dailySpendingLimitMinor']),
      monthlySpendingLimitMinor:
          serializer.fromJson<int>(json['monthlySpendingLimitMinor']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'agentName': serializer.toJson<String>(agentName),
      'availableBalanceMinor': serializer.toJson<int>(availableBalanceMinor),
      'reservedBalanceMinor': serializer.toJson<int>(reservedBalanceMinor),
      'dailySpendingLimitMinor':
          serializer.toJson<int>(dailySpendingLimitMinor),
      'monthlySpendingLimitMinor':
          serializer.toJson<int>(monthlySpendingLimitMinor),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  LocalWallet copyWith(
          {int? id,
          String? agentName,
          int? availableBalanceMinor,
          int? reservedBalanceMinor,
          int? dailySpendingLimitMinor,
          int? monthlySpendingLimitMinor,
          Value<DateTime?> lastSyncedAt = const Value.absent()}) =>
      LocalWallet(
        id: id ?? this.id,
        agentName: agentName ?? this.agentName,
        availableBalanceMinor:
            availableBalanceMinor ?? this.availableBalanceMinor,
        reservedBalanceMinor: reservedBalanceMinor ?? this.reservedBalanceMinor,
        dailySpendingLimitMinor:
            dailySpendingLimitMinor ?? this.dailySpendingLimitMinor,
        monthlySpendingLimitMinor:
            monthlySpendingLimitMinor ?? this.monthlySpendingLimitMinor,
        lastSyncedAt:
            lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
      );
  LocalWallet copyWithCompanion(LocalWalletsCompanion data) {
    return LocalWallet(
      id: data.id.present ? data.id.value : this.id,
      agentName: data.agentName.present ? data.agentName.value : this.agentName,
      availableBalanceMinor: data.availableBalanceMinor.present
          ? data.availableBalanceMinor.value
          : this.availableBalanceMinor,
      reservedBalanceMinor: data.reservedBalanceMinor.present
          ? data.reservedBalanceMinor.value
          : this.reservedBalanceMinor,
      dailySpendingLimitMinor: data.dailySpendingLimitMinor.present
          ? data.dailySpendingLimitMinor.value
          : this.dailySpendingLimitMinor,
      monthlySpendingLimitMinor: data.monthlySpendingLimitMinor.present
          ? data.monthlySpendingLimitMinor.value
          : this.monthlySpendingLimitMinor,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalWallet(')
          ..write('id: $id, ')
          ..write('agentName: $agentName, ')
          ..write('availableBalanceMinor: $availableBalanceMinor, ')
          ..write('reservedBalanceMinor: $reservedBalanceMinor, ')
          ..write('dailySpendingLimitMinor: $dailySpendingLimitMinor, ')
          ..write('monthlySpendingLimitMinor: $monthlySpendingLimitMinor, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      agentName,
      availableBalanceMinor,
      reservedBalanceMinor,
      dailySpendingLimitMinor,
      monthlySpendingLimitMinor,
      lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalWallet &&
          other.id == this.id &&
          other.agentName == this.agentName &&
          other.availableBalanceMinor == this.availableBalanceMinor &&
          other.reservedBalanceMinor == this.reservedBalanceMinor &&
          other.dailySpendingLimitMinor == this.dailySpendingLimitMinor &&
          other.monthlySpendingLimitMinor == this.monthlySpendingLimitMinor &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class LocalWalletsCompanion extends UpdateCompanion<LocalWallet> {
  final Value<int> id;
  final Value<String> agentName;
  final Value<int> availableBalanceMinor;
  final Value<int> reservedBalanceMinor;
  final Value<int> dailySpendingLimitMinor;
  final Value<int> monthlySpendingLimitMinor;
  final Value<DateTime?> lastSyncedAt;
  const LocalWalletsCompanion({
    this.id = const Value.absent(),
    this.agentName = const Value.absent(),
    this.availableBalanceMinor = const Value.absent(),
    this.reservedBalanceMinor = const Value.absent(),
    this.dailySpendingLimitMinor = const Value.absent(),
    this.monthlySpendingLimitMinor = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
  });
  LocalWalletsCompanion.insert({
    this.id = const Value.absent(),
    required String agentName,
    required int availableBalanceMinor,
    this.reservedBalanceMinor = const Value.absent(),
    this.dailySpendingLimitMinor = const Value.absent(),
    this.monthlySpendingLimitMinor = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
  })  : agentName = Value(agentName),
        availableBalanceMinor = Value(availableBalanceMinor);
  static Insertable<LocalWallet> custom({
    Expression<int>? id,
    Expression<String>? agentName,
    Expression<int>? availableBalanceMinor,
    Expression<int>? reservedBalanceMinor,
    Expression<int>? dailySpendingLimitMinor,
    Expression<int>? monthlySpendingLimitMinor,
    Expression<DateTime>? lastSyncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (agentName != null) 'agent_name': agentName,
      if (availableBalanceMinor != null)
        'available_balance_minor': availableBalanceMinor,
      if (reservedBalanceMinor != null)
        'reserved_balance_minor': reservedBalanceMinor,
      if (dailySpendingLimitMinor != null)
        'daily_spending_limit_minor': dailySpendingLimitMinor,
      if (monthlySpendingLimitMinor != null)
        'monthly_spending_limit_minor': monthlySpendingLimitMinor,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
    });
  }

  LocalWalletsCompanion copyWith(
      {Value<int>? id,
      Value<String>? agentName,
      Value<int>? availableBalanceMinor,
      Value<int>? reservedBalanceMinor,
      Value<int>? dailySpendingLimitMinor,
      Value<int>? monthlySpendingLimitMinor,
      Value<DateTime?>? lastSyncedAt}) {
    return LocalWalletsCompanion(
      id: id ?? this.id,
      agentName: agentName ?? this.agentName,
      availableBalanceMinor:
          availableBalanceMinor ?? this.availableBalanceMinor,
      reservedBalanceMinor: reservedBalanceMinor ?? this.reservedBalanceMinor,
      dailySpendingLimitMinor:
          dailySpendingLimitMinor ?? this.dailySpendingLimitMinor,
      monthlySpendingLimitMinor:
          monthlySpendingLimitMinor ?? this.monthlySpendingLimitMinor,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (agentName.present) {
      map['agent_name'] = Variable<String>(agentName.value);
    }
    if (availableBalanceMinor.present) {
      map['available_balance_minor'] =
          Variable<int>(availableBalanceMinor.value);
    }
    if (reservedBalanceMinor.present) {
      map['reserved_balance_minor'] = Variable<int>(reservedBalanceMinor.value);
    }
    if (dailySpendingLimitMinor.present) {
      map['daily_spending_limit_minor'] =
          Variable<int>(dailySpendingLimitMinor.value);
    }
    if (monthlySpendingLimitMinor.present) {
      map['monthly_spending_limit_minor'] =
          Variable<int>(monthlySpendingLimitMinor.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalWalletsCompanion(')
          ..write('id: $id, ')
          ..write('agentName: $agentName, ')
          ..write('availableBalanceMinor: $availableBalanceMinor, ')
          ..write('reservedBalanceMinor: $reservedBalanceMinor, ')
          ..write('dailySpendingLimitMinor: $dailySpendingLimitMinor, ')
          ..write('monthlySpendingLimitMinor: $monthlySpendingLimitMinor, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _serviceKeyMeta =
      const VerificationMeta('serviceKey');
  @override
  late final GeneratedColumn<String> serviceKey = GeneratedColumn<String>(
      'service_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _serviceTypeMeta =
      const VerificationMeta('serviceType');
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
      'service_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _psiCodeMeta =
      const VerificationMeta('psiCode');
  @override
  late final GeneratedColumn<int> psiCode = GeneratedColumn<int>(
      'psi_code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetIdentifierMeta =
      const VerificationMeta('targetIdentifier');
  @override
  late final GeneratedColumn<String> targetIdentifier = GeneratedColumn<String>(
      'target_identifier', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _baseAmountMinorMeta =
      const VerificationMeta('baseAmountMinor');
  @override
  late final GeneratedColumn<int> baseAmountMinor = GeneratedColumn<int>(
      'base_amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _taxAmountMinorMeta =
      const VerificationMeta('taxAmountMinor');
  @override
  late final GeneratedColumn<int> taxAmountMinor = GeneratedColumn<int>(
      'tax_amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalAmountMinorMeta =
      const VerificationMeta('totalAmountMinor');
  @override
  late final GeneratedColumn<int> totalAmountMinor = GeneratedColumn<int>(
      'total_amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _channelMeta =
      const VerificationMeta('channel');
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
      'channel', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        reference,
        serviceKey,
        serviceType,
        psiCode,
        targetIdentifier,
        baseAmountMinor,
        taxAmountMinor,
        totalAmountMinor,
        status,
        channel,
        createdAt,
        syncedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('service_key')) {
      context.handle(
          _serviceKeyMeta,
          serviceKey.isAcceptableOrUnknown(
              data['service_key']!, _serviceKeyMeta));
    } else if (isInserting) {
      context.missing(_serviceKeyMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
          _serviceTypeMeta,
          serviceType.isAcceptableOrUnknown(
              data['service_type']!, _serviceTypeMeta));
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('psi_code')) {
      context.handle(_psiCodeMeta,
          psiCode.isAcceptableOrUnknown(data['psi_code']!, _psiCodeMeta));
    } else if (isInserting) {
      context.missing(_psiCodeMeta);
    }
    if (data.containsKey('target_identifier')) {
      context.handle(
          _targetIdentifierMeta,
          targetIdentifier.isAcceptableOrUnknown(
              data['target_identifier']!, _targetIdentifierMeta));
    } else if (isInserting) {
      context.missing(_targetIdentifierMeta);
    }
    if (data.containsKey('base_amount_minor')) {
      context.handle(
          _baseAmountMinorMeta,
          baseAmountMinor.isAcceptableOrUnknown(
              data['base_amount_minor']!, _baseAmountMinorMeta));
    } else if (isInserting) {
      context.missing(_baseAmountMinorMeta);
    }
    if (data.containsKey('tax_amount_minor')) {
      context.handle(
          _taxAmountMinorMeta,
          taxAmountMinor.isAcceptableOrUnknown(
              data['tax_amount_minor']!, _taxAmountMinorMeta));
    } else if (isInserting) {
      context.missing(_taxAmountMinorMeta);
    }
    if (data.containsKey('total_amount_minor')) {
      context.handle(
          _totalAmountMinorMeta,
          totalAmountMinor.isAcceptableOrUnknown(
              data['total_amount_minor']!, _totalAmountMinorMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMinorMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('channel')) {
      context.handle(_channelMeta,
          channel.isAcceptableOrUnknown(data['channel']!, _channelMeta));
    } else if (isInserting) {
      context.missing(_channelMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference'])!,
      serviceKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_key'])!,
      serviceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_type'])!,
      psiCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}psi_code'])!,
      targetIdentifier: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}target_identifier'])!,
      baseAmountMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_amount_minor'])!,
      taxAmountMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tax_amount_minor'])!,
      totalAmountMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_amount_minor'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      channel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}channel'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final String reference;
  final String serviceKey;
  final String serviceType;
  final int psiCode;
  final String targetIdentifier;
  final int baseAmountMinor;
  final int taxAmountMinor;
  final int totalAmountMinor;
  final String status;
  final String channel;
  final DateTime createdAt;
  final DateTime? syncedAt;
  const Transaction(
      {required this.id,
      required this.reference,
      required this.serviceKey,
      required this.serviceType,
      required this.psiCode,
      required this.targetIdentifier,
      required this.baseAmountMinor,
      required this.taxAmountMinor,
      required this.totalAmountMinor,
      required this.status,
      required this.channel,
      required this.createdAt,
      this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reference'] = Variable<String>(reference);
    map['service_key'] = Variable<String>(serviceKey);
    map['service_type'] = Variable<String>(serviceType);
    map['psi_code'] = Variable<int>(psiCode);
    map['target_identifier'] = Variable<String>(targetIdentifier);
    map['base_amount_minor'] = Variable<int>(baseAmountMinor);
    map['tax_amount_minor'] = Variable<int>(taxAmountMinor);
    map['total_amount_minor'] = Variable<int>(totalAmountMinor);
    map['status'] = Variable<String>(status);
    map['channel'] = Variable<String>(channel);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      reference: Value(reference),
      serviceKey: Value(serviceKey),
      serviceType: Value(serviceType),
      psiCode: Value(psiCode),
      targetIdentifier: Value(targetIdentifier),
      baseAmountMinor: Value(baseAmountMinor),
      taxAmountMinor: Value(taxAmountMinor),
      totalAmountMinor: Value(totalAmountMinor),
      status: Value(status),
      channel: Value(channel),
      createdAt: Value(createdAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      reference: serializer.fromJson<String>(json['reference']),
      serviceKey: serializer.fromJson<String>(json['serviceKey']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      psiCode: serializer.fromJson<int>(json['psiCode']),
      targetIdentifier: serializer.fromJson<String>(json['targetIdentifier']),
      baseAmountMinor: serializer.fromJson<int>(json['baseAmountMinor']),
      taxAmountMinor: serializer.fromJson<int>(json['taxAmountMinor']),
      totalAmountMinor: serializer.fromJson<int>(json['totalAmountMinor']),
      status: serializer.fromJson<String>(json['status']),
      channel: serializer.fromJson<String>(json['channel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reference': serializer.toJson<String>(reference),
      'serviceKey': serializer.toJson<String>(serviceKey),
      'serviceType': serializer.toJson<String>(serviceType),
      'psiCode': serializer.toJson<int>(psiCode),
      'targetIdentifier': serializer.toJson<String>(targetIdentifier),
      'baseAmountMinor': serializer.toJson<int>(baseAmountMinor),
      'taxAmountMinor': serializer.toJson<int>(taxAmountMinor),
      'totalAmountMinor': serializer.toJson<int>(totalAmountMinor),
      'status': serializer.toJson<String>(status),
      'channel': serializer.toJson<String>(channel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
    };
  }

  Transaction copyWith(
          {int? id,
          String? reference,
          String? serviceKey,
          String? serviceType,
          int? psiCode,
          String? targetIdentifier,
          int? baseAmountMinor,
          int? taxAmountMinor,
          int? totalAmountMinor,
          String? status,
          String? channel,
          DateTime? createdAt,
          Value<DateTime?> syncedAt = const Value.absent()}) =>
      Transaction(
        id: id ?? this.id,
        reference: reference ?? this.reference,
        serviceKey: serviceKey ?? this.serviceKey,
        serviceType: serviceType ?? this.serviceType,
        psiCode: psiCode ?? this.psiCode,
        targetIdentifier: targetIdentifier ?? this.targetIdentifier,
        baseAmountMinor: baseAmountMinor ?? this.baseAmountMinor,
        taxAmountMinor: taxAmountMinor ?? this.taxAmountMinor,
        totalAmountMinor: totalAmountMinor ?? this.totalAmountMinor,
        status: status ?? this.status,
        channel: channel ?? this.channel,
        createdAt: createdAt ?? this.createdAt,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      reference: data.reference.present ? data.reference.value : this.reference,
      serviceKey:
          data.serviceKey.present ? data.serviceKey.value : this.serviceKey,
      serviceType:
          data.serviceType.present ? data.serviceType.value : this.serviceType,
      psiCode: data.psiCode.present ? data.psiCode.value : this.psiCode,
      targetIdentifier: data.targetIdentifier.present
          ? data.targetIdentifier.value
          : this.targetIdentifier,
      baseAmountMinor: data.baseAmountMinor.present
          ? data.baseAmountMinor.value
          : this.baseAmountMinor,
      taxAmountMinor: data.taxAmountMinor.present
          ? data.taxAmountMinor.value
          : this.taxAmountMinor,
      totalAmountMinor: data.totalAmountMinor.present
          ? data.totalAmountMinor.value
          : this.totalAmountMinor,
      status: data.status.present ? data.status.value : this.status,
      channel: data.channel.present ? data.channel.value : this.channel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('serviceType: $serviceType, ')
          ..write('psiCode: $psiCode, ')
          ..write('targetIdentifier: $targetIdentifier, ')
          ..write('baseAmountMinor: $baseAmountMinor, ')
          ..write('taxAmountMinor: $taxAmountMinor, ')
          ..write('totalAmountMinor: $totalAmountMinor, ')
          ..write('status: $status, ')
          ..write('channel: $channel, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      reference,
      serviceKey,
      serviceType,
      psiCode,
      targetIdentifier,
      baseAmountMinor,
      taxAmountMinor,
      totalAmountMinor,
      status,
      channel,
      createdAt,
      syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.reference == this.reference &&
          other.serviceKey == this.serviceKey &&
          other.serviceType == this.serviceType &&
          other.psiCode == this.psiCode &&
          other.targetIdentifier == this.targetIdentifier &&
          other.baseAmountMinor == this.baseAmountMinor &&
          other.taxAmountMinor == this.taxAmountMinor &&
          other.totalAmountMinor == this.totalAmountMinor &&
          other.status == this.status &&
          other.channel == this.channel &&
          other.createdAt == this.createdAt &&
          other.syncedAt == this.syncedAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<String> reference;
  final Value<String> serviceKey;
  final Value<String> serviceType;
  final Value<int> psiCode;
  final Value<String> targetIdentifier;
  final Value<int> baseAmountMinor;
  final Value<int> taxAmountMinor;
  final Value<int> totalAmountMinor;
  final Value<String> status;
  final Value<String> channel;
  final Value<DateTime> createdAt;
  final Value<DateTime?> syncedAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.reference = const Value.absent(),
    this.serviceKey = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.psiCode = const Value.absent(),
    this.targetIdentifier = const Value.absent(),
    this.baseAmountMinor = const Value.absent(),
    this.taxAmountMinor = const Value.absent(),
    this.totalAmountMinor = const Value.absent(),
    this.status = const Value.absent(),
    this.channel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String reference,
    required String serviceKey,
    required String serviceType,
    required int psiCode,
    required String targetIdentifier,
    required int baseAmountMinor,
    required int taxAmountMinor,
    required int totalAmountMinor,
    required String status,
    required String channel,
    this.createdAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
  })  : reference = Value(reference),
        serviceKey = Value(serviceKey),
        serviceType = Value(serviceType),
        psiCode = Value(psiCode),
        targetIdentifier = Value(targetIdentifier),
        baseAmountMinor = Value(baseAmountMinor),
        taxAmountMinor = Value(taxAmountMinor),
        totalAmountMinor = Value(totalAmountMinor),
        status = Value(status),
        channel = Value(channel);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<String>? reference,
    Expression<String>? serviceKey,
    Expression<String>? serviceType,
    Expression<int>? psiCode,
    Expression<String>? targetIdentifier,
    Expression<int>? baseAmountMinor,
    Expression<int>? taxAmountMinor,
    Expression<int>? totalAmountMinor,
    Expression<String>? status,
    Expression<String>? channel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reference != null) 'reference': reference,
      if (serviceKey != null) 'service_key': serviceKey,
      if (serviceType != null) 'service_type': serviceType,
      if (psiCode != null) 'psi_code': psiCode,
      if (targetIdentifier != null) 'target_identifier': targetIdentifier,
      if (baseAmountMinor != null) 'base_amount_minor': baseAmountMinor,
      if (taxAmountMinor != null) 'tax_amount_minor': taxAmountMinor,
      if (totalAmountMinor != null) 'total_amount_minor': totalAmountMinor,
      if (status != null) 'status': status,
      if (channel != null) 'channel': channel,
      if (createdAt != null) 'created_at': createdAt,
      if (syncedAt != null) 'synced_at': syncedAt,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? reference,
      Value<String>? serviceKey,
      Value<String>? serviceType,
      Value<int>? psiCode,
      Value<String>? targetIdentifier,
      Value<int>? baseAmountMinor,
      Value<int>? taxAmountMinor,
      Value<int>? totalAmountMinor,
      Value<String>? status,
      Value<String>? channel,
      Value<DateTime>? createdAt,
      Value<DateTime?>? syncedAt}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      serviceKey: serviceKey ?? this.serviceKey,
      serviceType: serviceType ?? this.serviceType,
      psiCode: psiCode ?? this.psiCode,
      targetIdentifier: targetIdentifier ?? this.targetIdentifier,
      baseAmountMinor: baseAmountMinor ?? this.baseAmountMinor,
      taxAmountMinor: taxAmountMinor ?? this.taxAmountMinor,
      totalAmountMinor: totalAmountMinor ?? this.totalAmountMinor,
      status: status ?? this.status,
      channel: channel ?? this.channel,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (serviceKey.present) {
      map['service_key'] = Variable<String>(serviceKey.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (psiCode.present) {
      map['psi_code'] = Variable<int>(psiCode.value);
    }
    if (targetIdentifier.present) {
      map['target_identifier'] = Variable<String>(targetIdentifier.value);
    }
    if (baseAmountMinor.present) {
      map['base_amount_minor'] = Variable<int>(baseAmountMinor.value);
    }
    if (taxAmountMinor.present) {
      map['tax_amount_minor'] = Variable<int>(taxAmountMinor.value);
    }
    if (totalAmountMinor.present) {
      map['total_amount_minor'] = Variable<int>(totalAmountMinor.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('serviceType: $serviceType, ')
          ..write('psiCode: $psiCode, ')
          ..write('targetIdentifier: $targetIdentifier, ')
          ..write('baseAmountMinor: $baseAmountMinor, ')
          ..write('taxAmountMinor: $taxAmountMinor, ')
          ..write('totalAmountMinor: $totalAmountMinor, ')
          ..write('status: $status, ')
          ..write('channel: $channel, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $ServicesCatalogTable extends ServicesCatalog
    with TableInfo<$ServicesCatalogTable, ServicesCatalogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesCatalogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _serviceKeyMeta =
      const VerificationMeta('serviceKey');
  @override
  late final GeneratedColumn<String> serviceKey = GeneratedColumn<String>(
      'service_key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerMeta =
      const VerificationMeta('provider');
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
      'provider', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _psiCodeMeta =
      const VerificationMeta('psiCode');
  @override
  late final GeneratedColumn<int> psiCode = GeneratedColumn<int>(
      'psi_code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TaxClassification, String>
      taxClass = GeneratedColumn<String>('tax_class', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TaxClassification>(
              $ServicesCatalogTable.$convertertaxClass);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<DateTime> lastUpdatedAt =
      GeneratedColumn<DateTime>('last_updated_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        serviceKey,
        nameAr,
        nameEn,
        category,
        provider,
        psiCode,
        taxClass,
        isActive,
        lastUpdatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services_catalog';
  @override
  VerificationContext validateIntegrity(
      Insertable<ServicesCatalogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('service_key')) {
      context.handle(
          _serviceKeyMeta,
          serviceKey.isAcceptableOrUnknown(
              data['service_key']!, _serviceKeyMeta));
    } else if (isInserting) {
      context.missing(_serviceKeyMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(_providerMeta,
          provider.isAcceptableOrUnknown(data['provider']!, _providerMeta));
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('psi_code')) {
      context.handle(_psiCodeMeta,
          psiCode.isAcceptableOrUnknown(data['psi_code']!, _psiCodeMeta));
    } else if (isInserting) {
      context.missing(_psiCodeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServicesCatalogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServicesCatalogData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      serviceKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_key'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      provider: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider'])!,
      psiCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}psi_code'])!,
      taxClass: $ServicesCatalogTable.$convertertaxClass.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}tax_class'])!),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      lastUpdatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_updated_at']),
    );
  }

  @override
  $ServicesCatalogTable createAlias(String alias) {
    return $ServicesCatalogTable(attachedDatabase, alias);
  }

  static TypeConverter<TaxClassification, String> $convertertaxClass =
      const TaxClassificationConverter();
}

class ServicesCatalogData extends DataClass
    implements Insertable<ServicesCatalogData> {
  final int id;
  final String serviceKey;
  final String nameAr;
  final String nameEn;
  final String category;
  final String provider;
  final int psiCode;
  final TaxClassification taxClass;
  final bool isActive;
  final DateTime? lastUpdatedAt;
  const ServicesCatalogData(
      {required this.id,
      required this.serviceKey,
      required this.nameAr,
      required this.nameEn,
      required this.category,
      required this.provider,
      required this.psiCode,
      required this.taxClass,
      required this.isActive,
      this.lastUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['service_key'] = Variable<String>(serviceKey);
    map['name_ar'] = Variable<String>(nameAr);
    map['name_en'] = Variable<String>(nameEn);
    map['category'] = Variable<String>(category);
    map['provider'] = Variable<String>(provider);
    map['psi_code'] = Variable<int>(psiCode);
    {
      map['tax_class'] = Variable<String>(
          $ServicesCatalogTable.$convertertaxClass.toSql(taxClass));
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastUpdatedAt != null) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt);
    }
    return map;
  }

  ServicesCatalogCompanion toCompanion(bool nullToAbsent) {
    return ServicesCatalogCompanion(
      id: Value(id),
      serviceKey: Value(serviceKey),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      category: Value(category),
      provider: Value(provider),
      psiCode: Value(psiCode),
      taxClass: Value(taxClass),
      isActive: Value(isActive),
      lastUpdatedAt: lastUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedAt),
    );
  }

  factory ServicesCatalogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServicesCatalogData(
      id: serializer.fromJson<int>(json['id']),
      serviceKey: serializer.fromJson<String>(json['serviceKey']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      category: serializer.fromJson<String>(json['category']),
      provider: serializer.fromJson<String>(json['provider']),
      psiCode: serializer.fromJson<int>(json['psiCode']),
      taxClass: serializer.fromJson<TaxClassification>(json['taxClass']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastUpdatedAt: serializer.fromJson<DateTime?>(json['lastUpdatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serviceKey': serializer.toJson<String>(serviceKey),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String>(nameEn),
      'category': serializer.toJson<String>(category),
      'provider': serializer.toJson<String>(provider),
      'psiCode': serializer.toJson<int>(psiCode),
      'taxClass': serializer.toJson<TaxClassification>(taxClass),
      'isActive': serializer.toJson<bool>(isActive),
      'lastUpdatedAt': serializer.toJson<DateTime?>(lastUpdatedAt),
    };
  }

  ServicesCatalogData copyWith(
          {int? id,
          String? serviceKey,
          String? nameAr,
          String? nameEn,
          String? category,
          String? provider,
          int? psiCode,
          TaxClassification? taxClass,
          bool? isActive,
          Value<DateTime?> lastUpdatedAt = const Value.absent()}) =>
      ServicesCatalogData(
        id: id ?? this.id,
        serviceKey: serviceKey ?? this.serviceKey,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        category: category ?? this.category,
        provider: provider ?? this.provider,
        psiCode: psiCode ?? this.psiCode,
        taxClass: taxClass ?? this.taxClass,
        isActive: isActive ?? this.isActive,
        lastUpdatedAt:
            lastUpdatedAt.present ? lastUpdatedAt.value : this.lastUpdatedAt,
      );
  ServicesCatalogData copyWithCompanion(ServicesCatalogCompanion data) {
    return ServicesCatalogData(
      id: data.id.present ? data.id.value : this.id,
      serviceKey:
          data.serviceKey.present ? data.serviceKey.value : this.serviceKey,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      category: data.category.present ? data.category.value : this.category,
      provider: data.provider.present ? data.provider.value : this.provider,
      psiCode: data.psiCode.present ? data.psiCode.value : this.psiCode,
      taxClass: data.taxClass.present ? data.taxClass.value : this.taxClass,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCatalogData(')
          ..write('id: $id, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('category: $category, ')
          ..write('provider: $provider, ')
          ..write('psiCode: $psiCode, ')
          ..write('taxClass: $taxClass, ')
          ..write('isActive: $isActive, ')
          ..write('lastUpdatedAt: $lastUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, serviceKey, nameAr, nameEn, category,
      provider, psiCode, taxClass, isActive, lastUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServicesCatalogData &&
          other.id == this.id &&
          other.serviceKey == this.serviceKey &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.category == this.category &&
          other.provider == this.provider &&
          other.psiCode == this.psiCode &&
          other.taxClass == this.taxClass &&
          other.isActive == this.isActive &&
          other.lastUpdatedAt == this.lastUpdatedAt);
}

class ServicesCatalogCompanion extends UpdateCompanion<ServicesCatalogData> {
  final Value<int> id;
  final Value<String> serviceKey;
  final Value<String> nameAr;
  final Value<String> nameEn;
  final Value<String> category;
  final Value<String> provider;
  final Value<int> psiCode;
  final Value<TaxClassification> taxClass;
  final Value<bool> isActive;
  final Value<DateTime?> lastUpdatedAt;
  const ServicesCatalogCompanion({
    this.id = const Value.absent(),
    this.serviceKey = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.category = const Value.absent(),
    this.provider = const Value.absent(),
    this.psiCode = const Value.absent(),
    this.taxClass = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
  });
  ServicesCatalogCompanion.insert({
    this.id = const Value.absent(),
    required String serviceKey,
    required String nameAr,
    required String nameEn,
    required String category,
    required String provider,
    required int psiCode,
    required TaxClassification taxClass,
    this.isActive = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
  })  : serviceKey = Value(serviceKey),
        nameAr = Value(nameAr),
        nameEn = Value(nameEn),
        category = Value(category),
        provider = Value(provider),
        psiCode = Value(psiCode),
        taxClass = Value(taxClass);
  static Insertable<ServicesCatalogData> custom({
    Expression<int>? id,
    Expression<String>? serviceKey,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<String>? category,
    Expression<String>? provider,
    Expression<int>? psiCode,
    Expression<String>? taxClass,
    Expression<bool>? isActive,
    Expression<DateTime>? lastUpdatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serviceKey != null) 'service_key': serviceKey,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (category != null) 'category': category,
      if (provider != null) 'provider': provider,
      if (psiCode != null) 'psi_code': psiCode,
      if (taxClass != null) 'tax_class': taxClass,
      if (isActive != null) 'is_active': isActive,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
    });
  }

  ServicesCatalogCompanion copyWith(
      {Value<int>? id,
      Value<String>? serviceKey,
      Value<String>? nameAr,
      Value<String>? nameEn,
      Value<String>? category,
      Value<String>? provider,
      Value<int>? psiCode,
      Value<TaxClassification>? taxClass,
      Value<bool>? isActive,
      Value<DateTime?>? lastUpdatedAt}) {
    return ServicesCatalogCompanion(
      id: id ?? this.id,
      serviceKey: serviceKey ?? this.serviceKey,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      category: category ?? this.category,
      provider: provider ?? this.provider,
      psiCode: psiCode ?? this.psiCode,
      taxClass: taxClass ?? this.taxClass,
      isActive: isActive ?? this.isActive,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serviceKey.present) {
      map['service_key'] = Variable<String>(serviceKey.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (psiCode.present) {
      map['psi_code'] = Variable<int>(psiCode.value);
    }
    if (taxClass.present) {
      map['tax_class'] = Variable<String>(
          $ServicesCatalogTable.$convertertaxClass.toSql(taxClass.value));
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<DateTime>(lastUpdatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCatalogCompanion(')
          ..write('id: $id, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('category: $category, ')
          ..write('provider: $provider, ')
          ..write('psiCode: $psiCode, ')
          ..write('taxClass: $taxClass, ')
          ..write('isActive: $isActive, ')
          ..write('lastUpdatedAt: $lastUpdatedAt')
          ..write(')'))
        .toString();
  }
}

class $PendingSmsQueueTable extends PendingSmsQueue
    with TableInfo<$PendingSmsQueueTable, PendingSmsQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingSmsQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _serviceKeyMeta =
      const VerificationMeta('serviceKey');
  @override
  late final GeneratedColumn<String> serviceKey = GeneratedColumn<String>(
      'service_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _destinationNumberMeta =
      const VerificationMeta('destinationNumber');
  @override
  late final GeneratedColumn<String> destinationNumber =
      GeneratedColumn<String>('destination_number', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _smsBodyMeta =
      const VerificationMeta('smsBody');
  @override
  late final GeneratedColumn<String> smsBody = GeneratedColumn<String>(
      'sms_body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _processedAtMeta =
      const VerificationMeta('processedAt');
  @override
  late final GeneratedColumn<DateTime> processedAt = GeneratedColumn<DateTime>(
      'processed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        reference,
        serviceKey,
        destinationNumber,
        smsBody,
        status,
        createdAt,
        processedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_sms_queue';
  @override
  VerificationContext validateIntegrity(
      Insertable<PendingSmsQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('service_key')) {
      context.handle(
          _serviceKeyMeta,
          serviceKey.isAcceptableOrUnknown(
              data['service_key']!, _serviceKeyMeta));
    } else if (isInserting) {
      context.missing(_serviceKeyMeta);
    }
    if (data.containsKey('destination_number')) {
      context.handle(
          _destinationNumberMeta,
          destinationNumber.isAcceptableOrUnknown(
              data['destination_number']!, _destinationNumberMeta));
    } else if (isInserting) {
      context.missing(_destinationNumberMeta);
    }
    if (data.containsKey('sms_body')) {
      context.handle(_smsBodyMeta,
          smsBody.isAcceptableOrUnknown(data['sms_body']!, _smsBodyMeta));
    } else if (isInserting) {
      context.missing(_smsBodyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('processed_at')) {
      context.handle(
          _processedAtMeta,
          processedAt.isAcceptableOrUnknown(
              data['processed_at']!, _processedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingSmsQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingSmsQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference'])!,
      serviceKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_key'])!,
      destinationNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}destination_number'])!,
      smsBody: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sms_body'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      processedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}processed_at']),
    );
  }

  @override
  $PendingSmsQueueTable createAlias(String alias) {
    return $PendingSmsQueueTable(attachedDatabase, alias);
  }
}

class PendingSmsQueueData extends DataClass
    implements Insertable<PendingSmsQueueData> {
  final int id;
  final String reference;
  final String serviceKey;
  final String destinationNumber;
  final String smsBody;
  final String status;
  final DateTime createdAt;
  final DateTime? processedAt;
  const PendingSmsQueueData(
      {required this.id,
      required this.reference,
      required this.serviceKey,
      required this.destinationNumber,
      required this.smsBody,
      required this.status,
      required this.createdAt,
      this.processedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reference'] = Variable<String>(reference);
    map['service_key'] = Variable<String>(serviceKey);
    map['destination_number'] = Variable<String>(destinationNumber);
    map['sms_body'] = Variable<String>(smsBody);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || processedAt != null) {
      map['processed_at'] = Variable<DateTime>(processedAt);
    }
    return map;
  }

  PendingSmsQueueCompanion toCompanion(bool nullToAbsent) {
    return PendingSmsQueueCompanion(
      id: Value(id),
      reference: Value(reference),
      serviceKey: Value(serviceKey),
      destinationNumber: Value(destinationNumber),
      smsBody: Value(smsBody),
      status: Value(status),
      createdAt: Value(createdAt),
      processedAt: processedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(processedAt),
    );
  }

  factory PendingSmsQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingSmsQueueData(
      id: serializer.fromJson<int>(json['id']),
      reference: serializer.fromJson<String>(json['reference']),
      serviceKey: serializer.fromJson<String>(json['serviceKey']),
      destinationNumber: serializer.fromJson<String>(json['destinationNumber']),
      smsBody: serializer.fromJson<String>(json['smsBody']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      processedAt: serializer.fromJson<DateTime?>(json['processedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reference': serializer.toJson<String>(reference),
      'serviceKey': serializer.toJson<String>(serviceKey),
      'destinationNumber': serializer.toJson<String>(destinationNumber),
      'smsBody': serializer.toJson<String>(smsBody),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'processedAt': serializer.toJson<DateTime?>(processedAt),
    };
  }

  PendingSmsQueueData copyWith(
          {int? id,
          String? reference,
          String? serviceKey,
          String? destinationNumber,
          String? smsBody,
          String? status,
          DateTime? createdAt,
          Value<DateTime?> processedAt = const Value.absent()}) =>
      PendingSmsQueueData(
        id: id ?? this.id,
        reference: reference ?? this.reference,
        serviceKey: serviceKey ?? this.serviceKey,
        destinationNumber: destinationNumber ?? this.destinationNumber,
        smsBody: smsBody ?? this.smsBody,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        processedAt: processedAt.present ? processedAt.value : this.processedAt,
      );
  PendingSmsQueueData copyWithCompanion(PendingSmsQueueCompanion data) {
    return PendingSmsQueueData(
      id: data.id.present ? data.id.value : this.id,
      reference: data.reference.present ? data.reference.value : this.reference,
      serviceKey:
          data.serviceKey.present ? data.serviceKey.value : this.serviceKey,
      destinationNumber: data.destinationNumber.present
          ? data.destinationNumber.value
          : this.destinationNumber,
      smsBody: data.smsBody.present ? data.smsBody.value : this.smsBody,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      processedAt:
          data.processedAt.present ? data.processedAt.value : this.processedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingSmsQueueData(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('destinationNumber: $destinationNumber, ')
          ..write('smsBody: $smsBody, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('processedAt: $processedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reference, serviceKey, destinationNumber,
      smsBody, status, createdAt, processedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingSmsQueueData &&
          other.id == this.id &&
          other.reference == this.reference &&
          other.serviceKey == this.serviceKey &&
          other.destinationNumber == this.destinationNumber &&
          other.smsBody == this.smsBody &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.processedAt == this.processedAt);
}

class PendingSmsQueueCompanion extends UpdateCompanion<PendingSmsQueueData> {
  final Value<int> id;
  final Value<String> reference;
  final Value<String> serviceKey;
  final Value<String> destinationNumber;
  final Value<String> smsBody;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> processedAt;
  const PendingSmsQueueCompanion({
    this.id = const Value.absent(),
    this.reference = const Value.absent(),
    this.serviceKey = const Value.absent(),
    this.destinationNumber = const Value.absent(),
    this.smsBody = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.processedAt = const Value.absent(),
  });
  PendingSmsQueueCompanion.insert({
    this.id = const Value.absent(),
    required String reference,
    required String serviceKey,
    required String destinationNumber,
    required String smsBody,
    required String status,
    this.createdAt = const Value.absent(),
    this.processedAt = const Value.absent(),
  })  : reference = Value(reference),
        serviceKey = Value(serviceKey),
        destinationNumber = Value(destinationNumber),
        smsBody = Value(smsBody),
        status = Value(status);
  static Insertable<PendingSmsQueueData> custom({
    Expression<int>? id,
    Expression<String>? reference,
    Expression<String>? serviceKey,
    Expression<String>? destinationNumber,
    Expression<String>? smsBody,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? processedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reference != null) 'reference': reference,
      if (serviceKey != null) 'service_key': serviceKey,
      if (destinationNumber != null) 'destination_number': destinationNumber,
      if (smsBody != null) 'sms_body': smsBody,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (processedAt != null) 'processed_at': processedAt,
    });
  }

  PendingSmsQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? reference,
      Value<String>? serviceKey,
      Value<String>? destinationNumber,
      Value<String>? smsBody,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime?>? processedAt}) {
    return PendingSmsQueueCompanion(
      id: id ?? this.id,
      reference: reference ?? this.reference,
      serviceKey: serviceKey ?? this.serviceKey,
      destinationNumber: destinationNumber ?? this.destinationNumber,
      smsBody: smsBody ?? this.smsBody,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      processedAt: processedAt ?? this.processedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (serviceKey.present) {
      map['service_key'] = Variable<String>(serviceKey.value);
    }
    if (destinationNumber.present) {
      map['destination_number'] = Variable<String>(destinationNumber.value);
    }
    if (smsBody.present) {
      map['sms_body'] = Variable<String>(smsBody.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (processedAt.present) {
      map['processed_at'] = Variable<DateTime>(processedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingSmsQueueCompanion(')
          ..write('id: $id, ')
          ..write('reference: $reference, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('destinationNumber: $destinationNumber, ')
          ..write('smsBody: $smsBody, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('processedAt: $processedAt')
          ..write(')'))
        .toString();
  }
}

class $SubAccountsTable extends SubAccounts
    with TableInfo<$SubAccountsTable, SubAccount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pinCodeMeta =
      const VerificationMeta('pinCode');
  @override
  late final GeneratedColumn<String> pinCode = GeneratedColumn<String>(
      'pin_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _dailySpendingLimitMinorMeta =
      const VerificationMeta('dailySpendingLimitMinor');
  @override
  late final GeneratedColumn<int> dailySpendingLimitMinor =
      GeneratedColumn<int>('daily_spending_limit_minor', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(50000));
  static const VerificationMeta _monthlySpendingLimitMinorMeta =
      const VerificationMeta('monthlySpendingLimitMinor');
  @override
  late final GeneratedColumn<int> monthlySpendingLimitMinor =
      GeneratedColumn<int>('monthly_spending_limit_minor', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(500000));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        displayName,
        pinCode,
        isActive,
        dailySpendingLimitMinor,
        monthlySpendingLimitMinor,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sub_accounts';
  @override
  VerificationContext validateIntegrity(Insertable<SubAccount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('pin_code')) {
      context.handle(_pinCodeMeta,
          pinCode.isAcceptableOrUnknown(data['pin_code']!, _pinCodeMeta));
    } else if (isInserting) {
      context.missing(_pinCodeMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('daily_spending_limit_minor')) {
      context.handle(
          _dailySpendingLimitMinorMeta,
          dailySpendingLimitMinor.isAcceptableOrUnknown(
              data['daily_spending_limit_minor']!,
              _dailySpendingLimitMinorMeta));
    }
    if (data.containsKey('monthly_spending_limit_minor')) {
      context.handle(
          _monthlySpendingLimitMinorMeta,
          monthlySpendingLimitMinor.isAcceptableOrUnknown(
              data['monthly_spending_limit_minor']!,
              _monthlySpendingLimitMinorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubAccount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubAccount(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      pinCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pin_code'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      dailySpendingLimitMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}daily_spending_limit_minor'])!,
      monthlySpendingLimitMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}monthly_spending_limit_minor'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $SubAccountsTable createAlias(String alias) {
    return $SubAccountsTable(attachedDatabase, alias);
  }
}

class SubAccount extends DataClass implements Insertable<SubAccount> {
  final int id;
  final String displayName;
  final String pinCode;
  final bool isActive;
  final int dailySpendingLimitMinor;
  final int monthlySpendingLimitMinor;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const SubAccount(
      {required this.id,
      required this.displayName,
      required this.pinCode,
      required this.isActive,
      required this.dailySpendingLimitMinor,
      required this.monthlySpendingLimitMinor,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    map['pin_code'] = Variable<String>(pinCode);
    map['is_active'] = Variable<bool>(isActive);
    map['daily_spending_limit_minor'] = Variable<int>(dailySpendingLimitMinor);
    map['monthly_spending_limit_minor'] =
        Variable<int>(monthlySpendingLimitMinor);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SubAccountsCompanion toCompanion(bool nullToAbsent) {
    return SubAccountsCompanion(
      id: Value(id),
      displayName: Value(displayName),
      pinCode: Value(pinCode),
      isActive: Value(isActive),
      dailySpendingLimitMinor: Value(dailySpendingLimitMinor),
      monthlySpendingLimitMinor: Value(monthlySpendingLimitMinor),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory SubAccount.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubAccount(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      pinCode: serializer.fromJson<String>(json['pinCode']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      dailySpendingLimitMinor:
          serializer.fromJson<int>(json['dailySpendingLimitMinor']),
      monthlySpendingLimitMinor:
          serializer.fromJson<int>(json['monthlySpendingLimitMinor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'pinCode': serializer.toJson<String>(pinCode),
      'isActive': serializer.toJson<bool>(isActive),
      'dailySpendingLimitMinor':
          serializer.toJson<int>(dailySpendingLimitMinor),
      'monthlySpendingLimitMinor':
          serializer.toJson<int>(monthlySpendingLimitMinor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  SubAccount copyWith(
          {int? id,
          String? displayName,
          String? pinCode,
          bool? isActive,
          int? dailySpendingLimitMinor,
          int? monthlySpendingLimitMinor,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      SubAccount(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        pinCode: pinCode ?? this.pinCode,
        isActive: isActive ?? this.isActive,
        dailySpendingLimitMinor:
            dailySpendingLimitMinor ?? this.dailySpendingLimitMinor,
        monthlySpendingLimitMinor:
            monthlySpendingLimitMinor ?? this.monthlySpendingLimitMinor,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  SubAccount copyWithCompanion(SubAccountsCompanion data) {
    return SubAccount(
      id: data.id.present ? data.id.value : this.id,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      pinCode: data.pinCode.present ? data.pinCode.value : this.pinCode,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      dailySpendingLimitMinor: data.dailySpendingLimitMinor.present
          ? data.dailySpendingLimitMinor.value
          : this.dailySpendingLimitMinor,
      monthlySpendingLimitMinor: data.monthlySpendingLimitMinor.present
          ? data.monthlySpendingLimitMinor.value
          : this.monthlySpendingLimitMinor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubAccount(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('pinCode: $pinCode, ')
          ..write('isActive: $isActive, ')
          ..write('dailySpendingLimitMinor: $dailySpendingLimitMinor, ')
          ..write('monthlySpendingLimitMinor: $monthlySpendingLimitMinor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, displayName, pinCode, isActive,
      dailySpendingLimitMinor, monthlySpendingLimitMinor, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubAccount &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.pinCode == this.pinCode &&
          other.isActive == this.isActive &&
          other.dailySpendingLimitMinor == this.dailySpendingLimitMinor &&
          other.monthlySpendingLimitMinor == this.monthlySpendingLimitMinor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubAccountsCompanion extends UpdateCompanion<SubAccount> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<String> pinCode;
  final Value<bool> isActive;
  final Value<int> dailySpendingLimitMinor;
  final Value<int> monthlySpendingLimitMinor;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const SubAccountsCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.pinCode = const Value.absent(),
    this.isActive = const Value.absent(),
    this.dailySpendingLimitMinor = const Value.absent(),
    this.monthlySpendingLimitMinor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubAccountsCompanion.insert({
    this.id = const Value.absent(),
    required String displayName,
    required String pinCode,
    this.isActive = const Value.absent(),
    this.dailySpendingLimitMinor = const Value.absent(),
    this.monthlySpendingLimitMinor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : displayName = Value(displayName),
        pinCode = Value(pinCode);
  static Insertable<SubAccount> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<String>? pinCode,
    Expression<bool>? isActive,
    Expression<int>? dailySpendingLimitMinor,
    Expression<int>? monthlySpendingLimitMinor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (pinCode != null) 'pin_code': pinCode,
      if (isActive != null) 'is_active': isActive,
      if (dailySpendingLimitMinor != null)
        'daily_spending_limit_minor': dailySpendingLimitMinor,
      if (monthlySpendingLimitMinor != null)
        'monthly_spending_limit_minor': monthlySpendingLimitMinor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubAccountsCompanion copyWith(
      {Value<int>? id,
      Value<String>? displayName,
      Value<String>? pinCode,
      Value<bool>? isActive,
      Value<int>? dailySpendingLimitMinor,
      Value<int>? monthlySpendingLimitMinor,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return SubAccountsCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      pinCode: pinCode ?? this.pinCode,
      isActive: isActive ?? this.isActive,
      dailySpendingLimitMinor:
          dailySpendingLimitMinor ?? this.dailySpendingLimitMinor,
      monthlySpendingLimitMinor:
          monthlySpendingLimitMinor ?? this.monthlySpendingLimitMinor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (pinCode.present) {
      map['pin_code'] = Variable<String>(pinCode.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (dailySpendingLimitMinor.present) {
      map['daily_spending_limit_minor'] =
          Variable<int>(dailySpendingLimitMinor.value);
    }
    if (monthlySpendingLimitMinor.present) {
      map['monthly_spending_limit_minor'] =
          Variable<int>(monthlySpendingLimitMinor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubAccountsCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('pinCode: $pinCode, ')
          ..write('isActive: $isActive, ')
          ..write('dailySpendingLimitMinor: $dailySpendingLimitMinor, ')
          ..write('monthlySpendingLimitMinor: $monthlySpendingLimitMinor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CommissionLogsTable extends CommissionLogs
    with TableInfo<$CommissionLogsTable, CommissionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommissionLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _transactionReferenceMeta =
      const VerificationMeta('transactionReference');
  @override
  late final GeneratedColumn<String> transactionReference =
      GeneratedColumn<String>('transaction_reference', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _serviceKeyMeta =
      const VerificationMeta('serviceKey');
  @override
  late final GeneratedColumn<String> serviceKey = GeneratedColumn<String>(
      'service_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _baseAmountMinorMeta =
      const VerificationMeta('baseAmountMinor');
  @override
  late final GeneratedColumn<int> baseAmountMinor = GeneratedColumn<int>(
      'base_amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalAmountMinorMeta =
      const VerificationMeta('totalAmountMinor');
  @override
  late final GeneratedColumn<int> totalAmountMinor = GeneratedColumn<int>(
      'total_amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _commissionAmountMinorMeta =
      const VerificationMeta('commissionAmountMinor');
  @override
  late final GeneratedColumn<int> commissionAmountMinor = GeneratedColumn<int>(
      'commission_amount_minor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        transactionReference,
        serviceKey,
        baseAmountMinor,
        totalAmountMinor,
        commissionAmountMinor,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commission_logs';
  @override
  VerificationContext validateIntegrity(Insertable<CommissionLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_reference')) {
      context.handle(
          _transactionReferenceMeta,
          transactionReference.isAcceptableOrUnknown(
              data['transaction_reference']!, _transactionReferenceMeta));
    } else if (isInserting) {
      context.missing(_transactionReferenceMeta);
    }
    if (data.containsKey('service_key')) {
      context.handle(
          _serviceKeyMeta,
          serviceKey.isAcceptableOrUnknown(
              data['service_key']!, _serviceKeyMeta));
    } else if (isInserting) {
      context.missing(_serviceKeyMeta);
    }
    if (data.containsKey('base_amount_minor')) {
      context.handle(
          _baseAmountMinorMeta,
          baseAmountMinor.isAcceptableOrUnknown(
              data['base_amount_minor']!, _baseAmountMinorMeta));
    } else if (isInserting) {
      context.missing(_baseAmountMinorMeta);
    }
    if (data.containsKey('total_amount_minor')) {
      context.handle(
          _totalAmountMinorMeta,
          totalAmountMinor.isAcceptableOrUnknown(
              data['total_amount_minor']!, _totalAmountMinorMeta));
    } else if (isInserting) {
      context.missing(_totalAmountMinorMeta);
    }
    if (data.containsKey('commission_amount_minor')) {
      context.handle(
          _commissionAmountMinorMeta,
          commissionAmountMinor.isAcceptableOrUnknown(
              data['commission_amount_minor']!, _commissionAmountMinorMeta));
    } else if (isInserting) {
      context.missing(_commissionAmountMinorMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommissionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommissionLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      transactionReference: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}transaction_reference'])!,
      serviceKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_key'])!,
      baseAmountMinor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_amount_minor'])!,
      totalAmountMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}total_amount_minor'])!,
      commissionAmountMinor: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}commission_amount_minor'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CommissionLogsTable createAlias(String alias) {
    return $CommissionLogsTable(attachedDatabase, alias);
  }
}

class CommissionLog extends DataClass implements Insertable<CommissionLog> {
  final int id;
  final String transactionReference;
  final String serviceKey;
  final int baseAmountMinor;
  final int totalAmountMinor;
  final int commissionAmountMinor;
  final DateTime createdAt;
  const CommissionLog(
      {required this.id,
      required this.transactionReference,
      required this.serviceKey,
      required this.baseAmountMinor,
      required this.totalAmountMinor,
      required this.commissionAmountMinor,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_reference'] = Variable<String>(transactionReference);
    map['service_key'] = Variable<String>(serviceKey);
    map['base_amount_minor'] = Variable<int>(baseAmountMinor);
    map['total_amount_minor'] = Variable<int>(totalAmountMinor);
    map['commission_amount_minor'] = Variable<int>(commissionAmountMinor);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CommissionLogsCompanion toCompanion(bool nullToAbsent) {
    return CommissionLogsCompanion(
      id: Value(id),
      transactionReference: Value(transactionReference),
      serviceKey: Value(serviceKey),
      baseAmountMinor: Value(baseAmountMinor),
      totalAmountMinor: Value(totalAmountMinor),
      commissionAmountMinor: Value(commissionAmountMinor),
      createdAt: Value(createdAt),
    );
  }

  factory CommissionLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommissionLog(
      id: serializer.fromJson<int>(json['id']),
      transactionReference:
          serializer.fromJson<String>(json['transactionReference']),
      serviceKey: serializer.fromJson<String>(json['serviceKey']),
      baseAmountMinor: serializer.fromJson<int>(json['baseAmountMinor']),
      totalAmountMinor: serializer.fromJson<int>(json['totalAmountMinor']),
      commissionAmountMinor:
          serializer.fromJson<int>(json['commissionAmountMinor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionReference': serializer.toJson<String>(transactionReference),
      'serviceKey': serializer.toJson<String>(serviceKey),
      'baseAmountMinor': serializer.toJson<int>(baseAmountMinor),
      'totalAmountMinor': serializer.toJson<int>(totalAmountMinor),
      'commissionAmountMinor': serializer.toJson<int>(commissionAmountMinor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CommissionLog copyWith(
          {int? id,
          String? transactionReference,
          String? serviceKey,
          int? baseAmountMinor,
          int? totalAmountMinor,
          int? commissionAmountMinor,
          DateTime? createdAt}) =>
      CommissionLog(
        id: id ?? this.id,
        transactionReference: transactionReference ?? this.transactionReference,
        serviceKey: serviceKey ?? this.serviceKey,
        baseAmountMinor: baseAmountMinor ?? this.baseAmountMinor,
        totalAmountMinor: totalAmountMinor ?? this.totalAmountMinor,
        commissionAmountMinor:
            commissionAmountMinor ?? this.commissionAmountMinor,
        createdAt: createdAt ?? this.createdAt,
      );
  CommissionLog copyWithCompanion(CommissionLogsCompanion data) {
    return CommissionLog(
      id: data.id.present ? data.id.value : this.id,
      transactionReference: data.transactionReference.present
          ? data.transactionReference.value
          : this.transactionReference,
      serviceKey:
          data.serviceKey.present ? data.serviceKey.value : this.serviceKey,
      baseAmountMinor: data.baseAmountMinor.present
          ? data.baseAmountMinor.value
          : this.baseAmountMinor,
      totalAmountMinor: data.totalAmountMinor.present
          ? data.totalAmountMinor.value
          : this.totalAmountMinor,
      commissionAmountMinor: data.commissionAmountMinor.present
          ? data.commissionAmountMinor.value
          : this.commissionAmountMinor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommissionLog(')
          ..write('id: $id, ')
          ..write('transactionReference: $transactionReference, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('baseAmountMinor: $baseAmountMinor, ')
          ..write('totalAmountMinor: $totalAmountMinor, ')
          ..write('commissionAmountMinor: $commissionAmountMinor, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, transactionReference, serviceKey,
      baseAmountMinor, totalAmountMinor, commissionAmountMinor, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommissionLog &&
          other.id == this.id &&
          other.transactionReference == this.transactionReference &&
          other.serviceKey == this.serviceKey &&
          other.baseAmountMinor == this.baseAmountMinor &&
          other.totalAmountMinor == this.totalAmountMinor &&
          other.commissionAmountMinor == this.commissionAmountMinor &&
          other.createdAt == this.createdAt);
}

class CommissionLogsCompanion extends UpdateCompanion<CommissionLog> {
  final Value<int> id;
  final Value<String> transactionReference;
  final Value<String> serviceKey;
  final Value<int> baseAmountMinor;
  final Value<int> totalAmountMinor;
  final Value<int> commissionAmountMinor;
  final Value<DateTime> createdAt;
  const CommissionLogsCompanion({
    this.id = const Value.absent(),
    this.transactionReference = const Value.absent(),
    this.serviceKey = const Value.absent(),
    this.baseAmountMinor = const Value.absent(),
    this.totalAmountMinor = const Value.absent(),
    this.commissionAmountMinor = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CommissionLogsCompanion.insert({
    this.id = const Value.absent(),
    required String transactionReference,
    required String serviceKey,
    required int baseAmountMinor,
    required int totalAmountMinor,
    required int commissionAmountMinor,
    this.createdAt = const Value.absent(),
  })  : transactionReference = Value(transactionReference),
        serviceKey = Value(serviceKey),
        baseAmountMinor = Value(baseAmountMinor),
        totalAmountMinor = Value(totalAmountMinor),
        commissionAmountMinor = Value(commissionAmountMinor);
  static Insertable<CommissionLog> custom({
    Expression<int>? id,
    Expression<String>? transactionReference,
    Expression<String>? serviceKey,
    Expression<int>? baseAmountMinor,
    Expression<int>? totalAmountMinor,
    Expression<int>? commissionAmountMinor,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionReference != null)
        'transaction_reference': transactionReference,
      if (serviceKey != null) 'service_key': serviceKey,
      if (baseAmountMinor != null) 'base_amount_minor': baseAmountMinor,
      if (totalAmountMinor != null) 'total_amount_minor': totalAmountMinor,
      if (commissionAmountMinor != null)
        'commission_amount_minor': commissionAmountMinor,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CommissionLogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? transactionReference,
      Value<String>? serviceKey,
      Value<int>? baseAmountMinor,
      Value<int>? totalAmountMinor,
      Value<int>? commissionAmountMinor,
      Value<DateTime>? createdAt}) {
    return CommissionLogsCompanion(
      id: id ?? this.id,
      transactionReference: transactionReference ?? this.transactionReference,
      serviceKey: serviceKey ?? this.serviceKey,
      baseAmountMinor: baseAmountMinor ?? this.baseAmountMinor,
      totalAmountMinor: totalAmountMinor ?? this.totalAmountMinor,
      commissionAmountMinor:
          commissionAmountMinor ?? this.commissionAmountMinor,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionReference.present) {
      map['transaction_reference'] =
          Variable<String>(transactionReference.value);
    }
    if (serviceKey.present) {
      map['service_key'] = Variable<String>(serviceKey.value);
    }
    if (baseAmountMinor.present) {
      map['base_amount_minor'] = Variable<int>(baseAmountMinor.value);
    }
    if (totalAmountMinor.present) {
      map['total_amount_minor'] = Variable<int>(totalAmountMinor.value);
    }
    if (commissionAmountMinor.present) {
      map['commission_amount_minor'] =
          Variable<int>(commissionAmountMinor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommissionLogsCompanion(')
          ..write('id: $id, ')
          ..write('transactionReference: $transactionReference, ')
          ..write('serviceKey: $serviceKey, ')
          ..write('baseAmountMinor: $baseAmountMinor, ')
          ..write('totalAmountMinor: $totalAmountMinor, ')
          ..write('commissionAmountMinor: $commissionAmountMinor, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalWalletsTable localWallets = $LocalWalletsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $ServicesCatalogTable servicesCatalog =
      $ServicesCatalogTable(this);
  late final $PendingSmsQueueTable pendingSmsQueue =
      $PendingSmsQueueTable(this);
  late final $SubAccountsTable subAccounts = $SubAccountsTable(this);
  late final $CommissionLogsTable commissionLogs = $CommissionLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        localWallets,
        transactions,
        servicesCatalog,
        pendingSmsQueue,
        subAccounts,
        commissionLogs
      ];
}

typedef $$LocalWalletsTableCreateCompanionBuilder = LocalWalletsCompanion
    Function({
  Value<int> id,
  required String agentName,
  required int availableBalanceMinor,
  Value<int> reservedBalanceMinor,
  Value<int> dailySpendingLimitMinor,
  Value<int> monthlySpendingLimitMinor,
  Value<DateTime?> lastSyncedAt,
});
typedef $$LocalWalletsTableUpdateCompanionBuilder = LocalWalletsCompanion
    Function({
  Value<int> id,
  Value<String> agentName,
  Value<int> availableBalanceMinor,
  Value<int> reservedBalanceMinor,
  Value<int> dailySpendingLimitMinor,
  Value<int> monthlySpendingLimitMinor,
  Value<DateTime?> lastSyncedAt,
});

class $$LocalWalletsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalWalletsTable> {
  $$LocalWalletsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agentName => $composableBuilder(
      column: $table.agentName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get availableBalanceMinor => $composableBuilder(
      column: $table.availableBalanceMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reservedBalanceMinor => $composableBuilder(
      column: $table.reservedBalanceMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailySpendingLimitMinor => $composableBuilder(
      column: $table.dailySpendingLimitMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlySpendingLimitMinor => $composableBuilder(
      column: $table.monthlySpendingLimitMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalWalletsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalWalletsTable> {
  $$LocalWalletsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agentName => $composableBuilder(
      column: $table.agentName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get availableBalanceMinor => $composableBuilder(
      column: $table.availableBalanceMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reservedBalanceMinor => $composableBuilder(
      column: $table.reservedBalanceMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailySpendingLimitMinor => $composableBuilder(
      column: $table.dailySpendingLimitMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlySpendingLimitMinor => $composableBuilder(
      column: $table.monthlySpendingLimitMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$LocalWalletsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalWalletsTable> {
  $$LocalWalletsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get agentName =>
      $composableBuilder(column: $table.agentName, builder: (column) => column);

  GeneratedColumn<int> get availableBalanceMinor => $composableBuilder(
      column: $table.availableBalanceMinor, builder: (column) => column);

  GeneratedColumn<int> get reservedBalanceMinor => $composableBuilder(
      column: $table.reservedBalanceMinor, builder: (column) => column);

  GeneratedColumn<int> get dailySpendingLimitMinor => $composableBuilder(
      column: $table.dailySpendingLimitMinor, builder: (column) => column);

  GeneratedColumn<int> get monthlySpendingLimitMinor => $composableBuilder(
      column: $table.monthlySpendingLimitMinor, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
      column: $table.lastSyncedAt, builder: (column) => column);
}

class $$LocalWalletsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalWalletsTable,
    LocalWallet,
    $$LocalWalletsTableFilterComposer,
    $$LocalWalletsTableOrderingComposer,
    $$LocalWalletsTableAnnotationComposer,
    $$LocalWalletsTableCreateCompanionBuilder,
    $$LocalWalletsTableUpdateCompanionBuilder,
    (
      LocalWallet,
      BaseReferences<_$AppDatabase, $LocalWalletsTable, LocalWallet>
    ),
    LocalWallet,
    PrefetchHooks Function()> {
  $$LocalWalletsTableTableManager(_$AppDatabase db, $LocalWalletsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalWalletsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalWalletsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalWalletsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> agentName = const Value.absent(),
            Value<int> availableBalanceMinor = const Value.absent(),
            Value<int> reservedBalanceMinor = const Value.absent(),
            Value<int> dailySpendingLimitMinor = const Value.absent(),
            Value<int> monthlySpendingLimitMinor = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
          }) =>
              LocalWalletsCompanion(
            id: id,
            agentName: agentName,
            availableBalanceMinor: availableBalanceMinor,
            reservedBalanceMinor: reservedBalanceMinor,
            dailySpendingLimitMinor: dailySpendingLimitMinor,
            monthlySpendingLimitMinor: monthlySpendingLimitMinor,
            lastSyncedAt: lastSyncedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String agentName,
            required int availableBalanceMinor,
            Value<int> reservedBalanceMinor = const Value.absent(),
            Value<int> dailySpendingLimitMinor = const Value.absent(),
            Value<int> monthlySpendingLimitMinor = const Value.absent(),
            Value<DateTime?> lastSyncedAt = const Value.absent(),
          }) =>
              LocalWalletsCompanion.insert(
            id: id,
            agentName: agentName,
            availableBalanceMinor: availableBalanceMinor,
            reservedBalanceMinor: reservedBalanceMinor,
            dailySpendingLimitMinor: dailySpendingLimitMinor,
            monthlySpendingLimitMinor: monthlySpendingLimitMinor,
            lastSyncedAt: lastSyncedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalWalletsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalWalletsTable,
    LocalWallet,
    $$LocalWalletsTableFilterComposer,
    $$LocalWalletsTableOrderingComposer,
    $$LocalWalletsTableAnnotationComposer,
    $$LocalWalletsTableCreateCompanionBuilder,
    $$LocalWalletsTableUpdateCompanionBuilder,
    (
      LocalWallet,
      BaseReferences<_$AppDatabase, $LocalWalletsTable, LocalWallet>
    ),
    LocalWallet,
    PrefetchHooks Function()>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  required String reference,
  required String serviceKey,
  required String serviceType,
  required int psiCode,
  required String targetIdentifier,
  required int baseAmountMinor,
  required int taxAmountMinor,
  required int totalAmountMinor,
  required String status,
  required String channel,
  Value<DateTime> createdAt,
  Value<DateTime?> syncedAt,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<int> id,
  Value<String> reference,
  Value<String> serviceKey,
  Value<String> serviceType,
  Value<int> psiCode,
  Value<String> targetIdentifier,
  Value<int> baseAmountMinor,
  Value<int> taxAmountMinor,
  Value<int> totalAmountMinor,
  Value<String> status,
  Value<String> channel,
  Value<DateTime> createdAt,
  Value<DateTime?> syncedAt,
});

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get psiCode => $composableBuilder(
      column: $table.psiCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetIdentifier => $composableBuilder(
      column: $table.targetIdentifier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseAmountMinor => $composableBuilder(
      column: $table.baseAmountMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get taxAmountMinor => $composableBuilder(
      column: $table.taxAmountMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalAmountMinor => $composableBuilder(
      column: $table.totalAmountMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get channel => $composableBuilder(
      column: $table.channel, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get psiCode => $composableBuilder(
      column: $table.psiCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetIdentifier => $composableBuilder(
      column: $table.targetIdentifier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseAmountMinor => $composableBuilder(
      column: $table.baseAmountMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get taxAmountMinor => $composableBuilder(
      column: $table.taxAmountMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalAmountMinor => $composableBuilder(
      column: $table.totalAmountMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get channel => $composableBuilder(
      column: $table.channel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
      column: $table.serviceType, builder: (column) => column);

  GeneratedColumn<int> get psiCode =>
      $composableBuilder(column: $table.psiCode, builder: (column) => column);

  GeneratedColumn<String> get targetIdentifier => $composableBuilder(
      column: $table.targetIdentifier, builder: (column) => column);

  GeneratedColumn<int> get baseAmountMinor => $composableBuilder(
      column: $table.baseAmountMinor, builder: (column) => column);

  GeneratedColumn<int> get taxAmountMinor => $composableBuilder(
      column: $table.taxAmountMinor, builder: (column) => column);

  GeneratedColumn<int> get totalAmountMinor => $composableBuilder(
      column: $table.totalAmountMinor, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> reference = const Value.absent(),
            Value<String> serviceKey = const Value.absent(),
            Value<String> serviceType = const Value.absent(),
            Value<int> psiCode = const Value.absent(),
            Value<String> targetIdentifier = const Value.absent(),
            Value<int> baseAmountMinor = const Value.absent(),
            Value<int> taxAmountMinor = const Value.absent(),
            Value<int> totalAmountMinor = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> channel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            reference: reference,
            serviceKey: serviceKey,
            serviceType: serviceType,
            psiCode: psiCode,
            targetIdentifier: targetIdentifier,
            baseAmountMinor: baseAmountMinor,
            taxAmountMinor: taxAmountMinor,
            totalAmountMinor: totalAmountMinor,
            status: status,
            channel: channel,
            createdAt: createdAt,
            syncedAt: syncedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String reference,
            required String serviceKey,
            required String serviceType,
            required int psiCode,
            required String targetIdentifier,
            required int baseAmountMinor,
            required int taxAmountMinor,
            required int totalAmountMinor,
            required String status,
            required String channel,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            reference: reference,
            serviceKey: serviceKey,
            serviceType: serviceType,
            psiCode: psiCode,
            targetIdentifier: targetIdentifier,
            baseAmountMinor: baseAmountMinor,
            taxAmountMinor: taxAmountMinor,
            totalAmountMinor: totalAmountMinor,
            status: status,
            channel: channel,
            createdAt: createdAt,
            syncedAt: syncedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()>;
typedef $$ServicesCatalogTableCreateCompanionBuilder = ServicesCatalogCompanion
    Function({
  Value<int> id,
  required String serviceKey,
  required String nameAr,
  required String nameEn,
  required String category,
  required String provider,
  required int psiCode,
  required TaxClassification taxClass,
  Value<bool> isActive,
  Value<DateTime?> lastUpdatedAt,
});
typedef $$ServicesCatalogTableUpdateCompanionBuilder = ServicesCatalogCompanion
    Function({
  Value<int> id,
  Value<String> serviceKey,
  Value<String> nameAr,
  Value<String> nameEn,
  Value<String> category,
  Value<String> provider,
  Value<int> psiCode,
  Value<TaxClassification> taxClass,
  Value<bool> isActive,
  Value<DateTime?> lastUpdatedAt,
});

class $$ServicesCatalogTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesCatalogTable> {
  $$ServicesCatalogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get provider => $composableBuilder(
      column: $table.provider, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get psiCode => $composableBuilder(
      column: $table.psiCode, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TaxClassification, TaxClassification, String>
      get taxClass => $composableBuilder(
          column: $table.taxClass,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));
}

class $$ServicesCatalogTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesCatalogTable> {
  $$ServicesCatalogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get provider => $composableBuilder(
      column: $table.provider, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get psiCode => $composableBuilder(
      column: $table.psiCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taxClass => $composableBuilder(
      column: $table.taxClass, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$ServicesCatalogTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesCatalogTable> {
  $$ServicesCatalogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<int> get psiCode =>
      $composableBuilder(column: $table.psiCode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaxClassification, String> get taxClass =>
      $composableBuilder(column: $table.taxClass, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);
}

class $$ServicesCatalogTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServicesCatalogTable,
    ServicesCatalogData,
    $$ServicesCatalogTableFilterComposer,
    $$ServicesCatalogTableOrderingComposer,
    $$ServicesCatalogTableAnnotationComposer,
    $$ServicesCatalogTableCreateCompanionBuilder,
    $$ServicesCatalogTableUpdateCompanionBuilder,
    (
      ServicesCatalogData,
      BaseReferences<_$AppDatabase, $ServicesCatalogTable, ServicesCatalogData>
    ),
    ServicesCatalogData,
    PrefetchHooks Function()> {
  $$ServicesCatalogTableTableManager(
      _$AppDatabase db, $ServicesCatalogTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesCatalogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesCatalogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesCatalogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> serviceKey = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> provider = const Value.absent(),
            Value<int> psiCode = const Value.absent(),
            Value<TaxClassification> taxClass = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastUpdatedAt = const Value.absent(),
          }) =>
              ServicesCatalogCompanion(
            id: id,
            serviceKey: serviceKey,
            nameAr: nameAr,
            nameEn: nameEn,
            category: category,
            provider: provider,
            psiCode: psiCode,
            taxClass: taxClass,
            isActive: isActive,
            lastUpdatedAt: lastUpdatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String serviceKey,
            required String nameAr,
            required String nameEn,
            required String category,
            required String provider,
            required int psiCode,
            required TaxClassification taxClass,
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastUpdatedAt = const Value.absent(),
          }) =>
              ServicesCatalogCompanion.insert(
            id: id,
            serviceKey: serviceKey,
            nameAr: nameAr,
            nameEn: nameEn,
            category: category,
            provider: provider,
            psiCode: psiCode,
            taxClass: taxClass,
            isActive: isActive,
            lastUpdatedAt: lastUpdatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ServicesCatalogTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServicesCatalogTable,
    ServicesCatalogData,
    $$ServicesCatalogTableFilterComposer,
    $$ServicesCatalogTableOrderingComposer,
    $$ServicesCatalogTableAnnotationComposer,
    $$ServicesCatalogTableCreateCompanionBuilder,
    $$ServicesCatalogTableUpdateCompanionBuilder,
    (
      ServicesCatalogData,
      BaseReferences<_$AppDatabase, $ServicesCatalogTable, ServicesCatalogData>
    ),
    ServicesCatalogData,
    PrefetchHooks Function()>;
typedef $$PendingSmsQueueTableCreateCompanionBuilder = PendingSmsQueueCompanion
    Function({
  Value<int> id,
  required String reference,
  required String serviceKey,
  required String destinationNumber,
  required String smsBody,
  required String status,
  Value<DateTime> createdAt,
  Value<DateTime?> processedAt,
});
typedef $$PendingSmsQueueTableUpdateCompanionBuilder = PendingSmsQueueCompanion
    Function({
  Value<int> id,
  Value<String> reference,
  Value<String> serviceKey,
  Value<String> destinationNumber,
  Value<String> smsBody,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime?> processedAt,
});

class $$PendingSmsQueueTableFilterComposer
    extends Composer<_$AppDatabase, $PendingSmsQueueTable> {
  $$PendingSmsQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get destinationNumber => $composableBuilder(
      column: $table.destinationNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get smsBody => $composableBuilder(
      column: $table.smsBody, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get processedAt => $composableBuilder(
      column: $table.processedAt, builder: (column) => ColumnFilters(column));
}

class $$PendingSmsQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingSmsQueueTable> {
  $$PendingSmsQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get destinationNumber => $composableBuilder(
      column: $table.destinationNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get smsBody => $composableBuilder(
      column: $table.smsBody, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get processedAt => $composableBuilder(
      column: $table.processedAt, builder: (column) => ColumnOrderings(column));
}

class $$PendingSmsQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingSmsQueueTable> {
  $$PendingSmsQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => column);

  GeneratedColumn<String> get destinationNumber => $composableBuilder(
      column: $table.destinationNumber, builder: (column) => column);

  GeneratedColumn<String> get smsBody =>
      $composableBuilder(column: $table.smsBody, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get processedAt => $composableBuilder(
      column: $table.processedAt, builder: (column) => column);
}

class $$PendingSmsQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PendingSmsQueueTable,
    PendingSmsQueueData,
    $$PendingSmsQueueTableFilterComposer,
    $$PendingSmsQueueTableOrderingComposer,
    $$PendingSmsQueueTableAnnotationComposer,
    $$PendingSmsQueueTableCreateCompanionBuilder,
    $$PendingSmsQueueTableUpdateCompanionBuilder,
    (
      PendingSmsQueueData,
      BaseReferences<_$AppDatabase, $PendingSmsQueueTable, PendingSmsQueueData>
    ),
    PendingSmsQueueData,
    PrefetchHooks Function()> {
  $$PendingSmsQueueTableTableManager(
      _$AppDatabase db, $PendingSmsQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingSmsQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingSmsQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingSmsQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> reference = const Value.absent(),
            Value<String> serviceKey = const Value.absent(),
            Value<String> destinationNumber = const Value.absent(),
            Value<String> smsBody = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> processedAt = const Value.absent(),
          }) =>
              PendingSmsQueueCompanion(
            id: id,
            reference: reference,
            serviceKey: serviceKey,
            destinationNumber: destinationNumber,
            smsBody: smsBody,
            status: status,
            createdAt: createdAt,
            processedAt: processedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String reference,
            required String serviceKey,
            required String destinationNumber,
            required String smsBody,
            required String status,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> processedAt = const Value.absent(),
          }) =>
              PendingSmsQueueCompanion.insert(
            id: id,
            reference: reference,
            serviceKey: serviceKey,
            destinationNumber: destinationNumber,
            smsBody: smsBody,
            status: status,
            createdAt: createdAt,
            processedAt: processedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingSmsQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PendingSmsQueueTable,
    PendingSmsQueueData,
    $$PendingSmsQueueTableFilterComposer,
    $$PendingSmsQueueTableOrderingComposer,
    $$PendingSmsQueueTableAnnotationComposer,
    $$PendingSmsQueueTableCreateCompanionBuilder,
    $$PendingSmsQueueTableUpdateCompanionBuilder,
    (
      PendingSmsQueueData,
      BaseReferences<_$AppDatabase, $PendingSmsQueueTable, PendingSmsQueueData>
    ),
    PendingSmsQueueData,
    PrefetchHooks Function()>;
typedef $$SubAccountsTableCreateCompanionBuilder = SubAccountsCompanion
    Function({
  Value<int> id,
  required String displayName,
  required String pinCode,
  Value<bool> isActive,
  Value<int> dailySpendingLimitMinor,
  Value<int> monthlySpendingLimitMinor,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$SubAccountsTableUpdateCompanionBuilder = SubAccountsCompanion
    Function({
  Value<int> id,
  Value<String> displayName,
  Value<String> pinCode,
  Value<bool> isActive,
  Value<int> dailySpendingLimitMinor,
  Value<int> monthlySpendingLimitMinor,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

class $$SubAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $SubAccountsTable> {
  $$SubAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pinCode => $composableBuilder(
      column: $table.pinCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailySpendingLimitMinor => $composableBuilder(
      column: $table.dailySpendingLimitMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlySpendingLimitMinor => $composableBuilder(
      column: $table.monthlySpendingLimitMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SubAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubAccountsTable> {
  $$SubAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pinCode => $composableBuilder(
      column: $table.pinCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailySpendingLimitMinor => $composableBuilder(
      column: $table.dailySpendingLimitMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlySpendingLimitMinor => $composableBuilder(
      column: $table.monthlySpendingLimitMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SubAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubAccountsTable> {
  $$SubAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get pinCode =>
      $composableBuilder(column: $table.pinCode, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get dailySpendingLimitMinor => $composableBuilder(
      column: $table.dailySpendingLimitMinor, builder: (column) => column);

  GeneratedColumn<int> get monthlySpendingLimitMinor => $composableBuilder(
      column: $table.monthlySpendingLimitMinor, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SubAccountsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SubAccountsTable,
    SubAccount,
    $$SubAccountsTableFilterComposer,
    $$SubAccountsTableOrderingComposer,
    $$SubAccountsTableAnnotationComposer,
    $$SubAccountsTableCreateCompanionBuilder,
    $$SubAccountsTableUpdateCompanionBuilder,
    (SubAccount, BaseReferences<_$AppDatabase, $SubAccountsTable, SubAccount>),
    SubAccount,
    PrefetchHooks Function()> {
  $$SubAccountsTableTableManager(_$AppDatabase db, $SubAccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<String> pinCode = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> dailySpendingLimitMinor = const Value.absent(),
            Value<int> monthlySpendingLimitMinor = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              SubAccountsCompanion(
            id: id,
            displayName: displayName,
            pinCode: pinCode,
            isActive: isActive,
            dailySpendingLimitMinor: dailySpendingLimitMinor,
            monthlySpendingLimitMinor: monthlySpendingLimitMinor,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String displayName,
            required String pinCode,
            Value<bool> isActive = const Value.absent(),
            Value<int> dailySpendingLimitMinor = const Value.absent(),
            Value<int> monthlySpendingLimitMinor = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              SubAccountsCompanion.insert(
            id: id,
            displayName: displayName,
            pinCode: pinCode,
            isActive: isActive,
            dailySpendingLimitMinor: dailySpendingLimitMinor,
            monthlySpendingLimitMinor: monthlySpendingLimitMinor,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SubAccountsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SubAccountsTable,
    SubAccount,
    $$SubAccountsTableFilterComposer,
    $$SubAccountsTableOrderingComposer,
    $$SubAccountsTableAnnotationComposer,
    $$SubAccountsTableCreateCompanionBuilder,
    $$SubAccountsTableUpdateCompanionBuilder,
    (SubAccount, BaseReferences<_$AppDatabase, $SubAccountsTable, SubAccount>),
    SubAccount,
    PrefetchHooks Function()>;
typedef $$CommissionLogsTableCreateCompanionBuilder = CommissionLogsCompanion
    Function({
  Value<int> id,
  required String transactionReference,
  required String serviceKey,
  required int baseAmountMinor,
  required int totalAmountMinor,
  required int commissionAmountMinor,
  Value<DateTime> createdAt,
});
typedef $$CommissionLogsTableUpdateCompanionBuilder = CommissionLogsCompanion
    Function({
  Value<int> id,
  Value<String> transactionReference,
  Value<String> serviceKey,
  Value<int> baseAmountMinor,
  Value<int> totalAmountMinor,
  Value<int> commissionAmountMinor,
  Value<DateTime> createdAt,
});

class $$CommissionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $CommissionLogsTable> {
  $$CommissionLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionReference => $composableBuilder(
      column: $table.transactionReference,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseAmountMinor => $composableBuilder(
      column: $table.baseAmountMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalAmountMinor => $composableBuilder(
      column: $table.totalAmountMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get commissionAmountMinor => $composableBuilder(
      column: $table.commissionAmountMinor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$CommissionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommissionLogsTable> {
  $$CommissionLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionReference => $composableBuilder(
      column: $table.transactionReference,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseAmountMinor => $composableBuilder(
      column: $table.baseAmountMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalAmountMinor => $composableBuilder(
      column: $table.totalAmountMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get commissionAmountMinor => $composableBuilder(
      column: $table.commissionAmountMinor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CommissionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommissionLogsTable> {
  $$CommissionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transactionReference => $composableBuilder(
      column: $table.transactionReference, builder: (column) => column);

  GeneratedColumn<String> get serviceKey => $composableBuilder(
      column: $table.serviceKey, builder: (column) => column);

  GeneratedColumn<int> get baseAmountMinor => $composableBuilder(
      column: $table.baseAmountMinor, builder: (column) => column);

  GeneratedColumn<int> get totalAmountMinor => $composableBuilder(
      column: $table.totalAmountMinor, builder: (column) => column);

  GeneratedColumn<int> get commissionAmountMinor => $composableBuilder(
      column: $table.commissionAmountMinor, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CommissionLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommissionLogsTable,
    CommissionLog,
    $$CommissionLogsTableFilterComposer,
    $$CommissionLogsTableOrderingComposer,
    $$CommissionLogsTableAnnotationComposer,
    $$CommissionLogsTableCreateCompanionBuilder,
    $$CommissionLogsTableUpdateCompanionBuilder,
    (
      CommissionLog,
      BaseReferences<_$AppDatabase, $CommissionLogsTable, CommissionLog>
    ),
    CommissionLog,
    PrefetchHooks Function()> {
  $$CommissionLogsTableTableManager(
      _$AppDatabase db, $CommissionLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommissionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommissionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommissionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> transactionReference = const Value.absent(),
            Value<String> serviceKey = const Value.absent(),
            Value<int> baseAmountMinor = const Value.absent(),
            Value<int> totalAmountMinor = const Value.absent(),
            Value<int> commissionAmountMinor = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CommissionLogsCompanion(
            id: id,
            transactionReference: transactionReference,
            serviceKey: serviceKey,
            baseAmountMinor: baseAmountMinor,
            totalAmountMinor: totalAmountMinor,
            commissionAmountMinor: commissionAmountMinor,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String transactionReference,
            required String serviceKey,
            required int baseAmountMinor,
            required int totalAmountMinor,
            required int commissionAmountMinor,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              CommissionLogsCompanion.insert(
            id: id,
            transactionReference: transactionReference,
            serviceKey: serviceKey,
            baseAmountMinor: baseAmountMinor,
            totalAmountMinor: totalAmountMinor,
            commissionAmountMinor: commissionAmountMinor,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CommissionLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CommissionLogsTable,
    CommissionLog,
    $$CommissionLogsTableFilterComposer,
    $$CommissionLogsTableOrderingComposer,
    $$CommissionLogsTableAnnotationComposer,
    $$CommissionLogsTableCreateCompanionBuilder,
    $$CommissionLogsTableUpdateCompanionBuilder,
    (
      CommissionLog,
      BaseReferences<_$AppDatabase, $CommissionLogsTable, CommissionLog>
    ),
    CommissionLog,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalWalletsTableTableManager get localWallets =>
      $$LocalWalletsTableTableManager(_db, _db.localWallets);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$ServicesCatalogTableTableManager get servicesCatalog =>
      $$ServicesCatalogTableTableManager(_db, _db.servicesCatalog);
  $$PendingSmsQueueTableTableManager get pendingSmsQueue =>
      $$PendingSmsQueueTableTableManager(_db, _db.pendingSmsQueue);
  $$SubAccountsTableTableManager get subAccounts =>
      $$SubAccountsTableTableManager(_db, _db.subAccounts);
  $$CommissionLogsTableTableManager get commissionLogs =>
      $$CommissionLogsTableTableManager(_db, _db.commissionLogs);
}
