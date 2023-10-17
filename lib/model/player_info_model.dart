import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:flutter/cupertino.dart';

class PlayerInfoModel extends ChangeNotifier {
  PlayerInfo? _playerInfo;

  PlayerInfo? get playerInfo => _playerInfo;

  void updatePlayerInfo(PlayerInfo playerInfo) {
    _playerInfo = playerInfo;
    notifyListeners();
  }

  void clearPlayerInfo() {
    _playerInfo = null;
    notifyListeners();
  }
}
