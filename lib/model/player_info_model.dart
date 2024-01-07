import 'package:battlefield_2042_state/api/bftracker/bftracker_player_gadget_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_map_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_soldier_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_vehicle_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_weapon_info.dart';
import 'package:battlefield_2042_state/api/gametools/bf_play_info.dart';
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
  PlayerInfoEnsemble.gametoolsAPI(GametoolsPlayerInfo playerInfo)
      : avatar = '#',
        nucleusId = '未知',
        username = '未知',
        personaId = '未知',
        playedTime = '未知',
        realKD = 0.0,
        realKPM = 0.0,
        hsRate = '未知',
        realKills = 0,
        readKillRate = '未知',
        damagePerMatch = 0.0,
        winRate = '未知',
        damagePerMinute = 0.0,
        accuracy = '未知',
        killsPerMatch = 0.0,
        playedMatches = 0,
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
    realKills = ((playerInfo.kills ?? 0) * realKillsRate).toInt();
    realKD = (playerInfo.killDeath ?? 0) * realKillsRate;
    realKPM = (playerInfo.killsPerMinute ?? 0) * realKillsRate;
    hsRate = playerInfo.headshots ?? '0.0%';
    readKillRate = playerInfo.humanPrecentage ?? '0.0%';
    damagePerMatch = playerInfo.damagePerMatch ?? 0;
    winRate = playerInfo.winPercent ?? '0.0%';
    damagePerMinute = playerInfo.damagePerMinute ?? 0;
    accuracy = playerInfo.accuracy ?? '0.0%';
    killsPerMatch = playerInfo.killsPerMatch ?? 0;
    playedMatches = playerInfo.matchesPlayed ?? 0;

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

  PlayerInfoEnsemble.bftracker(
    BFTrackerPlayerInfo playerInfo,
    BFTrackerWeapon weaponInfo,
    BFTrackerVehicle vehicleInfo,
    BFTrackerGadgets gadgetsInfo,
    BFTrackerSoldier soldierInfo,
    BFTrackerMap mapInfo,
  )
      : avatar = '#',
        nucleusId = '未知',
        username = '未知',
        personaId = '未知',
        playedTime = '未知',
        realKD = 0.0,
        realKPM = 0.0,
        hsRate = '未知',
        realKills = 0,
        readKillRate = '未知',
        damagePerMatch = 0.0,
        winRate = '未知',
        damagePerMinute = 0.0,
        accuracy = '未知',
        killsPerMatch = 0.0,
        playedMatches = 0,
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

    avatar = playerInfo.data?.platformInfo?.avatarUrl ?? '#';
    nucleusId = playerInfo.data?.platformInfo?.platformUserId ?? '未知';
    username = playerInfo.data?.platformInfo?.platformUserIdentifier ?? '未知';
    final overviewSegment = playerInfo.data?.segments
        ?.firstWhere((element) => element.type == 'overview');
    playedTime =
        '${timeFormat.format((overviewSegment?.stats?.timePlayed?.value ?? 0) / 3600)}小时';

    final double realKillsRate =
        (overviewSegment?.stats?.humanKills?.value ?? 0).toDouble() /
            (overviewSegment?.stats?.kills?.value ?? 1).toDouble();
    realKills = overviewSegment?.stats?.humanKills?.value ?? 0;
    realKD = overviewSegment?.stats?.humanKdRatio?.value ?? 0;
    realKPM =
        (overviewSegment?.stats?.killsPerMinute?.value ?? 0) * realKillsRate;
    hsRate =
        '${overviewSegment?.stats?.headshotPercentage?.value?.toStringAsFixed(2) ?? 0}%';
    readKillRate = '${(realKillsRate * 100).toStringAsFixed(2)}%';
    damagePerMatch = overviewSegment?.stats?.damagePerMatch?.value ?? 0;
    winRate =
        '${overviewSegment?.stats?.wlPercentage?.value?.toStringAsFixed(2) ?? 0}%';
    damagePerMinute = overviewSegment?.stats?.dmgPerMin?.value ?? 0;
    killsPerMatch = overviewSegment?.stats?.killsPerMatch?.value ?? 0;
    playedMatches = overviewSegment?.stats?.matches?.value ?? 0;

    kills = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.kills?.value ?? 0);
    deaths = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.deaths?.value ?? 0);
    assists = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.assists?.value ?? 0);
    KD = UtilTools.parseDoubleAsFixedAndENUSFormat(
        overviewSegment?.stats?.kdRatio?.value ?? 0, 2);
    KPM = UtilTools.parseDoubleAsFixedAndENUSFormat(
        overviewSegment?.stats?.killsPerMinute?.value ?? 0, 2);
    damage = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.damageDealt?.value ?? 0);
    MVP = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.mvps?.value ?? 0);
    bestSquad = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.bestSquad?.value ?? 0);
    win = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.wins?.value ?? 0);
    lose = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.losses?.value ?? 0);
    killedVehicle = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.vehiclesDestroyed?.value ?? 0);
    recovery = UtilTools.parseIntAsENUSFormat(
        overviewSegment?.stats?.revives?.value ?? 0);

    if (weaponInfo.data != null) {
      weaponInfo.data?.forEach((weapon) {
        final weaponData = weapon.stats;

        weapons.add(WeaponInfoEnsemble(
            weapon.metadata?.name ?? '未知',
            '未知',
            UtilTools.parseIntAsENUSFormat(weaponData?.kills?.value ?? 0),
            UtilTools.parseDoubleAsFixedAndENUSFormat(
                weaponData?.killsPerMinute?.value ?? 0, 2),
            UtilTools.parseDoubleAsFixedAndENUSFormat(
                weaponData?.dmgPerMin?.value ?? 0, 2),
            '${(weaponData?.headshotPercentage?.value ?? 0).toStringAsFixed(2)}%',
            '${(weaponData?.shotsAccuracy?.value ?? 0).toStringAsFixed(2)}%',
            UtilTools.parseIntAsENUSFormat(weaponData?.damageDealt?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(weaponData?.multiKills?.value ?? 0),
            UtilTools.parseDoubleAsFixedAndENUSFormat(
                (weaponData?.shotsHit?.value ?? 0).toDouble() /
                    (weaponData?.kills?.value ?? 1),
                2),
            '${timeFormat.format((weaponData?.timePlayed?.value ?? 0) / 3600)}小时'));
      });
    }

    if (vehicleInfo.data != null) {
      vehicleInfo.data?.forEach((vehicle) {
        final vehicleData = vehicle.stats;

        vehicles.add(VehicleInfoEnsemble(
            vehicle.metadata?.name ?? '未知',
            '未知',
            UtilTools.parseIntAsENUSFormat(vehicleData?.kills?.value ?? 0),
            UtilTools.parseDoubleAsFixedAndENUSFormat(
                vehicleData?.killsPerMinute?.value ?? 0, 2),
            UtilTools.parseIntAsENUSFormat(
                vehicleData?.damageDealt?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(vehicleData?.multiKills?.value ?? 0),
            '${timeFormat.format((vehicleData?.timePlayed?.value ?? 0) / 3600)}小时',
            UtilTools.parseIntAsENUSFormat(
                vehicleData?.destroyedWith?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(vehicleData?.roadKills?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(
                vehicleData?.driverAssists?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(
                vehicleData?.passengerAssists?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(
                vehicleData?.distanceTraveled?.value ?? 0)));
      });
    }

    if (gadgetsInfo.data != null) {
      gadgetsInfo.data?.forEach((gadget) {
        final gadgetData = gadget.stats;

        gadgets.add(GadgetInfoEnsemble(
            gadget.metadata?.name ?? '未知',
            '未知',
            UtilTools.parseIntAsENUSFormat(gadgetData?.kills?.value ?? 0),
            UtilTools.parseDoubleAsFixedAndENUSFormat(
                gadgetData?.killsPerMinute?.value ?? 0, 2),
            UtilTools.parseIntAsENUSFormat(gadgetData?.damageDealt?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(
                gadgetData?.vehiclesDestroyed?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(gadgetData?.multiKills?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(gadgetData?.uses?.value ?? 0)));
      });
    }

    if (soldierInfo.data != null) {
      soldierInfo.data?.forEach((soldier) {
        final soldierData = soldier.stats;

        characters.add(CharacterInfoEnsemble(
            soldier.metadata?.name ?? '未知',
            '未知',
            UtilTools.parseIntAsENUSFormat(soldierData?.kills?.value ?? 0),
            UtilTools.parseDoubleAsFixedAndENUSFormat(
                soldierData?.killsPerMinute?.value ?? 0, 2),
            UtilTools.parseDoubleAsFixedAndENUSFormat(
                soldierData?.kdRatio?.value ?? 0, 2),
            UtilTools.parseIntAsENUSFormat(soldierData?.deaths?.value ?? 0),
            '未知',
            '${timeFormat.format((soldierData?.timePlayed?.value ?? 0) / 3600)}小时'));
      });
    }

    // gamemode is in the playerInfo.data.segments, where the type is 'gamemode'
    final gameModsSegment = <DataSegmentsItem>[];
    playerInfo.data?.segments?.forEach((element) {
      if (element.type == 'gamemode') {
        gameModsSegment.add(element);
      }
    });
    for (var gamemode in gameModsSegment) {
      gameModes.add(GameModeInfoEnsemble(
        gamemode.metadata?.name ?? '未知',
        '未知',
        UtilTools.parseIntAsENUSFormat(gamemode.stats?.kills?.value ?? 0),
        UtilTools.parseDoubleAsFixedAndENUSFormat(
            gamemode.stats?.killsPerMinute?.value ?? 0, 2),
        UtilTools.parseIntAsENUSFormat(gamemode.stats?.matches?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(gamemode.stats?.wins?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(gamemode.stats?.losses?.value ?? 0),
        '${(gamemode.stats?.wlPercentage?.value ?? 0).toStringAsFixed(2)}%',
        UtilTools.parseIntAsENUSFormat(
            gamemode.stats?.objectiveTime?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(
            gamemode.stats?.defendedSectors?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(
            gamemode.stats?.defendedObjectives?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(
            gamemode.stats?.objectivesCaptured?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(
            gamemode.stats?.objectivesArmed?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(
            gamemode.stats?.objectivesDisarmed?.value ?? 0),
        UtilTools.parseIntAsENUSFormat(
            gamemode.stats?.objectivesDestroyed?.value ?? 0),
        '${timeFormat.format((gamemode.stats?.timePlayed?.value ?? 0) / 3600)}小时',
      ));
    }

    if (mapInfo.data != null) {
      mapInfo.data?.forEach((map) {
        final mapData = map.stats;

        maps.add(MapInfoEnsemble(
            map.metadata?.name ?? '未知',
            '未知',
            UtilTools.parseIntAsENUSFormat(mapData?.wins?.value ?? 0),
            UtilTools.parseIntAsENUSFormat(mapData?.losses?.value ?? 0),
            '${(mapData?.wlPercentage?.value ?? 0).toStringAsFixed(2)}%',
            '${timeFormat.format((mapData?.timePlayed?.value ?? 0) / 3600)}小时',
            UtilTools.parseIntAsENUSFormat(mapData?.matches?.value ?? 0)));
      });
    }
  }

  String avatar;
  String nucleusId;
  String username;
  String personaId;
  String playedTime;

  double realKD;
  double realKPM;
  String hsRate;
  int realKills;
  String readKillRate;
  double damagePerMatch;
  String winRate;
  double damagePerMinute;
  String accuracy;
  double killsPerMatch;
  int playedMatches;

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
    _playerInfoEnsemble = null as PlayerInfoEnsemble;
    _platform = null;
    notifyListeners();
  }
}
