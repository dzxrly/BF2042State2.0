import 'package:battlefield_2042_state/api/gametools/bf_play_info.dart';
import 'package:battlefield_2042_state/api/gametools/gametools_player_info.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:flutter/cupertino.dart';

class PlayerInfoModel extends ChangeNotifier {
  late PlayerInfoEnsemble _playerInfoEnsemble;
  BFPlayInfo? _bfPlayInfo;
  IconData? _iconData;
  String? _platform;

  PlayerInfoEnsemble get playerInfoEnsemble => _playerInfoEnsemble;

  IconData? get iconData => _iconData;

  String? get platform => _platform;

  void updatePlayerInfo(PlayerInfoEnsemble playerInfoEnsemble,
      IconData? iconData, String? platform) {
    _iconData = iconData;
    _playerInfoEnsemble = playerInfoEnsemble;
    _platform = platform;
    notifyListeners();
  }

  void clearPlayerInfo() {
    _iconData = null;
    _playerInfoEnsemble =
        PlayerInfoEnsemble.gametoolsAPI(GametoolsPlayerInfo());
    _platform = null;
    notifyListeners();
  }
}
