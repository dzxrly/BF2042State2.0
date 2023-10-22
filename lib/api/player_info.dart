import 'package:json_annotation/json_annotation.dart';

part 'player_info.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerInfo {
  PlayerInfo({
    this.accuracy,
    this.avatar,
    this.bestSquad,
    this.damage,
    this.damagePerMatch,
    this.damagePerMinute,
    this.deaths,
    this.enemiesSpotted,
    this.gadgetsDestoyed,
    this.headShots,
    this.headshots,
    this.heals,
    this.humanPrecentage,
    this.id,
    this.infantryKillDeath,
    this.killAssists,
    this.killDeath,
    this.kills,
    this.killsPerMatch,
    this.killsPerMinute,
    this.loses,
    this.matchesPlayed,
    this.mvp,
    this.repairs,
    this.resupplies,
    this.revives,
    this.secondsPlayed,
    this.shotsFired,
    this.shotsHit,
    this.timePlayed,
    this.userId,
    this.userName,
    this.vehiclesDestroyed,
    this.weapons,
    this.winPercent,
    this.wins,
    this.vehicles,
    this.gadgets,
    this.classes,
    this.gamemodes,
    this.maps,
  });

  final String? accuracy;
  final String? avatar;
  final int? bestSquad;
  final int? damage;
  final double? damagePerMatch;
  final double? damagePerMinute;
  final int? deaths;
  final int? enemiesSpotted;
  final int? gadgetsDestoyed;
  final int? headShots;
  final String? headshots;
  final int? heals;
  final String? humanPrecentage;
  final int? id;
  final double? infantryKillDeath;
  final int? killAssists;
  final double? killDeath;
  final int? kills;
  final double? killsPerMatch;
  final double? killsPerMinute;
  final int? loses;
  final int? matchesPlayed;
  final int? mvp;
  final int? repairs;
  final int? resupplies;
  final int? revives;
  final int? secondsPlayed;
  final int? shotsFired;
  final int? shotsHit;
  final String? timePlayed;
  final int? userId;
  final String? userName;
  final int? vehiclesDestroyed;
  final List<Weapon>? weapons;
  final String? winPercent;
  final int? wins;
  final List<Vehicle>? vehicles;
  final List<Gadget>? gadgets;
  final List<Classes>? classes;
  final List<Gamemode>? gamemodes;
  final List<MapElement>? maps;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerInfoToJson(this);
}

@JsonSerializable()
class Weapon {
  Weapon({
    this.accuracy,
    this.damage,
    this.damagePerMinute,
    this.headshotKills,
    this.hitVKills,
    this.id,
    this.kills,
    this.killsPerMinute,
    this.multiKills,
    this.shotsFired,
    this.shotsHit,
    this.timeEquipped,
    this.type,
    this.weaponName,
  });

  final String? accuracy;
  final int? damage;
  final double? damagePerMinute;
  final int? headshotKills;
  final double? hitVKills;
  final String? id;
  final int? kills;
  final double? killsPerMinute;
  final int? multiKills;
  final int? shotsFired;
  final int? shotsHit;
  final int? timeEquipped;
  final String? type;
  final String? weaponName;

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponToJson(this);
}

@JsonSerializable()
class Vehicle {
  Vehicle({
    this.assists,
    this.damage,
    this.damageTo,
    this.destroyed,
    this.distanceTraveled,
    this.driverAssists,
    this.id,
    this.kills,
    this.killsPerMinute,
    this.multiKills,
    this.passengerAssists,
    this.roadKills,
    this.timeIn,
    this.type,
    this.vehicleName,
    this.vehiclesDestroyedWith,
  });

  final int? assists;
  final int? damage;
  final int? damageTo;
  final int? destroyed;
  final int? distanceTraveled;
  final int? driverAssists;
  final String? id;
  final int? kills;
  final double? killsPerMinute;
  final int? multiKills;
  final int? passengerAssists;
  final int? roadKills;
  final int? timeIn;
  final String? type;
  final String? vehicleName;
  final int? vehiclesDestroyedWith;

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}

@JsonSerializable()
class Classes {
  Classes({
    this.className,
    this.characterName,
    this.id,
    this.kills,
    this.deaths,
    this.kpm,
    this.killDeath,
    this.secondsPlayed,
  });

  final String? className;
  final String? characterName;
  final String? id;
  final int? kills;
  final int? deaths;
  final double? kpm;
  final double? killDeath;
  final int? secondsPlayed;

  factory Classes.fromJson(Map<String, dynamic> json) =>
      _$ClassesFromJson(json);

  Map<String, dynamic> toJson() => _$ClassesToJson(this);
}

@JsonSerializable()
class Gadget {
  Gadget({
    this.damage,
    this.dpm,
    this.gadgetName,
    this.id,
    this.kills,
    this.kpm,
    this.multiKills,
    this.secondsPlayed,
    this.type,
    this.uses,
    this.vehiclesDestroyedWith,
  });

  final int? damage;
  final double? dpm;
  final String? gadgetName;
  final String? id;
  final int? kills;
  final double? kpm;
  final int? multiKills;
  final int? secondsPlayed;
  final String? type;
  final int? uses;
  final int? vehiclesDestroyedWith;

  factory Gadget.fromJson(Map<String, dynamic> json) => _$GadgetFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetToJson(this);
}

@JsonSerializable()
class Gamemode {
  Gamemode({
    this.assists,
    this.gamemodeName,
    this.id,
    this.kills,
    this.kpm,
    this.losses,
    this.matches,
    this.mvp,
    this.objectivesArmed,
    this.objectivesCaptured,
    this.objectivesDefended,
    this.objectivesDestroyed,
    this.objectivesDisarmed,
    this.objetiveTime,
    this.revives,
    this.secondsPlayed,
    this.sectorDefend,
    this.winPercent,
    this.wins,
  });

  final int? assists;
  final String? gamemodeName;
  final String? id;
  final int? kills;
  final double? kpm;
  final int? losses;
  final int? matches;
  final int? mvp;
  final int? objectivesArmed;
  final int? objectivesCaptured;
  final int? objectivesDefended;
  final int? objectivesDestroyed;
  final int? objectivesDisarmed;
  final int? objetiveTime;
  final int? revives;
  final int? secondsPlayed;
  final int? sectorDefend;
  final String? winPercent;
  final int? wins;

  factory Gamemode.fromJson(Map<String, dynamic> json) =>
      _$GamemodeFromJson(json);

  Map<String, dynamic> toJson() => _$GamemodeToJson(this);
}

@JsonSerializable()
class MapElement {
  MapElement({
    this.id,
    this.image,
    this.losses,
    this.mapName,
    this.matches,
    this.secondsPlayed,
    this.winPercent,
    this.wins,
  });

  final String? id;
  final String? image;
  final int? losses;
  final String? mapName;
  final int? matches;
  final int? secondsPlayed;
  final String? winPercent;
  final int? wins;

  factory MapElement.fromJson(Map<String, dynamic> json) =>
      _$MapElementFromJson(json);

  Map<String, dynamic> toJson() => _$MapElementToJson(this);
}
