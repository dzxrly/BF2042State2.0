import 'package:battlefield_2042_state/api/bftracker/bftracker_player_gadget_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_map_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_soldier_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_vehicle_info.dart';
import 'package:battlefield_2042_state/api/bftracker/bftracker_player_weapon_info.dart';
import 'package:battlefield_2042_state/api/gametools/gametools_player_info.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player_info_ensemble.g.dart';

@JsonSerializable(explicitToJson: true)
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
  final int kills;
  final double KPM;
  final double DPM;
  final double hsRate;
  final double accuracy;
  final int damage;
  final int multiKills;
  final double efficiency;
  final double playedTime;

  factory WeaponInfoEnsemble.fromJson(Map<String, dynamic> json) =>
      _$WeaponInfoEnsembleFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponInfoEnsembleToJson(this);
}

@JsonSerializable(explicitToJson: true)
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
  final int kills;
  final double KPM;
  final int killedVehicle;
  final int roadKills;
  final int damage;
  final int multiKills;
  final int driverAssists;
  final int passengerAssists;
  final int distanceTraveled;
  final double playedTime;

  factory VehicleInfoEnsemble.fromJson(Map<String, dynamic> json) =>
      _$VehicleInfoEnsembleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleInfoEnsembleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GadgetInfoEnsemble {
  GadgetInfoEnsemble(this.gadgetName, this.gadgetId, this.kills, this.KPM,
      this.damage, this.killedVehicle, this.multiKills, this.used);

  final String gadgetName;
  final String gadgetId;
  final int kills;
  final double KPM;
  final int damage;
  final int killedVehicle;
  final int multiKills;
  final int used;

  factory GadgetInfoEnsemble.fromJson(Map<String, dynamic> json) =>
      _$GadgetInfoEnsembleFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetInfoEnsembleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CharacterInfoEnsemble {
  CharacterInfoEnsemble(this.characterName, this.characterId, this.kills,
      this.KPM, this.KD, this.deaths, this.className, this.playedTime);

  final String characterName;
  final String characterId;
  final int kills;
  final double KPM;
  final double KD;
  final int deaths;
  final String className;
  final double playedTime;

  factory CharacterInfoEnsemble.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfoEnsembleFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterInfoEnsembleToJson(this);
}

@JsonSerializable(explicitToJson: true)
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
  final int kills;
  final double KPM;
  final int playedMatches;
  final double playedTime;
  final int win;
  final int lose;
  final String winRate;
  final int objectTime;
  final int sectorDefend;
  final int objectDefend;
  final int objectCapture;
  final int boomPlant;
  final int boomDefuse;
  final int boomDestroy;

  factory GameModeInfoEnsemble.fromJson(Map<String, dynamic> json) =>
      _$GameModeInfoEnsembleFromJson(json);

  Map<String, dynamic> toJson() => _$GameModeInfoEnsembleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MapInfoEnsemble {
  MapInfoEnsemble(this.mapName, this.mapId, this.win, this.lose, this.winRate,
      this.playedTime, this.playedMatches);

  final String mapName;
  final String mapId;
  final int playedMatches;
  final int win;
  final int lose;
  final String winRate;
  final double playedTime;

  factory MapInfoEnsemble.fromJson(Map<String, dynamic> json) =>
      _$MapInfoEnsembleFromJson(json);

  Map<String, dynamic> toJson() => _$MapInfoEnsembleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PlayerInfoEnsemble {
  PlayerInfoEnsemble(
      this.avatar,
      this.nucleusId,
      this.username,
      this.personaId,
      this.playedTime,
      this.realKD,
      this.realKPM,
      this.hsRate,
      this.realKills,
      this.readKillRate,
      this.damagePerMatch,
      this.winRate,
      this.damagePerMinute,
      this.accuracy,
      this.realKillsPerMatch,
      this.killsPerMatch,
      this.playedMatches,
      this.kills,
      this.deaths,
      this.assists,
      this.KD,
      this.KPM,
      this.damage,
      this.MVP,
      this.bestSquad,
      this.win,
      this.lose,
      this.killedVehicle,
      this.spotEnemy,
      this.recovery,
      this.supply,
      this.repair,
      this.weapons,
      this.vehicles,
      this.gadgets,
      this.characters,
      this.gameModes,
      this.maps);

  PlayerInfoEnsemble.gametoolsAPI(GametoolsPlayerInfo playerInfo)
      : avatar = '#',
        nucleusId = 'null',
        username = 'null',
        personaId = 'null',
        playedTime = 0.0,
        realKD = 0.0,
        realKPM = 0.0,
        hsRate = 'null',
        realKills = 0,
        readKillRate = 'null',
        damagePerMatch = 0.0,
        winRate = 'null',
        damagePerMinute = 0.0,
        accuracy = 'null',
        realKillsPerMatch = 0.0,
        killsPerMatch = 0.0,
        playedMatches = 0,
        kills = 0,
        deaths = 0,
        assists = 0,
        KD = 0.0,
        KPM = 0.0,
        damage = 0,
        MVP = 0,
        bestSquad = 0,
        win = 0,
        lose = 0,
        killedVehicle = 0,
        spotEnemy = 0,
        recovery = 0,
        supply = 0,
        repair = 0,
        weapons = [],
        vehicles = [],
        gadgets = [],
        characters = [],
        gameModes = [],
        maps = [] {
    final NumberFormat timeFormat = NumberFormat('#,###.00');

    avatar = playerInfo.avatar ?? '#';
    nucleusId =
        playerInfo.userId != null ? playerInfo.userId.toString() : 'null';
    username = playerInfo.userName ?? 'null';
    personaId = playerInfo.id != null ? playerInfo.id.toString() : 'null';
    playedTime = (playerInfo.secondsPlayed ?? 0) / 3600;

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
    realKillsPerMatch = realKills / (playerInfo.matchesPlayed ?? 1);
    killsPerMatch = playerInfo.killsPerMatch ?? 0;
    playedMatches = playerInfo.matchesPlayed ?? 0;

    kills = playerInfo.kills ?? 0;
    deaths = playerInfo.deaths ?? 0;
    assists = playerInfo.killAssists ?? 0;
    KD = playerInfo.killDeath ?? 0;
    KPM = playerInfo.killsPerMinute ?? 0;
    damage = playerInfo.damage ?? 0;
    MVP = playerInfo.mvp ?? 0;
    bestSquad = playerInfo.bestSquad ?? 0;
    win = playerInfo.wins ?? 0;
    lose = playerInfo.loses ?? 0;
    killedVehicle = playerInfo.vehiclesDestroyed ?? 0;
    spotEnemy = playerInfo.enemiesSpotted ?? 0;
    recovery = playerInfo.heals ?? 0;
    supply = playerInfo.resupplies ?? 0;
    repair = playerInfo.repairs ?? 0;

    if (playerInfo.weapons != null) {
      playerInfo.weapons?.forEach((weapon) => weapons.add(WeaponInfoEnsemble(
          weapon.weaponName ?? 'null',
          weapon.id ?? 'null',
          weapon.kills ?? 0,
          weapon.killsPerMinute ?? 0,
          weapon.damagePerMinute ?? 0,
          (weapon.headshotKills ?? 0) / (weapon.kills ?? 1),
          (weapon.shotsHit ?? 0) / (weapon.shotsFired ?? 1),
          weapon.damage ?? 0,
          weapon.multiKills ?? 0,
          weapon.hitVKills ?? 0.0,
          (weapon.timeEquipped ?? 0) / 3600)));
    }

    if (playerInfo.vehicles != null) {
      playerInfo.vehicles?.forEach((vehicle) => vehicles.add(
          VehicleInfoEnsemble(
              vehicle.vehicleName ?? 'null',
              vehicle.id ?? 'null',
              vehicle.kills ?? 0,
              vehicle.killsPerMinute ?? 0,
              vehicle.damage ?? 0,
              vehicle.multiKills ?? 0,
              (vehicle.timeIn ?? 0) / 3600,
              vehicle.vehiclesDestroyedWith ?? 0,
              vehicle.roadKills ?? 0,
              vehicle.driverAssists ?? 0,
              vehicle.passengerAssists ?? 0,
              vehicle.distanceTraveled ?? 0)));
    }

    if (playerInfo.gadgets != null) {
      playerInfo.gadgets?.forEach((gadget) => gadgets.add(GadgetInfoEnsemble(
          gadget.gadgetName ?? 'null',
          gadget.id ?? 'null',
          gadget.kills ?? 0,
          gadget.kpm ?? 0,
          gadget.damage ?? 0,
          gadget.vehiclesDestroyedWith ?? 0,
          gadget.multiKills ?? 0,
          gadget.uses ?? 0)));
    }

    if (playerInfo.classes != null) {
      playerInfo.classes?.forEach((character) => characters.add(
          CharacterInfoEnsemble(
              (character.characterName ?? 'null')
                  .replaceAll('1942', 'BF1942')
                  .replaceAll(RegExp('[-\\s]'), ''),
              character.id ?? 'null',
              character.kills ?? 0,
              character.kpm ?? 0,
              character.killDeath ?? 0,
              character.deaths ?? 0,
              character.className ?? 'null',
              (character.secondsPlayed ?? 0) / 3600)));
    }

    if (playerInfo.gamemodes != null) {
      playerInfo.gamemodes?.forEach((gameMode) => gameModes.add(
          GameModeInfoEnsemble(
              (gameMode.gamemodeName ?? 'null').replaceAll(' ', ''),
              gameMode.id ?? 'null',
              gameMode.kills ?? 0,
              gameMode.kpm ?? 0,
              gameMode.matches ?? 0,
              gameMode.wins ?? 0,
              gameMode.losses ?? 0,
              gameMode.winPercent ?? '0.0%',
              gameMode.objetiveTime ?? 0,
              gameMode.sectorDefend ?? 0,
              gameMode.objectivesDefended ?? 0,
              gameMode.objectivesCaptured ?? 0,
              gameMode.objectivesArmed ?? 0,
              gameMode.objectivesDisarmed ?? 0,
              gameMode.objectivesDestroyed ?? 0,
              (gameMode.secondsPlayed ?? 0) / 3600)));
    }

    if (playerInfo.maps != null) {
      playerInfo.maps?.forEach((map) => maps.add(MapInfoEnsemble(
          (map.mapName ?? 'null').replaceAll(' ', ''),
          map.id ?? 'null',
          map.wins ?? 0,
          map.losses ?? 0,
          map.winPercent ?? '0.0%',
          (map.secondsPlayed ?? 0) / 3600,
          map.matches ?? 0)));
    }
  }

  PlayerInfoEnsemble.bftracker(
    BFTrackerPlayerInfo playerInfo,
    BFTrackerWeapon weaponInfo,
    BFTrackerVehicle vehicleInfo,
    BFTrackerGadgets gadgetsInfo,
    BFTrackerSoldier soldierInfo,
    BFTrackerMap mapInfo,
  )   : avatar = '#',
        nucleusId = 'null',
        username = 'null',
        personaId = 'null',
        playedTime = 0.0,
        realKD = 0.0,
        realKPM = 0.0,
        hsRate = 'null',
        realKills = 0,
        readKillRate = 'null',
        damagePerMatch = 0.0,
        winRate = 'null',
        damagePerMinute = 0.0,
        accuracy = 'null',
        realKillsPerMatch = 0.0,
        killsPerMatch = 0.0,
        playedMatches = 0,
        kills = 0,
        deaths = 0,
        assists = 0,
        KD = 0.0,
        KPM = 0.0,
        damage = 0,
        MVP = 0,
        bestSquad = 0,
        win = 0,
        lose = 0,
        killedVehicle = 0,
        spotEnemy = 0,
        recovery = 0,
        supply = 0,
        repair = 0,
        weapons = [],
        vehicles = [],
        gadgets = [],
        characters = [],
        gameModes = [],
        maps = [] {
    final NumberFormat timeFormat = NumberFormat('#,###.00');

    avatar = playerInfo.data?.platformInfo?.avatarUrl ?? '#';
    nucleusId = playerInfo.data?.platformInfo?.platformUserId ?? 'null';
    username = playerInfo.data?.platformInfo?.platformUserIdentifier ?? 'null';
    final overviewSegment = playerInfo.data?.segments
        ?.firstWhere((element) => element.type == 'overview');
    playedTime = (overviewSegment?.stats?.timePlayed?.value ?? 0) / 3600;

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
    realKillsPerMatch =
        realKills / (overviewSegment?.stats?.matches?.value ?? 1);
    killsPerMatch = overviewSegment?.stats?.killsPerMatch?.value ?? 0;
    playedMatches = overviewSegment?.stats?.matches?.value ?? 0;

    kills = overviewSegment?.stats?.kills?.value ?? 0;
    deaths = overviewSegment?.stats?.deaths?.value ?? 0;
    assists = overviewSegment?.stats?.assists?.value ?? 0;
    KD = overviewSegment?.stats?.kdRatio?.value ?? 0;
    KPM = overviewSegment?.stats?.killsPerMinute?.value ?? 0;
    damage = overviewSegment?.stats?.damageDealt?.value ?? 0;
    MVP = overviewSegment?.stats?.mvps?.value ?? 0;
    bestSquad = overviewSegment?.stats?.bestSquad?.value ?? 0;
    win = overviewSegment?.stats?.wins?.value ?? 0;
    lose = overviewSegment?.stats?.losses?.value ?? 0;
    killedVehicle = overviewSegment?.stats?.vehiclesDestroyed?.value ?? 0;
    recovery = overviewSegment?.stats?.revives?.value ?? 0;

    if (weaponInfo.data != null) {
      weaponInfo.data?.forEach((weapon) {
        final weaponData = weapon.stats;

        weapons.add(WeaponInfoEnsemble(
            weapon.metadata?.name ?? 'null',
            'null',
            weaponData?.kills?.value ?? 0,
            weaponData?.killsPerMinute?.value ?? 0,
            weaponData?.dmgPerMin?.value ?? 0,
            weaponData?.headshotPercentage?.value ?? 0,
            weaponData?.shotsAccuracy?.value ?? 0,
            weaponData?.damageDealt?.value ?? 0,
            weaponData?.multiKills?.value ?? 0,
            (weaponData?.shotsHit?.value ?? 0).toDouble() /
                (weaponData?.kills?.value ?? 1),
            (weaponData?.timePlayed?.value ?? 0) / 3600));
      });
    }

    if (vehicleInfo.data != null) {
      vehicleInfo.data?.forEach((vehicle) {
        final vehicleData = vehicle.stats;

        vehicles.add(VehicleInfoEnsemble(
            vehicle.metadata?.name ?? 'null',
            'null',
            vehicleData?.kills?.value ?? 0,
            vehicleData?.killsPerMinute?.value ?? 0,
            vehicleData?.damageDealt?.value ?? 0,
            vehicleData?.multiKills?.value ?? 0,
            (vehicleData?.timePlayed?.value ?? 0) / 3600,
            vehicleData?.destroyedWith?.value ?? 0,
            vehicleData?.roadKills?.value ?? 0,
            vehicleData?.driverAssists?.value ?? 0,
            vehicleData?.passengerAssists?.value ?? 0,
            vehicleData?.distanceTraveled?.value ?? 0));
      });
    }

    if (gadgetsInfo.data != null) {
      gadgetsInfo.data?.forEach((gadget) {
        final gadgetData = gadget.stats;

        gadgets.add(GadgetInfoEnsemble(
            gadget.metadata?.name ?? 'null',
            'null',
            gadgetData?.kills?.value ?? 0,
            gadgetData?.killsPerMinute?.value ?? 0,
            gadgetData?.damageDealt?.value ?? 0,
            gadgetData?.vehiclesDestroyed?.value ?? 0,
            gadgetData?.multiKills?.value ?? 0,
            gadgetData?.uses?.value ?? 0));
      });
    }

    if (soldierInfo.data != null) {
      soldierInfo.data?.forEach((soldier) {
        final soldierData = soldier.stats;

        characters.add(CharacterInfoEnsemble(
            (soldier.metadata?.name ?? 'null')
                .replaceAll('1942', 'BF1942')
                .replaceAll(RegExp('[-\\s]'), ''),
            'null',
            soldierData?.kills?.value ?? 0,
            soldierData?.killsPerMinute?.value ?? 0,
            soldierData?.kdRatio?.value ?? 0,
            soldierData?.deaths?.value ?? 0,
            'null',
            (soldierData?.timePlayed?.value ?? 0) / 3600));
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
        (gamemode.metadata?.name ?? 'null').replaceAll(' ', ''),
        'null',
        gamemode.stats?.kills?.value ?? 0,
        gamemode.stats?.killsPerMinute?.value ?? 0,
        gamemode.stats?.matches?.value ?? 0,
        gamemode.stats?.wins?.value ?? 0,
        gamemode.stats?.losses?.value ?? 0,
        '${(gamemode.stats?.wlPercentage?.value ?? 0).toStringAsFixed(2)}%',
        gamemode.stats?.objectiveTime?.value ?? 0,
        gamemode.stats?.defendedSectors?.value ?? 0,
        gamemode.stats?.defendedObjectives?.value ?? 0,
        gamemode.stats?.objectivesCaptured?.value ?? 0,
        gamemode.stats?.objectivesArmed?.value ?? 0,
        gamemode.stats?.objectivesDisarmed?.value ?? 0,
        gamemode.stats?.objectivesDestroyed?.value ?? 0,
        (gamemode.stats?.timePlayed?.value ?? 0) / 3600,
      ));
    }

    if (mapInfo.data != null) {
      mapInfo.data?.forEach((map) {
        final mapData = map.stats;

        maps.add(MapInfoEnsemble(
            (map.metadata?.name ?? 'null').replaceAll(' ', ''),
            'null',
            mapData?.wins?.value ?? 0,
            mapData?.losses?.value ?? 0,
            '${(mapData?.wlPercentage?.value ?? 0).toStringAsFixed(2)}%',
            (mapData?.timePlayed?.value ?? 0) / 3600,
            mapData?.matches?.value ?? 0));
      });
    }
  }

  String avatar;
  String nucleusId;
  String username;
  String personaId;
  double playedTime;

  double realKD;
  double realKPM;
  String hsRate;
  int realKills;
  String readKillRate;
  double damagePerMatch;
  String winRate;
  double damagePerMinute;
  String accuracy;
  double realKillsPerMatch;
  int playedMatches;

  int kills;
  int deaths;
  int assists;
  double killsPerMatch;
  double KD;
  double KPM;
  int damage;
  int MVP;
  int bestSquad;
  int win;
  int lose;
  int killedVehicle;
  int spotEnemy;
  int recovery;
  int supply;
  int repair;

  List<WeaponInfoEnsemble> weapons;
  List<VehicleInfoEnsemble> vehicles;
  List<GadgetInfoEnsemble> gadgets;
  List<CharacterInfoEnsemble> characters;
  List<GameModeInfoEnsemble> gameModes;
  List<MapInfoEnsemble> maps;

  factory PlayerInfoEnsemble.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoEnsembleFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerInfoEnsembleToJson(this);
}

@JsonSerializable()
class PlayerInfoSnapshot {
  PlayerInfoSnapshot(
    this.playerInfoEnsemble,
    this.playerPlatform,
    this.createTime,
  );

  final PlayerInfoEnsemble playerInfoEnsemble;
  final String playerPlatform;
  final String createTime;

  factory PlayerInfoSnapshot.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoSnapshotFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerInfoSnapshotToJson(this);
}
