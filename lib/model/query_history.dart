import 'dart:developer';

import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    if (!PlatformUtils.isWeb) initQueryHistoryDatabase();
    log(PlatformUtils.isWeb ? 'Using Hive' : 'Using SQLite');
  }

  final int maxQueryHistory = 10;
  late final Future<Database> database;

  // for web, using Hive package to store the query history
  static const String hivePlayerNameHistoryKey = 'playerNameHistoryHive';
  static const String hivePlayerPlatformHistoryKey =
      'playerPlatformHistoryHive';
  static const String hivePlayerUidHistoryKey = 'playerUidHistoryHive';
  List<String> hivePlayerNameHistory = <String>[];
  List<String> hivePlayerPlatformHistory = <String>[];
  List<String> hivePlayerUidHistory = <String>[];

  void initQueryHistoryDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'query_history.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE query_history(name TEXT, platform TEXT, uid TEXT PRIMARY KEY)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertQueryHistory(QueryHistoryInterface queryHistory) async {
    if (PlatformUtils.isWeb) {
      final playerUid = queryHistory.uid;
      final playerName = queryHistory.name;
      final playerPlatform = queryHistory.platform;
      final Box box = await Hive.openBox('queryHistoryHiveBox');
      if (!hivePlayerUidHistory.contains(playerUid)) {
        hivePlayerNameHistory.add(playerName);
        hivePlayerPlatformHistory.add(playerPlatform);
        hivePlayerUidHistory.add(playerUid);
        if (hivePlayerUidHistory.length > maxQueryHistory) {
          hivePlayerNameHistory.removeAt(0);
          hivePlayerPlatformHistory.removeAt(0);
          hivePlayerUidHistory.removeAt(0);
        }
        box.put(hivePlayerNameHistoryKey, hivePlayerNameHistory);
        box.put(hivePlayerPlatformHistoryKey, hivePlayerPlatformHistory);
        box.put(hivePlayerUidHistoryKey, hivePlayerUidHistory);
      } else {
        final int index = hivePlayerUidHistory.indexOf(playerUid);
        hivePlayerNameHistory.removeAt(index);
        hivePlayerPlatformHistory.removeAt(index);
        hivePlayerUidHistory.removeAt(index);
        hivePlayerNameHistory.add(playerName);
        hivePlayerPlatformHistory.add(playerPlatform);
        hivePlayerUidHistory.add(playerUid);
        box.put(hivePlayerNameHistoryKey, hivePlayerNameHistory);
        box.put(hivePlayerPlatformHistoryKey, hivePlayerPlatformHistory);
        box.put(hivePlayerUidHistoryKey, hivePlayerUidHistory);
      }
    } else {
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
  }

  Future<List<QueryHistoryInterface>> queryAllQueryHistory() async {
    if (PlatformUtils.isWeb) {
      final Box box = await Hive.openBox('queryHistoryHiveBox');
      hivePlayerNameHistory =
          box.get(hivePlayerNameHistoryKey, defaultValue: <String>[]);
      hivePlayerPlatformHistory =
          box.get(hivePlayerPlatformHistoryKey, defaultValue: <String>[]);
      hivePlayerUidHistory =
          box.get(hivePlayerUidHistoryKey, defaultValue: <String>[]);
      return List<QueryHistoryInterface>.generate(hivePlayerNameHistory.length,
          (i) {
        return QueryHistoryInterface(
          name: hivePlayerNameHistory[i],
          platform: hivePlayerPlatformHistory[i],
          uid: hivePlayerUidHistory[i],
        );
      });
    } else {
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
  }

  Future<void> deleteQueryHistory(String uid) async {
    if (PlatformUtils.isWeb) {
      final Box box = await Hive.openBox('queryHistoryHiveBox');
      final int index = hivePlayerUidHistory.indexOf(uid);
      if (index != -1) {
        hivePlayerNameHistory.removeAt(index);
        hivePlayerPlatformHistory.removeAt(index);
        hivePlayerUidHistory.removeAt(index);
        box.put(hivePlayerNameHistoryKey, hivePlayerNameHistory);
        box.put(hivePlayerPlatformHistoryKey, hivePlayerPlatformHistory);
        box.put(hivePlayerUidHistoryKey, hivePlayerUidHistory);
      } else {
        final Database db = await database;
        await db.delete(
          'query_history',
          where: 'uid = ?',
          whereArgs: [uid],
        );
      }
    }
  }

  Future<bool> isNameExist(String name) async {
    if (PlatformUtils.isWeb) {
      final Box box = await Hive.openBox('queryHistoryHiveBox');
      return box.get(hivePlayerNameHistoryKey,
          defaultValue: <String>[]).contains(name);
    } else {
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
}
