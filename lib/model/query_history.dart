import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class QueryHistoryInterface {
  const QueryHistoryInterface({
    required this.name,
    required this.platform,
    required this.uid,
  });

  final String name;
  final String platform;
  final String uid;

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'platform': platform,
      'uid': uid,
    };
  }

  @override
  String toString() {
    return 'query_history{name: $name, platform: $platform, uid: $uid}';
  }
}

class QueryHistory {
  QueryHistory() {
    initQueryHistoryDatabase();
  }

  final int maxQueryHistory = 10;
  late final Future<Database> database;

  void initQueryHistoryDatabase() async {
    if (PlatformUtils.isWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    database = openDatabase(
      join(
        await getDatabasesPath(),
        'query_history.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE query_history(name TEXT, platform TEXT, uid TEXT PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertQueryHistory(QueryHistoryInterface queryHistory) async {
    final Database db = await database;
    // only save the last 10 queries, if there are more than 10, delete the oldest one
    // and insert the new one
    // uid is the unique identifier for the query, if the query is the same, update the time
    await db.insert(
      'query_history',
      queryHistory.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final List<Map<String, dynamic>> queryHistoryList =
    await db.query('query_history');
    if (queryHistoryList.length > maxQueryHistory) {
      await db.delete(
        'query_history',
        where: 'uid = ?',
        whereArgs: [queryHistoryList[0]['uid']],
      );
    }
  }

  Future<List<QueryHistoryInterface>> queryAllQueryHistory() async {
    final Database db = await database;
    final List<Map<String, dynamic>> queryHistoryList =
    await db.query('query_history');
    return List<QueryHistoryInterface>.generate(queryHistoryList.length, (i) {
      return QueryHistoryInterface(
        name: queryHistoryList[i]['name'],
        platform: queryHistoryList[i]['platform'],
        uid: queryHistoryList[i]['uid'],
      );
    });
  }

  Future<void> deleteQueryHistory(String uid) async {
    final Database db = await database;
    await db.delete(
      'query_history',
      where: 'uid = ?',
      whereArgs: [uid],
    );
  }

  Future<bool> isNameExist(String name) async {
    final Database db = await database;
    final List<Map<String, dynamic>> queryHistoryList =
    await db.query('query_history');
    for (int i = 0; i < queryHistoryList.length; i++) {
      if (queryHistoryList[i]['name'] == name) {
        return true;
      }
    }
    return false;
  }
}
