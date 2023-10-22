// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerInfo _$PlayerInfoFromJson(Map<String, dynamic> json) => PlayerInfo(
      accuracy: json['accuracy'] as String?,
      avatar: json['avatar'] as String?,
      bestSquad: json['bestSquad'] as int?,
      damage: json['damage'] as int?,
      damagePerMatch: (json['damagePerMatch'] as num?)?.toDouble(),
      damagePerMinute: (json['damagePerMinute'] as num?)?.toDouble(),
      deaths: json['deaths'] as int?,
      enemiesSpotted: json['enemiesSpotted'] as int?,
      gadgetsDestoyed: json['gadgetsDestoyed'] as int?,
      headShots: json['headShots'] as int?,
      headshots: json['headshots'] as String?,
      heals: json['heals'] as int?,
      humanPrecentage: json['humanPrecentage'] as String?,
      id: json['id'] as int?,
      infantryKillDeath: (json['infantryKillDeath'] as num?)?.toDouble(),
      killAssists: json['killAssists'] as int?,
      killDeath: (json['killDeath'] as num?)?.toDouble(),
      kills: json['kills'] as int?,
      killsPerMatch: (json['killsPerMatch'] as num?)?.toDouble(),
      killsPerMinute: (json['killsPerMinute'] as num?)?.toDouble(),
      loses: json['loses'] as int?,
      matchesPlayed: json['matchesPlayed'] as int?,
      mvp: json['mvp'] as int?,
      repairs: json['repairs'] as int?,
      resupplies: json['resupplies'] as int?,
      revives: json['revives'] as int?,
      secondsPlayed: json['secondsPlayed'] as int?,
      shotsFired: json['shotsFired'] as int?,
      shotsHit: json['shotsHit'] as int?,
      timePlayed: json['timePlayed'] as String?,
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      vehiclesDestroyed: json['vehiclesDestroyed'] as int?,
      weapons: (json['weapons'] as List<dynamic>?)
          ?.map((e) => Weapon.fromJson(e as Map<String, dynamic>))
          .toList(),
      winPercent: json['winPercent'] as String?,
      wins: json['wins'] as int?,
      vehicles: (json['vehicles'] as List<dynamic>?)
          ?.map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
          .toList(),
      gadgets: (json['gadgets'] as List<dynamic>?)
          ?.map((e) => Gadget.fromJson(e as Map<String, dynamic>))
          .toList(),
      classes: (json['classes'] as List<dynamic>?)
          ?.map((e) => Classes.fromJson(e as Map<String, dynamic>))
          .toList(),
      gamemodes: (json['gamemodes'] as List<dynamic>?)
          ?.map((e) => Gamemode.fromJson(e as Map<String, dynamic>))
          .toList(),
      maps: (json['maps'] as List<dynamic>?)
          ?.map((e) => MapElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerInfoToJson(PlayerInfo instance) =>
    <String, dynamic>{
      'accuracy': instance.accuracy,
      'avatar': instance.avatar,
      'bestSquad': instance.bestSquad,
      'damage': instance.damage,
      'damagePerMatch': instance.damagePerMatch,
      'damagePerMinute': instance.damagePerMinute,
      'deaths': instance.deaths,
      'enemiesSpotted': instance.enemiesSpotted,
      'gadgetsDestoyed': instance.gadgetsDestoyed,
      'headShots': instance.headShots,
      'headshots': instance.headshots,
      'heals': instance.heals,
      'humanPrecentage': instance.humanPrecentage,
      'id': instance.id,
      'infantryKillDeath': instance.infantryKillDeath,
      'killAssists': instance.killAssists,
      'killDeath': instance.killDeath,
      'kills': instance.kills,
      'killsPerMatch': instance.killsPerMatch,
      'killsPerMinute': instance.killsPerMinute,
      'loses': instance.loses,
      'matchesPlayed': instance.matchesPlayed,
      'mvp': instance.mvp,
      'repairs': instance.repairs,
      'resupplies': instance.resupplies,
      'revives': instance.revives,
      'secondsPlayed': instance.secondsPlayed,
      'shotsFired': instance.shotsFired,
      'shotsHit': instance.shotsHit,
      'timePlayed': instance.timePlayed,
      'userId': instance.userId,
      'userName': instance.userName,
      'vehiclesDestroyed': instance.vehiclesDestroyed,
      'weapons': instance.weapons?.map((e) => e.toJson()).toList(),
      'winPercent': instance.winPercent,
      'wins': instance.wins,
      'vehicles': instance.vehicles?.map((e) => e.toJson()).toList(),
      'gadgets': instance.gadgets?.map((e) => e.toJson()).toList(),
      'classes': instance.classes?.map((e) => e.toJson()).toList(),
      'gamemodes': instance.gamemodes?.map((e) => e.toJson()).toList(),
      'maps': instance.maps?.map((e) => e.toJson()).toList(),
    };

Weapon _$WeaponFromJson(Map<String, dynamic> json) => Weapon(
      accuracy: json['accuracy'] as String?,
      damage: json['damage'] as int?,
      damagePerMinute: (json['damagePerMinute'] as num?)?.toDouble(),
      headshotKills: json['headshotKills'] as int?,
      hitVKills: (json['hitVKills'] as num?)?.toDouble(),
      id: json['id'] as String?,
      kills: json['kills'] as int?,
      killsPerMinute: (json['killsPerMinute'] as num?)?.toDouble(),
      multiKills: json['multiKills'] as int?,
      shotsFired: json['shotsFired'] as int?,
      shotsHit: json['shotsHit'] as int?,
      timeEquipped: json['timeEquipped'] as int?,
      type: json['type'] as String?,
      weaponName: json['weaponName'] as String?,
    );

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'accuracy': instance.accuracy,
      'damage': instance.damage,
      'damagePerMinute': instance.damagePerMinute,
      'headshotKills': instance.headshotKills,
      'hitVKills': instance.hitVKills,
      'id': instance.id,
      'kills': instance.kills,
      'killsPerMinute': instance.killsPerMinute,
      'multiKills': instance.multiKills,
      'shotsFired': instance.shotsFired,
      'shotsHit': instance.shotsHit,
      'timeEquipped': instance.timeEquipped,
      'type': instance.type,
      'weaponName': instance.weaponName,
    };

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      assists: json['assists'] as int?,
      damage: json['damage'] as int?,
      damageTo: json['damageTo'] as int?,
      destroyed: json['destroyed'] as int?,
      distanceTraveled: json['distanceTraveled'] as int?,
      driverAssists: json['driverAssists'] as int?,
      id: json['id'] as String?,
      kills: json['kills'] as int?,
      killsPerMinute: (json['killsPerMinute'] as num?)?.toDouble(),
      multiKills: json['multiKills'] as int?,
      passengerAssists: json['passengerAssists'] as int?,
      roadKills: json['roadKills'] as int?,
      timeIn: json['timeIn'] as int?,
      type: json['type'] as String?,
      vehicleName: json['vehicleName'] as String?,
      vehiclesDestroyedWith: json['vehiclesDestroyedWith'] as int?,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'assists': instance.assists,
      'damage': instance.damage,
      'damageTo': instance.damageTo,
      'destroyed': instance.destroyed,
      'distanceTraveled': instance.distanceTraveled,
      'driverAssists': instance.driverAssists,
      'id': instance.id,
      'kills': instance.kills,
      'killsPerMinute': instance.killsPerMinute,
      'multiKills': instance.multiKills,
      'passengerAssists': instance.passengerAssists,
      'roadKills': instance.roadKills,
      'timeIn': instance.timeIn,
      'type': instance.type,
      'vehicleName': instance.vehicleName,
      'vehiclesDestroyedWith': instance.vehiclesDestroyedWith,
    };

