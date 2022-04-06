import 'package:flutter_todolist/app/core/database/sqlite_migration_factory.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  static const _version = 1;
  static const _databaseName = 'TODOLIST_DB';

  static SqliteConnectionFactory? _instance;

  SqliteConnectionFactory._();

  Database? _db;
  final _lock = Lock();

  factory SqliteConnectionFactory() {
    // If _instance == NULL atribuiu o Construtor e Retorna.
    // Caso contrario Retorna _instance (??)
    return _instance ??= SqliteConnectionFactory._();
  }

  Future<Database> openConnection() async {
    var pathDevice = await getDatabasesPath();
    var pathFinal = join(pathDevice, _databaseName);

    if (_db == null) {
      await _lock.synchronized(() async {
        _db ??= await openDatabase(
          pathFinal,
          version: _version,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
        );
      });
    }
    return _db!;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.upgrade(batch);
    }
    batch.commit();
  }

  void closeConnection() {
    _db?.close();
    _db == null;
  }
}
