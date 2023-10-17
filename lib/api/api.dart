import 'dart:convert';

import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:http/http.dart' as http;

class APIBase {
  final String gametoolsBaseAPI = 'https://api.gametools.network';
  final String giteeBaseAPI = 'https://api.gitee.com';
}

class PlayerInfoAPIByName extends APIBase {
  Future<PlayerInfo> fetchPlayerInfoByName(
      String platform, String username) async {
    final String url =
        '$gametoolsBaseAPI/bf2042/stats/?raw=false&format_values=true&name=$username&platform=$platform&skip_battlelog=false';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PlayerInfo.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('查找的玩家不存在!');
    } else {
      throw Exception('似乎发生了网络错误，请重试');
    }
  }
}