Classes _$ClassesFromJson(Map<String, dynamic> json) => Classes(
      className: json['className'] as String?,
      characterName: json['characterName'] as String?,
      id: json['id'] as String?,
      kills: json['kills'] as int?,
      deaths: json['deaths'] as int?,
      kpm: (json['kpm'] as num?)?.toDouble(),
      killDeath: (json['killDeath'] as num?)?.toDouble(),
      secondsPlayed: json['secondsPlayed'] as int?,
    );

Map<String, dynamic> _$ClassesToJson(Classes instance) => <String, dynamic>{
      'className': instance.className,
      'characterName': instance.characterName,
      'id': instance.id,
      'kills': instance.kills,
      'deaths': instance.deaths,
      'kpm': instance.kpm,
      'killDeath': instance.killDeath,
      'secondsPlayed': instance.secondsPlayed,
    };

Gadget _$GadgetFromJson(Map<String, dynamic> json) => Gadget(
      damage: json['damage'] as int?,
      dpm: (json['dpm'] as num?)?.toDouble(),
      gadgetName: json['gadgetName'] as String?,
      id: json['id'] as String?,
      kills: json['kills'] as int?,
      kpm: (json['kpm'] as num?)?.toDouble(),
      multiKills: json['multiKills'] as int?,
      secondsPlayed: json['secondsPlayed'] as int?,
      type: json['type'] as String?,
      uses: json['uses'] as int?,
      vehiclesDestroyedWith: json['vehiclesDestroyedWith'] as int?,
    );

