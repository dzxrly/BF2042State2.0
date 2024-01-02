import 'dart:async';
import 'dart:convert';

import 'package:battlefield_2042_state/api/bftracker/bftracker_player_gadget_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_map_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_soldier_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_vehicle_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_weapon_info.dart';
import 'package:battlefield_2042_state/api/gametools/bf_play_info.dart';
import 'package:battlefield_2042_state/api/gametools/bfban_check.dart';
import 'package:battlefield_2042_state/api/gametools/gametools_player_info.dart';
import 'package:battlefield_2042_state/api/gametools/player_feslid.dart';
import 'package:battlefield_2042_state/api/version_check.dart';
import 'package:http/http.dart' as http;

class APIBase {
  final String gametoolsBaseAPI = 'https://api.gametools.network';
  final String bftrackerBaseAPI = 'https://api.tracker.gg/api/v2';

  // final String gametoolsBaseAPI = 'https://mock.apifox.cn/m1/2353382-0-default';
  final String giteeBaseAPI = 'https://gitee.com/api/v5';

  final timeout = const Duration(seconds: 15);
  final header = {
    'Accept': 'application/json, text/plain, */*',
    'Accept-Language': 'zh-HK,zh-CN;q=0.9,zh;q=0.8,en-US;q=0.7,en;q=0.6',
    'Cache-Control': 'no-cache',
  };
}

class GametoolsPlayerInfoAPI extends APIBase {
  Future<GametoolsPlayerInfo> fetchPlayerInfo(String platform, String username,
      String userUid, bool useUidQuery) async {
    final String url =
        '$gametoolsBaseAPI/bf2042/stats/?raw=false&format_values=true&platform=$platform&skip_battlelog=false${useUidQuery ? '&nucleus_id=$userUid' : '&name=$username'}';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          GametoolsPlayerInfo.fromJson(jsonDecode(response.body));
          return GametoolsPlayerInfo.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class BFTrackerPlayerInfoAPIMain extends APIBase {
  Future<BFTrackerPlayerInfo> fetchPlayerInfo(
      String platform, String playerName) async {
    final String url =
        '$bftrackerBaseAPI/bf2042/standard/profile/$platform/$playerName';
    try {
      final response =
          await http.get(Uri.parse(url), headers: header).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          BFTrackerPlayerInfo.fromJson(jsonDecode(response.body));
          return BFTrackerPlayerInfo.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else if (response.statusCode == 403) {
        throw '请求被服务器拒绝，请稍后再试';
      } else {
        throw '似乎发生了错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class BFTrackerPlayerInfoAPIWeapon extends APIBase {
  Future<BFTrackerWeapon> fetchPlayerInfo(
      String platform, String playerName) async {
    final String url =
        '$bftrackerBaseAPI/bf2042/standard/profile/$platform/$playerName/segments/weapon';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          BFTrackerWeapon.fromJson(jsonDecode(response.body));
          return BFTrackerWeapon.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else if (response.statusCode == 403) {
        throw '请求被服务器拒绝，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class BFTrackerPlayerInfoAPIVehicle extends APIBase {
  Future<BFTrackerVehicle> fetchPlayerInfo(
      String platform, String playerName) async {
    final String url =
        '$bftrackerBaseAPI/bf2042/standard/profile/$platform/$playerName/segments/vehicle';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          BFTrackerVehicle.fromJson(jsonDecode(response.body));
          return BFTrackerVehicle.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else if (response.statusCode == 403) {
        throw '请求被服务器拒绝，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class BFTrackerPlayerInfoAPIMap extends APIBase {
  Future<BFTrackerMap> fetchPlayerInfo(
      String platform, String playerName) async {
    final String url =
        '$bftrackerBaseAPI/bf2042/standard/profile/$platform/$playerName/segments/map';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          BFTrackerMap.fromJson(jsonDecode(response.body));
          return BFTrackerMap.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else if (response.statusCode == 403) {
        throw '请求被服务器拒绝，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class BFTrackerPlayerInfoAPIGadgets extends APIBase {
  Future<BFTrackerGadgets> fetchPlayerInfo(
      String platform, String playerName) async {
    final String url =
        '$bftrackerBaseAPI/bf2042/standard/profile/$platform/$playerName/segments/gadgets';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          BFTrackerGadgets.fromJson(jsonDecode(response.body));
          return BFTrackerGadgets.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else if (response.statusCode == 403) {
        throw '请求被服务器拒绝，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class BFTrackerPlayerInfoAPISoldier extends APIBase {
  Future<BFTrackerSoldier> fetchPlayerInfo(
      String platform, String playerName) async {
    final String url =
        '$bftrackerBaseAPI/bf2042/standard/profile/$platform/$playerName/segments/soldier';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);
      if (response.statusCode == 200) {
        try {
          BFTrackerSoldier.fromJson(jsonDecode(response.body));
          return BFTrackerSoldier.fromJson(jsonDecode(response.body));
        } catch (e) {
          throw '该用户似乎没有玩过战地2042';
        }
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else if (response.statusCode == 403) {
        throw '请求被服务器拒绝，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class PostPlayerFeslidAPI extends APIBase {
  Future<PlayerFeslid> postPlayerFeslid(
    String platformId,
    String personaId,
    String nucleusId,
  ) async {
    final String url = '$gametoolsBaseAPI/bf2042/feslid/';
    try {
      final response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'platformId': platformId,
            'personaId': personaId,
            'nucleusId': nucleusId,
          }),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          }).timeout(timeout);
      if (response.statusCode == 200) {
        return PlayerFeslid.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else if (response.statusCode == 408 ||
          response.statusCode == 503 ||
          response.statusCode == 504) {
        throw '服务器错误，请稍后再试';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      // if error is http client error, return '似乎发生了网络错误，请重试',
      // else return error message
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}

class BFPlayInfoAPI extends APIBase {
  Future<BFPlayInfo> fetchBFPlayInfo(String playerId) async {
    final String url = '$gametoolsBaseAPI/bfglobal/games/?playerid=$playerId';
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeout);

      if (response.statusCode == 200) {
        return BFPlayInfo.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw '查找的玩家不存在!';
      } else {
        throw '似乎发生了网络错误，请重试';
      }
    } on TimeoutException catch (_) {
      throw '请求超时，请稍后再试';
    } catch (e) {
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
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
    } catch (e) {
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
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
    } catch (e) {
      if (e.toString().contains('ClientException')) {
        throw '似乎发生了网络错误，请重试';
      } else {
        rethrow;
      }
    }
  }
}
