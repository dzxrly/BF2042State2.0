// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_info_ensemble.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeaponInfoEnsemble _$WeaponInfoEnsembleFromJson(Map<String, dynamic> json) =>
    WeaponInfoEnsemble(
      json['weaponName'] as String,
      json['weaponId'] as String,
      json['kills'] as int,
      (json['KPM'] as num).toDouble(),
      (json['DPM'] as num).toDouble(),
      (json['hsRate'] as num).toDouble(),
      (json['accuracy'] as num).toDouble(),
      json['damage'] as int,
      json['multiKills'] as int,
      (json['efficiency'] as num).toDouble(),
      (json['playedTime'] as num).toDouble(),
    );

Map<String, dynamic> _$WeaponInfoEnsembleToJson(WeaponInfoEnsemble instance) =>
    <String, dynamic>{
      'weaponName': instance.weaponName,
      'weaponId': instance.weaponId,
      'kills': instance.kills,
      'KPM': instance.KPM,
      'DPM': instance.DPM,
      'hsRate': instance.hsRate,
      'accuracy': instance.accuracy,
      'damage': instance.damage,
      'multiKills': instance.multiKills,
      'efficiency': instance.efficiency,
      'playedTime': instance.playedTime,
    };

VehicleInfoEnsemble _$VehicleInfoEnsembleFromJson(Map<String, dynamic> json) =>
    VehicleInfoEnsemble(
      json['vehicleName'] as String,
      json['vehicleId'] as String,
      json['kills'] as int,
      (json['KPM'] as num).toDouble(),
      json['damage'] as int,
      json['multiKills'] as int,
      (json['playedTime'] as num).toDouble(),
      json['killedVehicle'] as int,
      json['roadKills'] as int,
      json['driverAssists'] as int,
      json['passengerAssists'] as int,
      json['distanceTraveled'] as int,
    );

Map<String, dynamic> _$VehicleInfoEnsembleToJson(
        VehicleInfoEnsemble instance) =>
    <String, dynamic>{
      'vehicleName': instance.vehicleName,
      'vehicleId': instance.vehicleId,
      'kills': instance.kills,
      'KPM': instance.KPM,
      'killedVehicle': instance.killedVehicle,
      'roadKills': instance.roadKills,
      'damage': instance.damage,
      'multiKills': instance.multiKills,
      'driverAssists': instance.driverAssists,
      'passengerAssists': instance.passengerAssists,
      'distanceTraveled': instance.distanceTraveled,
      'playedTime': instance.playedTime,
    };

GadgetInfoEnsemble _$GadgetInfoEnsembleFromJson(Map<String, dynamic> json) =>
    GadgetInfoEnsemble(
      json['gadgetName'] as String,
      json['gadgetId'] as String,
      json['kills'] as int,
      (json['KPM'] as num).toDouble(),
      json['damage'] as int,
      json['killedVehicle'] as int,
      json['multiKills'] as int,
      json['used'] as int,
    );

Map<String, dynamic> _$GadgetInfoEnsembleToJson(GadgetInfoEnsemble instance) =>
    <String, dynamic>{
      'gadgetName': instance.gadgetName,
      'gadgetId': instance.gadgetId,
      'kills': instance.kills,
      'KPM': instance.KPM,
      'damage': instance.damage,
      'killedVehicle': instance.killedVehicle,
      'multiKills': instance.multiKills,
      'used': instance.used,
    };

CharacterInfoEnsemble _$CharacterInfoEnsembleFromJson(
        Map<String, dynamic> json) =>
    CharacterInfoEnsemble(
      json['characterName'] as String,
      json['characterId'] as String,
      json['kills'] as int,
      (json['KPM'] as num).toDouble(),
      (json['KD'] as num).toDouble(),
      json['deaths'] as int,
      json['className'] as String,
      (json['playedTime'] as num).toDouble(),
    );

Map<String, dynamic> _$CharacterInfoEnsembleToJson(
        CharacterInfoEnsemble instance) =>
    <String, dynamic>{
      'characterName': instance.characterName,
      'characterId': instance.characterId,
      'kills': instance.kills,
      'KPM': instance.KPM,
      'KD': instance.KD,
      'deaths': instance.deaths,
      'className': instance.className,
      'playedTime': instance.playedTime,
    };

GameModeInfoEnsemble _$GameModeInfoEnsembleFromJson(
        Map<String, dynamic> json) =>
    GameModeInfoEnsemble(
      json['modeName'] as String,
      json['modeId'] as String,
      json['kills'] as int,
      (json['KPM'] as num).toDouble(),
      json['playedMatches'] as int,
      json['win'] as int,
      json['lose'] as int,
      json['winRate'] as String,
      json['objectTime'] as int,
      json['sectorDefend'] as int,
      json['objectDefend'] as int,
      json['objectCapture'] as int,
      json['boomPlant'] as int,
      json['boomDefuse'] as int,
      json['boomDestroy'] as int,
      (json['playedTime'] as num).toDouble(),
    );

