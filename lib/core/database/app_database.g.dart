// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NotesTableTable extends NotesTable
    with TableInfo<$NotesTableTable, NotesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _farmsMeta = const VerificationMeta('farms');
  @override
  late final GeneratedColumn<String> farms = GeneratedColumn<String>(
    'farms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackNumberMeta = const VerificationMeta(
    'trackNumber',
  );
  @override
  late final GeneratedColumn<int> trackNumber = GeneratedColumn<int>(
    'track_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<Product>, String> products =
      GeneratedColumn<String>(
        'products',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<Product>>($NotesTableTable.$converterproducts);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    status,
    farms,
    merchant,
    trackNumber,
    creationDate,
    userName,
    products,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('farms')) {
      context.handle(
        _farmsMeta,
        farms.isAcceptableOrUnknown(data['farms']!, _farmsMeta),
      );
    } else if (isInserting) {
      context.missing(_farmsMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    } else if (isInserting) {
      context.missing(_merchantMeta);
    }
    if (data.containsKey('track_number')) {
      context.handle(
        _trackNumberMeta,
        trackNumber.isAcceptableOrUnknown(
          data['track_number']!,
          _trackNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trackNumberMeta);
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      farms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farms'],
      )!,
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      )!,
      trackNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_number'],
      )!,
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      products: $NotesTableTable.$converterproducts.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}products'],
        )!,
      ),
    );
  }

  @override
  $NotesTableTable createAlias(String alias) {
    return $NotesTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<Product>, String> $converterproducts =
      const ProductListConverter();
}

class NotesTableData extends DataClass implements Insertable<NotesTableData> {
  /// UUID v4 primary key – safe for offline-first sync.
  final String id;

  /// Status int: 1 = new, 2 = uploaded.
  final int status;

  /// Farm name(s).
  final String farms;

  /// Merchant name.
  final String merchant;

  /// Shipment / track number.
  final int trackNumber;

  /// Date the note was created.
  final DateTime creationDate;

  /// Name of the user who created the note.
  final String userName;

