import 'package:battlefield_2042_state/api/gametools/gametools_player_info.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WeaponInfoEnsemble {
  WeaponInfoEnsemble(
      this.weaponName,
      this.weaponId,
      this.kills,
      this.KPM,
      this.DPM,
      this.hsRate,
      this.accuracy,
      this.damage,
      this.multiKills,
      this.efficiency,
      this.playedTime);

  final String weaponName;
  final String weaponId;
  final String kills;
  final String KPM;
  final String DPM;
  final String hsRate;
  final String accuracy;
  final String damage;
  final String multiKills;
  final String efficiency;
  final String playedTime;
}

class VehicleInfoEnsemble {
  VehicleInfoEnsemble(
      this.vehicleName,
      this.vehicleId,
      this.kills,
      this.KPM,
      this.damage,
      this.multiKills,
      this.playedTime,
      this.killedVehicle,
      this.roadKills,
      this.driverAssists,
      this.passengerAssists,
      this.distanceTraveled);

  final String vehicleName;
  final String vehicleId;
  final String kills;
  final String KPM;
  final String killedVehicle;
  final String roadKills;
  final String damage;
  final String multiKills;
  final String driverAssists;
  final String passengerAssists;
  final String distanceTraveled;
  final String playedTime;
}

class GadgetInfoEnsemble {
  GadgetInfoEnsemble(this.gadgetName, this.gadgetId, this.kills, this.KPM,
      this.damage, this.killedVehicle, this.multiKills, this.used);

  final String gadgetName;
  final String gadgetId;
  final String kills;
  final String KPM;
  final String damage;
  final String killedVehicle;
  final String multiKills;
  final String used;
}

class CharacterInfoEnsemble {
  CharacterInfoEnsemble(this.characterName, this.characterId, this.kills,
      this.KPM, this.KD, this.deaths, this.className, this.playedTime);

  final String characterName;
  final String characterId;
  final String kills;
  final String KPM;
  final String KD;
  final String deaths;
  final String className;
  final String playedTime;
}

class GameModeInfoEnsemble {
  GameModeInfoEnsemble(
      this.modeName,
      this.modeId,
      this.kills,
      this.KPM,
      this.playedMatches,
      this.win,
      this.lose,
      this.winRate,
      this.objectTime,
      this.sectorDefend,
      this.objectDefend,
      this.objectCapture,
      this.boomPlant,
      this.boomDefuse,
      this.boomDestroy,
      this.playedTime);

  final String modeName;
  final String modeId;
  final String kills;
  final String KPM;
  final String playedMatches;
  final String playedTime;
  final String win;
  final String lose;
  final String winRate;
  final String objectTime;
  final String sectorDefend;
  final String objectDefend;
  final String objectCapture;
  final String boomPlant;
  final String boomDefuse;
  final String boomDestroy;
}

class MapInfoEnsemble {
  MapInfoEnsemble(this.mapName, this.mapId, this.win, this.lose, this.winRate,
      this.playedTime, this.playedMatches);

  final String mapName;
  final String mapId;
  final String playedMatches;
  final String win;
  final String lose;
  final String winRate;
  final String playedTime;
}

class PlayerInfoEnsemble {
  PlayerInfoEnsemble()
      : avatar = '#',
        nucleusId = '未知',
        username = '未知',
        personaId = '未知',
        playedTime = '未知',
        realKD = '未知',
        realKPM = '未知',
        hsRate = '未知',
        realKills = '未知',
        readKillRate = '未知',
        damagePerMatch = '未知',
        winRate = '未知',
        damagePerMinute = '未知',
        accuracy = '未知',
        killsPerMatch = '未知',
        playedMatches = '未知',
        kills = '未知',
        deaths = '未知',
        assists = '未知',
        KD = '未知',
        KPM = '未知',
        damage = '未知',
        MVP = '未知',
        bestSquad = '未知',
        win = '未知',
        lose = '未知',
        killedVehicle = '未知',
        spotEnemy = '未知',
        recovery = '未知',
        supply = '未知',
        repair = '未知',
        weapons = [],
        vehicles = [],
        gadgets = [],
        characters = [],
        gameModes = [],
        maps = [];