Map<String, dynamic> _$GadgetToJson(Gadget instance) => <String, dynamic>{
      'damage': instance.damage,
      'dpm': instance.dpm,
      'gadgetName': instance.gadgetName,
      'id': instance.id,
      'kills': instance.kills,
      'kpm': instance.kpm,
      'multiKills': instance.multiKills,
      'secondsPlayed': instance.secondsPlayed,
      'type': instance.type,
      'uses': instance.uses,
      'vehiclesDestroyedWith': instance.vehiclesDestroyedWith,
    };

Gamemode _$GamemodeFromJson(Map<String, dynamic> json) => Gamemode(
      assists: json['assists'] as int?,
      gamemodeName: json['gamemodeName'] as String?,
      id: json['id'] as String?,
      kills: json['kills'] as int?,
      kpm: (json['kpm'] as num?)?.toDouble(),
      losses: json['losses'] as int?,
      matches: json['matches'] as int?,
      mvp: json['mvp'] as int?,
      objectivesArmed: json['objectivesArmed'] as int?,
      objectivesCaptured: json['objectivesCaptured'] as int?,
      objectivesDefended: json['objectivesDefended'] as int?,
      objectivesDestroyed: json['objectivesDestroyed'] as int?,
      objectivesDisarmed: json['objectivesDisarmed'] as int?,
      objetiveTime: json['objetiveTime'] as int?,
      revives: json['revives'] as int?,
      secondsPlayed: json['secondsPlayed'] as int?,
      sectorDefend: json['sectorDefend'] as int?,
      winPercent: json['winPercent'] as String?,
      wins: json['wins'] as int?,
    );

Map<String, dynamic> _$GamemodeToJson(Gamemode instance) => <String, dynamic>{
      'assists': instance.assists,
      'gamemodeName': instance.gamemodeName,
      'id': instance.id,
      'kills': instance.kills,
      'kpm': instance.kpm,
      'losses': instance.losses,
      'matches': instance.matches,
      'mvp': instance.mvp,
      'objectivesArmed': instance.objectivesArmed,
      'objectivesCaptured': instance.objectivesCaptured,
      'objectivesDefended': instance.objectivesDefended,
      'objectivesDestroyed': instance.objectivesDestroyed,
      'objectivesDisarmed': instance.objectivesDisarmed,
      'objetiveTime': instance.objetiveTime,
      'revives': instance.revives,
      'secondsPlayed': instance.secondsPlayed,
      'sectorDefend': instance.sectorDefend,
      'winPercent': instance.winPercent,
      'wins': instance.wins,
    };

MapElement _$MapElementFromJson(Map<String, dynamic> json) => MapElement(
      id: json['id'] as String?,
      image: json['image'] as String?,
      losses: json['losses'] as int?,
      mapName: json['mapName'] as String?,
      matches: json['matches'] as int?,
      secondsPlayed: json['secondsPlayed'] as int?,
      winPercent: json['winPercent'] as String?,
      wins: json['wins'] as int?,
    );

Map<String, dynamic> _$MapElementToJson(MapElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'losses': instance.losses,
      'mapName': instance.mapName,
      'matches': instance.matches,
      'secondsPlayed': instance.secondsPlayed,
      'winPercent': instance.winPercent,
      'wins': instance.wins,
    };
