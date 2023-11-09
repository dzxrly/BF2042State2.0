import 'dart:async';
import 'dart:convert';

import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:battlefield_2042_state/api/version_check.dart';
import 'package:http/http.dart' as http;

import 'bfban_check.dart';

class APIBase {
  final String gametoolsBaseAPI = 'https://api.gametools.network';

  // final String gametoolsBaseAPI = 'https://mock.apifox.cn/m1/2353382-0-default';
  final String giteeBaseAPI = 'https://gitee.com/api/v5';

  final timeout = const Duration(seconds: 30);
}

class PlayerInfoAPI extends APIBase {
  Future<PlayerInfo> fetchPlayerInfo(String platform, String username,
      String userUid, bool useUidQuery) async {
    final String url =
        '$gametoolsBaseAPI/bf2042/stats/?raw=false&format_values=true&platform=$platform&skip_battlelog=false${useUidQuery ? '&nucleus_id=$userUid' : '&name=$username'}';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          PlayerInfo.fromJson(jsonDecode(response.body));
          return PlayerInfo.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw 'Gametools服务器错误，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (_) {
      throw '似乎发生了错误，请重试';
    }
  }
}

class BFBanCheckAPI extends APIBase {
  Future<BFBanCheck> fetchBFBanCheck(String userId) async {
    final String url = '$gametoolsBaseAPI/bfban/checkban/?userids=$userId';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);

      if (response.statusCode == 200) {
        return BFBanCheck.fromJson(
            jsonDecode(response.body)['userids'][userId]);
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (_) {
      throw '似乎发生了错误，请重试';
    }
  }
}

class GiteeVersionCheckAPI extends APIBase {
  Future<GiteeVersionCheck> fetchGiteeVersionCheck() async {
    final String url =
        '$giteeBaseAPI/repos/egg-targaryen/BF2042State2.0/releases/latest';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);

      if (response.statusCode == 200) {
        return GiteeVersionCheck.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (_) {
      throw '似乎发生了错误，请重试';
    }
  }
}