Map<String, dynamic> _$GameModeInfoEnsembleToJson(
        GameModeInfoEnsemble instance) =>
    <String, dynamic>{
      'modeName': instance.modeName,
      'modeId': instance.modeId,
      'kills': instance.kills,
      'KPM': instance.KPM,
      'playedMatches': instance.playedMatches,
      'playedTime': instance.playedTime,
      'win': instance.win,
      'lose': instance.lose,
      'winRate': instance.winRate,
      'objectTime': instance.objectTime,
      'sectorDefend': instance.sectorDefend,
      'objectDefend': instance.objectDefend,
      'objectCapture': instance.objectCapture,
      'boomPlant': instance.boomPlant,
      'boomDefuse': instance.boomDefuse,
      'boomDestroy': instance.boomDestroy,
    };

MapInfoEnsemble _$MapInfoEnsembleFromJson(Map<String, dynamic> json) =>
    MapInfoEnsemble(
      json['mapName'] as String,
      json['mapId'] as String,
      json['win'] as int,
      json['lose'] as int,
      json['winRate'] as String,
      (json['playedTime'] as num).toDouble(),
      json['playedMatches'] as int,
    );

Map<String, dynamic> _$MapInfoEnsembleToJson(MapInfoEnsemble instance) =>
    <String, dynamic>{
      'mapName': instance.mapName,
      'mapId': instance.mapId,
      'playedMatches': instance.playedMatches,
      'win': instance.win,
      'lose': instance.lose,
      'winRate': instance.winRate,
      'playedTime': instance.playedTime,
    };

PlayerInfoEnsemble _$PlayerInfoEnsembleFromJson(Map<String, dynamic> json) =>
    PlayerInfoEnsemble(
      json['avatar'] as String,
      json['nucleusId'] as String,
      json['username'] as String,
      json['personaId'] as String,
      (json['playedTime'] as num).toDouble(),
      (json['realKD'] as num).toDouble(),
      (json['realKPM'] as num).toDouble(),
      json['hsRate'] as String,
      json['realKills'] as int,
      json['readKillRate'] as String,
      (json['damagePerMatch'] as num).toDouble(),
      json['winRate'] as String,
      (json['damagePerMinute'] as num).toDouble(),
      json['accuracy'] as String,
      (json['realKillsPerMatch'] as num).toDouble(),
      (json['killsPerMatch'] as num).toDouble(),
      json['playedMatches'] as int,
      json['kills'] as int,
      json['deaths'] as int,
      json['assists'] as int,
      (json['KD'] as num).toDouble(),
      (json['KPM'] as num).toDouble(),
      json['damage'] as int,
      json['MVP'] as int,
      json['bestSquad'] as int,
      json['win'] as int,
      json['lose'] as int,
      json['killedVehicle'] as int,
      json['spotEnemy'] as int,
      json['recovery'] as int,
      json['supply'] as int,
      json['repair'] as int,
      (json['weapons'] as List<dynamic>)
          .map((e) => WeaponInfoEnsemble.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['vehicles'] as List<dynamic>)
          .map((e) => VehicleInfoEnsemble.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['gadgets'] as List<dynamic>)
          .map((e) => GadgetInfoEnsemble.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['characters'] as List<dynamic>)
          .map((e) => CharacterInfoEnsemble.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['gameModes'] as List<dynamic>)
          .map((e) => GameModeInfoEnsemble.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['maps'] as List<dynamic>)
          .map((e) => MapInfoEnsemble.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerInfoEnsembleToJson(PlayerInfoEnsemble instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'nucleusId': instance.nucleusId,
      'username': instance.username,
      'personaId': instance.personaId,
      'playedTime': instance.playedTime,
      'realKD': instance.realKD,
      'realKPM': instance.realKPM,
      'hsRate': instance.hsRate,
      'realKills': instance.realKills,
      'readKillRate': instance.readKillRate,
      'damagePerMatch': instance.damagePerMatch,
      'winRate': instance.winRate,
      'damagePerMinute': instance.damagePerMinute,
      'accuracy': instance.accuracy,
      'realKillsPerMatch': instance.realKillsPerMatch,
      'playedMatches': instance.playedMatches,
      'kills': instance.kills,
      'deaths': instance.deaths,
      'assists': instance.assists,
      'killsPerMatch': instance.killsPerMatch,
      'KD': instance.KD,
      'KPM': instance.KPM,
      'damage': instance.damage,
      'MVP': instance.MVP,
      'bestSquad': instance.bestSquad,
      'win': instance.win,
      'lose': instance.lose,
      'killedVehicle': instance.killedVehicle,
      'spotEnemy': instance.spotEnemy,
      'recovery': instance.recovery,
      'supply': instance.supply,
      'repair': instance.repair,
      'weapons': instance.weapons,
      'vehicles': instance.vehicles,
      'gadgets': instance.gadgets,
      'characters': instance.characters,
      'gameModes': instance.gameModes,
      'maps': instance.maps,
    };
