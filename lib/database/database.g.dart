// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StocksDao? _stockdaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Stocks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sid` TEXT, `price` REAL, `change` REAL, `isChangeUp` INTEGER, `time` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StocksDao get stockdao {
    return _stockdaoInstance ??= _$StocksDao(database, changeListener);
  }
}

class _$StocksDao extends StocksDao {
  _$StocksDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _stocksInsertionAdapter = InsertionAdapter(
            database,
            'Stocks',
            (Stocks item) => <String, Object?>{
                  'id': item.id,
                  'sid': item.sid,
                  'price': item.price,
                  'change': item.change,
                  'isChangeUp': item.isChangeUp == null
                      ? null
                      : (item.isChangeUp! ? 1 : 0),
                  'time': item.time
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Stocks> _stocksInsertionAdapter;

  @override
  Future<List<Stocks>> fetchAllStock() async {
    return _queryAdapter.queryList('SELECT * FROM Stocks',
        mapper: (Map<String, Object?> row) => Stocks(
            id: row['id'] as int?,
            sid: row['sid'] as String?,
            price: row['price'] as double?,
            change: row['change'] as double?,
            isChangeUp: row['isChangeUp'] == null
                ? null
                : (row['isChangeUp'] as int) != 0,
            time: row['time'] as int?));
  }

  @override
  Stream<Stocks?> findPersonById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Stocks WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Stocks(
            id: row['id'] as int?,
            sid: row['sid'] as String?,
            price: row['price'] as double?,
            change: row['change'] as double?,
            isChangeUp: row['isChangeUp'] == null
                ? null
                : (row['isChangeUp'] as int) != 0,
            time: row['time'] as int?),
        arguments: [id],
        queryableName: 'Stocks',
        isView: false);
  }

  @override
  Future<List<double>?> getPriceBySid(String sid) async {
    return await _queryAdapter.queryList(
        'SELECT price FROM Stocks WHERE sid = ?1',
        arguments: [sid],
        mapper: (Map<String, Object?> row) => row['price'] as double);
  }

  @override
  Future<List<int>?> getTimeBySid(String sid) async {
    return await _queryAdapter.queryList(
        'SELECT time FROM Stocks WHERE sid = ?1',
        arguments: [sid],
        mapper: (Map<String, Object?> row) => row['time'] as int);
  }

  @override
  Future<void> insertStock(Stocks stock) async {
    await _stocksInsertionAdapter.insert(stock, OnConflictStrategy.abort);
  }
}
