// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bftracker_player_vehicle_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kills _$KillsFromJson(Map<String, dynamic> json) => Kills(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$KillsToJson(Kills instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

TimePlayed _$TimePlayedFromJson(Map<String, dynamic> json) => TimePlayed(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$TimePlayedToJson(TimePlayed instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

DamageDealt _$DamageDealtFromJson(Map<String, dynamic> json) => DamageDealt(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$DamageDealtToJson(DamageDealt instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

DestroyedWith _$DestroyedWithFromJson(Map<String, dynamic> json) =>
    DestroyedWith(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$DestroyedWithToJson(DestroyedWith instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

PassengerAssists _$PassengerAssistsFromJson(Map<String, dynamic> json) =>
    PassengerAssists(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$PassengerAssistsToJson(PassengerAssists instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

DriverAssists _$DriverAssistsFromJson(Map<String, dynamic> json) =>
    DriverAssists(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$DriverAssistsToJson(DriverAssists instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

RoadKills _$RoadKillsFromJson(Map<String, dynamic> json) => RoadKills(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$RoadKillsToJson(RoadKills instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

MultiKills _$MultiKillsFromJson(Map<String, dynamic> json) => MultiKills(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$MultiKillsToJson(MultiKills instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

KillsPerMinute _$KillsPerMinuteFromJson(Map<String, dynamic> json) =>
    KillsPerMinute(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$KillsPerMinuteToJson(KillsPerMinute instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

DistanceTraveled _$DistanceTraveledFromJson(Map<String, dynamic> json) =>
    DistanceTraveled(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$DistanceTraveledToJson(DistanceTraveled instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

DmgPerMin _$DmgPerMinFromJson(Map<String, dynamic> json) => DmgPerMin(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DmgPerMinToJson(DmgPerMin instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

VehicleStat _$VehicleStatFromJson(Map<String, dynamic> json) => VehicleStat(
      kills: json['kills'] == null
          ? null
          : Kills.fromJson(json['kills'] as Map<String, dynamic>),
      timePlayed: json['timePlayed'] == null
          ? null
          : TimePlayed.fromJson(json['timePlayed'] as Map<String, dynamic>),
      damageDealt: json['damageDealt'] == null
          ? null
          : DamageDealt.fromJson(json['damageDealt'] as Map<String, dynamic>),
      destroyedWith: json['destroyedWith'] == null
          ? null
          : DestroyedWith.fromJson(
              json['destroyedWith'] as Map<String, dynamic>),
      passengerAssists: json['passengerAssists'] == null
          ? null
          : PassengerAssists.fromJson(
              json['passengerAssists'] as Map<String, dynamic>),
      driverAssists: json['driverAssists'] == null
          ? null
          : DriverAssists.fromJson(
              json['driverAssists'] as Map<String, dynamic>),
      roadKills: json['roadKills'] == null
          ? null
          : RoadKills.fromJson(json['roadKills'] as Map<String, dynamic>),
      multiKills: json['multiKills'] == null
          ? null
          : MultiKills.fromJson(json['multiKills'] as Map<String, dynamic>),
      killsPerMinute: json['killsPerMinute'] == null
          ? null
          : KillsPerMinute.fromJson(
              json['killsPerMinute'] as Map<String, dynamic>),
      distanceTraveled: json['distanceTraveled'] == null
          ? null
          : DistanceTraveled.fromJson(
              json['distanceTraveled'] as Map<String, dynamic>),
      dmgPerMin: json['dmgPerMin'] == null
          ? null
          : DmgPerMin.fromJson(json['dmgPerMin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VehicleStatToJson(VehicleStat instance) =>
    <String, dynamic>{
      'kills': instance.kills?.toJson(),
      'timePlayed': instance.timePlayed?.toJson(),
      'damageDealt': instance.damageDealt?.toJson(),
      'destroyedWith': instance.destroyedWith?.toJson(),
      'passengerAssists': instance.passengerAssists?.toJson(),
      'driverAssists': instance.driverAssists?.toJson(),
      'roadKills': instance.roadKills?.toJson(),
      'multiKills': instance.multiKills?.toJson(),
      'killsPerMinute': instance.killsPerMinute?.toJson(),
      'distanceTraveled': instance.distanceTraveled?.toJson(),
      'dmgPerMin': instance.dmgPerMin?.toJson(),
    };

VehicleMetadata _$VehicleMetadataFromJson(Map<String, dynamic> json) =>
    VehicleMetadata(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$VehicleMetadataToJson(VehicleMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

VehicleData _$VehicleDataFromJson(Map<String, dynamic> json) => VehicleData(
      type: json['type'] as String?,
      metadata: json['metadata'] == null
          ? null
          : VehicleMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      stats: json['stats'] == null
          ? null
          : VehicleStat.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VehicleDataToJson(VehicleData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'metadata': instance.metadata?.toJson(),
      'stats': instance.stats?.toJson(),
    };

BFTrackerVehicle _$BFTrackerVehicleFromJson(Map<String, dynamic> json) =>
    BFTrackerVehicle(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => VehicleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BFTrackerVehicleToJson(BFTrackerVehicle instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