  /// Products string (serialised list).
  final List<Product> products;
  const NotesTableData({
    required this.id,
    required this.status,
    required this.farms,
    required this.merchant,
    required this.trackNumber,
    required this.creationDate,
    required this.userName,
    required this.products,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['status'] = Variable<int>(status);
    map['farms'] = Variable<String>(farms);
    map['merchant'] = Variable<String>(merchant);
    map['track_number'] = Variable<int>(trackNumber);
    map['creation_date'] = Variable<DateTime>(creationDate);
    map['user_name'] = Variable<String>(userName);
    {
      map['products'] = Variable<String>(
        $NotesTableTable.$converterproducts.toSql(products),
      );
    }
    return map;
  }

  NotesTableCompanion toCompanion(bool nullToAbsent) {
    return NotesTableCompanion(
      id: Value(id),
      status: Value(status),
      farms: Value(farms),
      merchant: Value(merchant),
      trackNumber: Value(trackNumber),
      creationDate: Value(creationDate),
      userName: Value(userName),
      products: Value(products),
    );
  }

  factory NotesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotesTableData(
      id: serializer.fromJson<String>(json['id']),
      status: serializer.fromJson<int>(json['status']),
      farms: serializer.fromJson<String>(json['farms']),
      merchant: serializer.fromJson<String>(json['merchant']),
      trackNumber: serializer.fromJson<int>(json['trackNumber']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
      userName: serializer.fromJson<String>(json['userName']),
      products: serializer.fromJson<List<Product>>(json['products']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'status': serializer.toJson<int>(status),
      'farms': serializer.toJson<String>(farms),
      'merchant': serializer.toJson<String>(merchant),
      'trackNumber': serializer.toJson<int>(trackNumber),
      'creationDate': serializer.toJson<DateTime>(creationDate),
      'userName': serializer.toJson<String>(userName),
      'products': serializer.toJson<List<Product>>(products),
    };
  }

  NotesTableData copyWith({
    String? id,
    int? status,
    String? farms,
    String? merchant,
    int? trackNumber,
    DateTime? creationDate,
    String? userName,
    List<Product>? products,
  }) => NotesTableData(
    id: id ?? this.id,
    status: status ?? this.status,
    farms: farms ?? this.farms,
    merchant: merchant ?? this.merchant,
    trackNumber: trackNumber ?? this.trackNumber,
    creationDate: creationDate ?? this.creationDate,
    userName: userName ?? this.userName,
    products: products ?? this.products,
  );
  NotesTableData copyWithCompanion(NotesTableCompanion data) {
    return NotesTableData(
      id: data.id.present ? data.id.value : this.id,
      status: data.status.present ? data.status.value : this.status,
      farms: data.farms.present ? data.farms.value : this.farms,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      trackNumber: data.trackNumber.present
          ? data.trackNumber.value
          : this.trackNumber,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      userName: data.userName.present ? data.userName.value : this.userName,
      products: data.products.present ? data.products.value : this.products,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotesTableData(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('farms: $farms, ')
          ..write('merchant: $merchant, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('creationDate: $creationDate, ')
          ..write('userName: $userName, ')
          ..write('products: $products')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    status,
    farms,
    merchant,
    trackNumber,
    creationDate,
    userName,
    products,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotesTableData &&
          other.id == this.id &&
          other.status == this.status &&
          other.farms == this.farms &&
          other.merchant == this.merchant &&
          other.trackNumber == this.trackNumber &&
          other.creationDate == this.creationDate &&
          other.userName == this.userName &&
          other.products == this.products);
}

class NotesTableCompanion extends UpdateCompanion<NotesTableData> {
  final Value<String> id;
  final Value<int> status;
  final Value<String> farms;
  final Value<String> merchant;
  final Value<int> trackNumber;
  final Value<DateTime> creationDate;
  final Value<String> userName;
  final Value<List<Product>> products;
  final Value<int> rowid;
  const NotesTableCompanion({
    this.id = const Value.absent(),
    this.status = const Value.absent(),
    this.farms = const Value.absent(),
    this.merchant = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.userName = const Value.absent(),
    this.products = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesTableCompanion.insert({
    required String id,
    this.status = const Value.absent(),
    required String farms,
    required String merchant,
    required int trackNumber,
    required DateTime creationDate,
    required String userName,
    required List<Product> products,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       farms = Value(farms),
       merchant = Value(merchant),
       trackNumber = Value(trackNumber),
       creationDate = Value(creationDate),
       userName = Value(userName),
       products = Value(products);
  static Insertable<NotesTableData> custom({
    Expression<String>? id,
    Expression<int>? status,
    Expression<String>? farms,
    Expression<String>? merchant,
    Expression<int>? trackNumber,
    Expression<DateTime>? creationDate,
    Expression<String>? userName,
    Expression<String>? products,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (status != null) 'status': status,
      if (farms != null) 'farms': farms,
      if (merchant != null) 'merchant': merchant,
      if (trackNumber != null) 'track_number': trackNumber,
      if (creationDate != null) 'creation_date': creationDate,
      if (userName != null) 'user_name': userName,
      if (products != null) 'products': products,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesTableCompanion copyWith({
    Value<String>? id,
    Value<int>? status,
    Value<String>? farms,
    Value<String>? merchant,
    Value<int>? trackNumber,
    Value<DateTime>? creationDate,
    Value<String>? userName,
    Value<List<Product>>? products,
    Value<int>? rowid,
  }) {
    return NotesTableCompanion(
      id: id ?? this.id,
      status: status ?? this.status,
      farms: farms ?? this.farms,
      merchant: merchant ?? this.merchant,
      trackNumber: trackNumber ?? this.trackNumber,
      creationDate: creationDate ?? this.creationDate,
      userName: userName ?? this.userName,
      products: products ?? this.products,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (farms.present) {
      map['farms'] = Variable<String>(farms.value);
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (trackNumber.present) {
      map['track_number'] = Variable<int>(trackNumber.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (products.present) {
      map['products'] = Variable<String>(
        $NotesTableTable.$converterproducts.toSql(products.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesTableCompanion(')
          ..write('id: $id, ')
          ..write('status: $status, ')
          ..write('farms: $farms, ')
          ..write('merchant: $merchant, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('creationDate: $creationDate, ')
          ..write('userName: $userName, ')
          ..write('products: $products, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NotesTableTable notesTable = $NotesTableTable(this);
  late final NotesDao notesDao = NotesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notesTable];
}

typedef $$NotesTableTableCreateCompanionBuilder =
    NotesTableCompanion Function({
      required String id,
      Value<int> status,
      required String farms,
      required String merchant,
      required int trackNumber,
      required DateTime creationDate,
      required String userName,
      required List<Product> products,
      Value<int> rowid,
    });
typedef $$NotesTableTableUpdateCompanionBuilder =
    NotesTableCompanion Function({
      Value<String> id,
      Value<int> status,
      Value<String> farms,
      Value<String> merchant,
      Value<int> trackNumber,
      Value<DateTime> creationDate,
      Value<String> userName,
      Value<List<Product>> products,
      Value<int> rowid,
    });

class $$NotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotesTableTable> {
  $$NotesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farms => $composableBuilder(
    column: $table.farms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackNumber => $composableBuilder(
    column: $table.trackNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<Product>, List<Product>, String>
  get products => $composableBuilder(
    column: $table.products,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$NotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTableTable> {
  $$NotesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farms => $composableBuilder(
    column: $table.farms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackNumber => $composableBuilder(
    column: $table.trackNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get products => $composableBuilder(
    column: $table.products,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTableTable> {
  $$NotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get farms =>
      $composableBuilder(column: $table.farms, builder: (column) => column);

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<int> get trackNumber => $composableBuilder(
    column: $table.trackNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<Product>, String> get products =>
      $composableBuilder(column: $table.products, builder: (column) => column);
}

class $$NotesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTableTable,
          NotesTableData,
          $$NotesTableTableFilterComposer,
          $$NotesTableTableOrderingComposer,
          $$NotesTableTableAnnotationComposer,
          $$NotesTableTableCreateCompanionBuilder,
          $$NotesTableTableUpdateCompanionBuilder,
          (
            NotesTableData,
            BaseReferences<_$AppDatabase, $NotesTableTable, NotesTableData>,
          ),
          NotesTableData,
          PrefetchHooks Function()
        > {
  $$NotesTableTableTableManager(_$AppDatabase db, $NotesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String> farms = const Value.absent(),
                Value<String> merchant = const Value.absent(),
                Value<int> trackNumber = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<List<Product>> products = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesTableCompanion(
                id: id,
                status: status,
                farms: farms,
                merchant: merchant,
                trackNumber: trackNumber,
                creationDate: creationDate,
                userName: userName,
                products: products,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int> status = const Value.absent(),
                required String farms,
                required String merchant,
                required int trackNumber,
                required DateTime creationDate,
                required String userName,
                required List<Product> products,
                Value<int> rowid = const Value.absent(),
              }) => NotesTableCompanion.insert(
                id: id,
                status: status,
                farms: farms,
                merchant: merchant,
                trackNumber: trackNumber,
                creationDate: creationDate,
                userName: userName,
                products: products,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTableTable,
      NotesTableData,
      $$NotesTableTableFilterComposer,
      $$NotesTableTableOrderingComposer,
      $$NotesTableTableAnnotationComposer,
      $$NotesTableTableCreateCompanionBuilder,
      $$NotesTableTableUpdateCompanionBuilder,
      (
        NotesTableData,
        BaseReferences<_$AppDatabase, $NotesTableTable, NotesTableData>,
      ),
      NotesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NotesTableTableTableManager get notesTable =>
      $$NotesTableTableTableManager(_db, _db.notesTable);
}
