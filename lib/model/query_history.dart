import 'package:hive/hive.dart';

class QueryHistory {
  static const String playerNameHistoryKey = 'playerNameHistoryHive';
  static const String playerPlatformHistoryKey = 'playerPlatformHistoryHive';
  static const String playerUidHistoryKey = 'playerUidHistoryHive';
  static const int maxHistoryLength = 6;
  List<String> playerNameHistory = <String>[];
  List<String> playerPlatformHistory = <String>[];
  List<String> playerUidHistory = <String>[];

  // async function to load history from Hive
  Future<void> loadHistory() async {
    final Box box = await Hive.openBox('queryHistoryHiveBox');
    playerNameHistory = box.get(playerNameHistoryKey, defaultValue: <String>[]);
    playerPlatformHistory =
        box.get(playerPlatformHistoryKey, defaultValue: <String>[]);
    playerUidHistory = box.get(playerUidHistoryKey, defaultValue: <String>[]);
  }

  // set history to playerNameHistory and playerPlatformHistory
  Future<void> setHistory(
      String playerName, String playerPlatform, String playerUid) async {
    final Box box = await Hive.openBox('queryHistoryHiveBox');
    if (!playerUidHistory.contains(playerUid)) {
      playerNameHistory.add(playerName);
      playerPlatformHistory.add(playerPlatform);
      playerUidHistory.add(playerUid);
      if (playerUidHistory.length > maxHistoryLength) {
        playerNameHistory.removeAt(0);
        playerPlatformHistory.removeAt(0);
        playerUidHistory.removeAt(0);
      }
      await box.put(playerNameHistoryKey, playerNameHistory);
      await box.put(playerPlatformHistoryKey, playerPlatformHistory);
      await box.put(playerUidHistoryKey, playerUidHistory);
    } else {
      final int index = playerUidHistory.indexOf(playerUid);
      playerNameHistory.removeAt(index);
      playerPlatformHistory.removeAt(index);
      playerUidHistory.removeAt(index);
      playerNameHistory.add(playerName);
      playerPlatformHistory.add(playerPlatform);
      playerUidHistory.add(playerUid);
      await box.put(playerNameHistoryKey, playerNameHistory);
      await box.put(playerPlatformHistoryKey, playerPlatformHistory);
      await box.put(playerUidHistoryKey, playerUidHistory);
    }
  }

  // delete player history by playerUid
  Future<void> deleteHistory(String playerUid) async {
    final Box box = await Hive.openBox('queryHistoryHiveBox');
    final int index = playerUidHistory.indexOf(playerUid);
    if (index != -1) {
      playerNameHistory.removeAt(index);
      playerPlatformHistory.removeAt(index);
      playerUidHistory.removeAt(index);
      await box.put(playerNameHistoryKey, playerNameHistory);
      await box.put(playerPlatformHistoryKey, playerPlatformHistory);
      await box.put(playerUidHistoryKey, playerUidHistory);
    }
  }
}
