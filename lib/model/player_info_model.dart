import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:flutter/cupertino.dart';

class PlayerInfoModel extends ChangeNotifier {
  PlayerInfo? _playerInfo;
  IconData? _iconData;

  PlayerInfo? get playerInfo => _playerInfo;

  IconData? get iconData => _iconData;

  void updatePlayerInfo(PlayerInfo playerInfo, IconData? iconData) {
    _iconData = iconData;
    _playerInfo = playerInfo;
    notifyListeners();
  }

  void clearPlayerInfo() {
    _iconData = null;
    _playerInfo = null;
    notifyListeners();
  }
}
