import 'package:sqflite/sqflite.dart';

/// 数据库抽象类
/// DatabaseExecutor 暂时使用sqflite的实现
abstract class DatabaseType extends DatabaseExecutor {
  String get path;

  Future<void> close();

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action,
      {bool exclusive});

  Future<int> getVersion();

  bool get isOpen;

  Future<void> setVersion(int version);
}

/// 数据库默认实现
class DatabaseWrapper implements DatabaseType {
  final Database database;

  DatabaseWrapper(this.database);

  @override
  Batch batch() => database.batch();

  @override
  Future<void> close() => database.close();

  @override
  Future<int> delete(String table, {String where, List whereArgs}) =>
      database.delete(table, where: where, whereArgs: whereArgs);

  @override
  Future<void> execute(String sql, [List arguments]) =>
      database.execute(sql, arguments);

  @override
  Future<int> getVersion() => database.getVersion();

  @override
  Future<int> insert(String table, Map<String, dynamic> values,
          {String nullColumnHack, ConflictAlgorithm conflictAlgorithm}) =>
      database.insert(table, values,
          nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);

  @override
  bool get isOpen => database.isOpen;

  @override
  String get path => database.path;

  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {bool distinct,
      List<String> columns,
      String where,
      List whereArgs,
      String groupBy,
      String having,
      String orderBy,
      int limit,
      int offset}) {
    return database.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
  }

  @override
  Future<int> rawDelete(String sql, [List arguments]) =>
      database.rawDelete(sql, arguments);

  @override
  Future<int> rawInsert(String sql, [List arguments]) =>
      database.rawInsert(sql, arguments);

  @override
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List arguments]) =>
      database.rawQuery(sql, arguments);

  @override
  Future<int> rawUpdate(String sql, [List arguments]) =>
      database.rawUpdate(sql, arguments);

  @override
  Future<void> setVersion(int version) => database.setVersion(version);

  @override
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action,
          {bool exclusive}) =>
      database.transaction((txn) => action(txn), exclusive: exclusive);

  @override
  Future<int> update(String table, Map<String, dynamic> values,
          {String where,
          List whereArgs,
          ConflictAlgorithm conflictAlgorithm}) =>
      database.update(table, values,
          where: where,
          whereArgs: whereArgs,
          conflictAlgorithm: conflictAlgorithm);
}

class UnitTestDataBase {}
