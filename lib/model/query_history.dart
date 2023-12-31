import 'package:shared_preferences/shared_preferences.dart';

class QueryHistory {
  static const String playerNameHistoryKey = 'playerNameHistory';
  static const String playerPlatformHistoryKey = 'playerPlatformHistory';
  static const String playerUidHistoryKey = 'playerUidHistory';
  static const int maxHistoryLength = 6;
  List<String> playerNameHistory = <String>[];
  List<String> playerPlatformHistory = <String>[];
  List<String> playerUidHistory = <String>[];

  // async function to load history from shared preferences
  Future<void> loadHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    playerNameHistory = prefs.getStringList(playerNameHistoryKey) ?? <String>[];
    playerPlatformHistory =
        prefs.getStringList(playerPlatformHistoryKey) ?? <String>[];
    playerUidHistory = prefs.getStringList(playerUidHistoryKey) ?? <String>[];
  }

  // set history to playerNameHistory and playerPlatformHistory
  Future<void> setHistory(
      String playerName, String playerPlatform, String playerUid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!playerUidHistory.contains(playerUid)) {
      playerNameHistory.add(playerName);
      playerPlatformHistory.add(playerPlatform);
      playerUidHistory.add(playerUid);
      if (playerUidHistory.length > maxHistoryLength) {
        playerNameHistory.removeAt(0);
        playerPlatformHistory.removeAt(0);
        playerUidHistory.removeAt(0);
      }
      await prefs.setStringList(
          playerNameHistoryKey, playerNameHistory.toList());
      await prefs.setStringList(
          playerPlatformHistoryKey, playerPlatformHistory.toList());
      await prefs.setStringList(playerUidHistoryKey, playerUidHistory.toList());
    } else {
      final int index = playerUidHistory.indexOf(playerUid);
      playerNameHistory.removeAt(index);
      playerPlatformHistory.removeAt(index);
      playerUidHistory.removeAt(index);
      playerNameHistory.add(playerName);
      playerPlatformHistory.add(playerPlatform);
      playerUidHistory.add(playerUid);
      await prefs.setStringList(
          playerNameHistoryKey, playerNameHistory.toList());
      await prefs.setStringList(
          playerPlatformHistoryKey, playerPlatformHistory.toList());
      await prefs.setStringList(playerUidHistoryKey, playerUidHistory.toList());
    }
  }

  // delete player history by playerUid
  Future<void> deleteHistory(String playerUid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int index = playerUidHistory.indexOf(playerUid);
    if (index != -1) {
      playerNameHistory.removeAt(index);
      playerPlatformHistory.removeAt(index);
      playerUidHistory.removeAt(index);
      await prefs.setStringList(
          playerNameHistoryKey, playerNameHistory.toList());
      await prefs.setStringList(
          playerPlatformHistoryKey, playerPlatformHistory.toList());
      await prefs.setStringList(playerUidHistoryKey, playerUidHistory.toList());
    }
  }
}