  PlayerInfoEnsemble.gametoolsAPI(GametoolsPlayerInfo playerInfo)
      : avatar = '#',
        nucleusId = '未知',
        username = '未知',
        personaId = '未知',
        playedTime = '未知',
        realKD = '未知',
        realKPM = '未知',
        hsRate = '未知',
        realKills = '未知',
        readKillRate = '未知',
        damagePerMatch = '未知',
        winRate = '未知',
        damagePerMinute = '未知',
        accuracy = '未知',
        killsPerMatch = '未知',
        playedMatches = '未知',
        kills = '未知',
        deaths = '未知',
        assists = '未知',
        KD = '未知',
        KPM = '未知',
        damage = '未知',
        MVP = '未知',
        bestSquad = '未知',
        win = '未知',
        lose = '未知',
        killedVehicle = '未知',
        spotEnemy = '未知',
        recovery = '未知',
        supply = '未知',
        repair = '未知',
        weapons = [],
        vehicles = [],
        gadgets = [],
        characters = [],
        gameModes = [],
        maps = [] {
    final NumberFormat timeFormat = NumberFormat('#,###.00');

    avatar = playerInfo.avatar ?? '#';
    nucleusId = playerInfo.userId != null ? playerInfo.userId.toString() : '未知';
    username = playerInfo.userName ?? '未知';
    personaId = playerInfo.id != null ? playerInfo.id.toString() : '未知';
    playedTime =
        '${timeFormat.format((playerInfo.secondsPlayed ?? 0) / 3600)}小时';

    final double realKillsRate =
        double.parse((playerInfo.humanPrecentage ?? '0').replaceAll('%', '')) /
            100;
    realKills = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.kills ?? 0) * realKillsRate, 0);
    realKD = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.killDeath ?? 0) * realKillsRate, 2);
    realKPM = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.killsPerMinute ?? 0) * realKillsRate, 2);
    hsRate = playerInfo.headshots ?? '0.0%';
    readKillRate = playerInfo.humanPrecentage ?? '0.0%';
    damagePerMatch = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.damagePerMatch ?? 0), 2);
    winRate = playerInfo.winPercent ?? '0.0%';
    damagePerMinute = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.damagePerMinute ?? 0), 2);
    accuracy = playerInfo.accuracy ?? '0.0%';
    killsPerMatch = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.killsPerMatch ?? 0), 2);
    playedMatches =
        UtilTools.parseIntAsENUSFormat(playerInfo.matchesPlayed ?? 0);

    kills = UtilTools.parseIntAsENUSFormat(playerInfo.kills ?? 0);
    deaths = UtilTools.parseIntAsENUSFormat(playerInfo.deaths ?? 0);
    assists = UtilTools.parseIntAsENUSFormat(playerInfo.killAssists ?? 0);
    KD = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.killDeath ?? 0), 2);
    KPM = UtilTools.parseDoubleAsFixedAndENUSFormat(
        (playerInfo.killsPerMinute ?? 0), 2);
    damage = UtilTools.parseIntAsENUSFormat(playerInfo.damage ?? 0);
    MVP = UtilTools.parseIntAsENUSFormat(playerInfo.mvp ?? 0);
    bestSquad = UtilTools.parseIntAsENUSFormat(playerInfo.bestSquad ?? 0);
    win = UtilTools.parseIntAsENUSFormat(playerInfo.wins ?? 0);
    lose = UtilTools.parseIntAsENUSFormat(playerInfo.loses ?? 0);
    killedVehicle =
        UtilTools.parseIntAsENUSFormat(playerInfo.vehiclesDestroyed ?? 0);
    spotEnemy = UtilTools.parseIntAsENUSFormat(playerInfo.enemiesSpotted ?? 0);
    recovery = UtilTools.parseIntAsENUSFormat(playerInfo.heals ?? 0);
    supply = UtilTools.parseIntAsENUSFormat(playerInfo.resupplies ?? 0);
    repair = UtilTools.parseIntAsENUSFormat(playerInfo.repairs ?? 0);

    if (playerInfo.weapons != null) {
      playerInfo.weapons?.forEach((weapon) => weapons.add(WeaponInfoEnsemble(
          weapon.weaponName ?? '未知',
          weapon.id ?? '未知',
          UtilTools.parseIntAsENUSFormat(weapon.kills ?? 0),
          UtilTools.parseDoubleAsFixedAndENUSFormat(
              weapon.killsPerMinute ?? 0, 2),
          UtilTools.parseDoubleAsFixedAndENUSFormat(
              weapon.damagePerMinute ?? 0, 2),
          '${((weapon.headshotKills ?? 0) / (weapon.kills ?? 1) * 100).toStringAsFixed(2)}%',
          '${((weapon.shotsHit ?? 0) / (weapon.shotsFired ?? 1) * 100).toStringAsFixed(2)}%',
          UtilTools.parseIntAsENUSFormat(weapon.damage ?? 0),
          UtilTools.parseIntAsENUSFormat(weapon.multiKills ?? 0),
          (weapon.hitVKills ?? 0.0).toStringAsFixed(2),
          '${timeFormat.format((weapon.timeEquipped ?? 0) / 3600)}小时')));
    }

    if (playerInfo.vehicles != null) {
      playerInfo.vehicles?.forEach((vehicle) => vehicles.add(
          VehicleInfoEnsemble(
              vehicle.vehicleName ?? '未知',
              vehicle.id ?? '未知',
              UtilTools.parseIntAsENUSFormat(vehicle.kills ?? 0),
              UtilTools.parseDoubleAsFixedAndENUSFormat(
                  vehicle.killsPerMinute ?? 0, 2),
              UtilTools.parseIntAsENUSFormat(vehicle.damage ?? 0),
              UtilTools.parseIntAsENUSFormat(vehicle.multiKills ?? 0),
              '${timeFormat.format((vehicle.timeIn ?? 0) / 3600)}小时',
              UtilTools.parseIntAsENUSFormat(
                  vehicle.vehiclesDestroyedWith ?? 0),
              UtilTools.parseIntAsENUSFormat(vehicle.roadKills ?? 0),
              UtilTools.parseIntAsENUSFormat(vehicle.driverAssists ?? 0),
              UtilTools.parseIntAsENUSFormat(vehicle.passengerAssists ?? 0),
              UtilTools.parseIntAsENUSFormat(vehicle.distanceTraveled ?? 0))));
    }

    if (playerInfo.gadgets != null) {
      playerInfo.gadgets?.forEach((gadget) => gadgets.add(GadgetInfoEnsemble(
          gadget.gadgetName ?? '未知',
          gadget.id ?? '未知',
          UtilTools.parseIntAsENUSFormat(gadget.kills ?? 0),
          UtilTools.parseDoubleAsFixedAndENUSFormat(gadget.kpm ?? 0, 2),
          UtilTools.parseIntAsENUSFormat(gadget.damage ?? 0),
          UtilTools.parseIntAsENUSFormat(gadget.vehiclesDestroyedWith ?? 0),
          UtilTools.parseIntAsENUSFormat(gadget.multiKills ?? 0),
          UtilTools.parseIntAsENUSFormat(gadget.uses ?? 0))));
    }

    if (playerInfo.classes != null) {
      playerInfo.classes?.forEach((character) => characters.add(
          CharacterInfoEnsemble(
              character.characterName ?? '未知',
              character.id ?? '未知',
              UtilTools.parseIntAsENUSFormat(character.kills ?? 0),
              UtilTools.parseDoubleAsFixedAndENUSFormat(character.kpm ?? 0, 2),
              UtilTools.parseDoubleAsFixedAndENUSFormat(
                  character.killDeath ?? 0, 2),
              UtilTools.parseIntAsENUSFormat(character.deaths ?? 0),
              character.className ?? '未知',
              '${timeFormat.format((character.secondsPlayed ?? 0) / 3600)}小时')));
    }

    if (playerInfo.gamemodes != null) {
      playerInfo.gamemodes?.forEach((gameMode) => gameModes.add(
          GameModeInfoEnsemble(
              gameMode.gamemodeName ?? '未知',
              gameMode.id ?? '未知',
              UtilTools.parseIntAsENUSFormat(gameMode.kills ?? 0),
              UtilTools.parseDoubleAsFixedAndENUSFormat(gameMode.kpm ?? 0, 2),
              UtilTools.parseIntAsENUSFormat(gameMode.matches ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.wins ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.losses ?? 0),
              gameMode.winPercent ?? '0.0%',
              UtilTools.parseIntAsENUSFormat(gameMode.objetiveTime ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.sectorDefend ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.objectivesDefended ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.objectivesCaptured ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.objectivesArmed ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.objectivesDisarmed ?? 0),
              UtilTools.parseIntAsENUSFormat(gameMode.objectivesDestroyed ?? 0),
              '${timeFormat.format((gameMode.secondsPlayed ?? 0) / 3600)}小时')));
    }

    if (playerInfo.maps != null) {
      playerInfo.maps?.forEach((map) => maps.add(MapInfoEnsemble(
          map.mapName ?? '未知',
          map.id ?? '未知',
          UtilTools.parseIntAsENUSFormat(map.wins ?? 0),
          UtilTools.parseIntAsENUSFormat(map.losses ?? 0),
          map.winPercent ?? '0.0%',
          '${timeFormat.format((map.secondsPlayed ?? 0) / 3600)}小时',
          UtilTools.parseIntAsENUSFormat(map.matches ?? 0))));
    }
  }

  String avatar;
  String nucleusId;
  String username;
  String personaId;
  String playedTime;

  String realKD;
  String realKPM;
  String hsRate;
  String realKills;
  String readKillRate;
  String damagePerMatch;
  String winRate;
  String damagePerMinute;
  String accuracy;
  String killsPerMatch;
  String playedMatches;

  String kills;
  String deaths;
  String assists;
  String KD;
  String KPM;
  String damage;
  String MVP;
  String bestSquad;
  String win;
  String lose;
  String killedVehicle;
  String spotEnemy;
  String recovery;
  String supply;
  String repair;

  List<WeaponInfoEnsemble> weapons;
  List<VehicleInfoEnsemble> vehicles;
  List<GadgetInfoEnsemble> gadgets;
  List<CharacterInfoEnsemble> characters;
  List<GameModeInfoEnsemble> gameModes;
  List<MapInfoEnsemble> maps;
}

class PlayerInfoModel extends ChangeNotifier {
  late PlayerInfoEnsemble _playerInfoEnsemble;
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
    _playerInfoEnsemble = null as PlayerInfoEnsemble;
    _platform = null;
    notifyListeners();
  }
}
