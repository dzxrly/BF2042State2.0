import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:flutter/cupertino.dart';

class PlayerInfoModel extends ChangeNotifier {
  PlayerInfo? _playerInfo;
  IconData? _iconData;
  String? _platform;

  PlayerInfo? get playerInfo => _playerInfo;

  IconData? get iconData => _iconData;

  String? get platform => _platform;

  void updatePlayerInfo(
      PlayerInfo playerInfo, IconData? iconData, String? platform) {
    _iconData = iconData;
    _playerInfo = playerInfo;
    _platform = platform;
    notifyListeners();
  }

  void clearPlayerInfo() {
    _iconData = null;
    _playerInfo = null;
    _platform = null;
    notifyListeners();
  }
}
