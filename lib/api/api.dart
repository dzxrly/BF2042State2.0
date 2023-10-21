import 'dart:convert';
import 'dart:developer';

import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:http/http.dart' as http;

import 'bfban_check.dart';

class APIBase {
  final String gametoolsBaseAPI = 'https://api.gametools.network';

  // final String gametoolsBaseAPI = 'https://mock.apifox.cn/m1/2353382-0-default';
  final String giteeBaseAPI = 'https://gitee.com/api/v5';
}

class PlayerInfoAPI extends APIBase {
  Future<PlayerInfo> fetchPlayerInfo(String platform, String username,
      String userUid, bool useUidQuery) async {
    final String url =
        '$gametoolsBaseAPI/bf2042/stats/?raw=false&format_values=true&platform=$platform&skip_battlelog=false${useUidQuery ? '&nucleus_id=$userUid' : '&name=$username'}';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PlayerInfo.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw '查找的玩家不存在!';
    } else {
      log('Response status code: ${response.statusCode}, body: ${response.body}');
      throw '似乎发生了网络错误，请重试';
    }
  }
}

class BFBanCheckAPI extends APIBase {
  Future<BFBanCheck> fetchBFBanCheck(String userId) async {
    final String url = '$gametoolsBaseAPI/bfban/checkban/?userids=$userId';
    log(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return BFBanCheck.fromJson(jsonDecode(response.body)['userids'][userId]);
    } else if (response.statusCode == 404) {
      throw '查找的玩家不存在!';
    } else {
      log('Response status code: ${response.statusCode}, body: ${response.body}');
      throw '似乎发生了网络错误，请重试';
    }
  }
}
