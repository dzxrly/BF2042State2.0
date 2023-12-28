// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bftracker_player_weapon_info.dart';

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

DamageDealt _$DamageDealtFromJson(Map<String, dynamic> json) => DamageDealt(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$DamageDealtToJson(DamageDealt instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

ShotsHit _$ShotsHitFromJson(Map<String, dynamic> json) => ShotsHit(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$ShotsHitToJson(ShotsHit instance) => <String, dynamic>{
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

ShotsAccuracy _$ShotsAccuracyFromJson(Map<String, dynamic> json) =>
    ShotsAccuracy(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShotsAccuracyToJson(ShotsAccuracy instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

HeadshotPercentage _$HeadshotPercentageFromJson(Map<String, dynamic> json) =>
    HeadshotPercentage(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HeadshotPercentageToJson(HeadshotPercentage instance) =>
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

WeaponStat _$WeaponStatFromJson(Map<String, dynamic> json) => WeaponStat(
      kills: json['kills'] == null
          ? null
          : Kills.fromJson(json['kills'] as Map<String, dynamic>),
      damageDealt: json['damageDealt'] == null
          ? null
          : DamageDealt.fromJson(json['damageDealt'] as Map<String, dynamic>),
      shotsHit: json['shotsHit'] == null
          ? null
          : ShotsHit.fromJson(json['shotsHit'] as Map<String, dynamic>),
      timePlayed: json['timePlayed'] == null
          ? null
          : TimePlayed.fromJson(json['timePlayed'] as Map<String, dynamic>),
      multiKills: json['multiKills'] == null
          ? null
          : MultiKills.fromJson(json['multiKills'] as Map<String, dynamic>),
      killsPerMinute: json['killsPerMinute'] == null
          ? null
          : KillsPerMinute.fromJson(
              json['killsPerMinute'] as Map<String, dynamic>),
      shotsAccuracy: json['shotsAccuracy'] == null
          ? null
          : ShotsAccuracy.fromJson(
              json['shotsAccuracy'] as Map<String, dynamic>),
      headshotPercentage: json['headshotPercentage'] == null
          ? null
          : HeadshotPercentage.fromJson(
              json['headshotPercentage'] as Map<String, dynamic>),
      dmgPerMin: json['dmgPerMin'] == null
          ? null
          : DmgPerMin.fromJson(json['dmgPerMin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeaponStatToJson(WeaponStat instance) =>
    <String, dynamic>{
      'kills': instance.kills?.toJson(),
      'damageDealt': instance.damageDealt?.toJson(),
      'shotsHit': instance.shotsHit?.toJson(),
      'timePlayed': instance.timePlayed?.toJson(),
      'multiKills': instance.multiKills?.toJson(),
      'killsPerMinute': instance.killsPerMinute?.toJson(),
      'shotsAccuracy': instance.shotsAccuracy?.toJson(),
      'headshotPercentage': instance.headshotPercentage?.toJson(),
      'dmgPerMin': instance.dmgPerMin?.toJson(),
    };

WeaponMetadata _$WeaponMetadataFromJson(Map<String, dynamic> json) =>
    WeaponMetadata(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$WeaponMetadataToJson(WeaponMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

WeaponData _$WeaponDataFromJson(Map<String, dynamic> json) => WeaponData(
      type: json['type'] as String?,
      metadata: json['metadata'] == null
          ? null
          : WeaponMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      stats: json['stats'] == null
          ? null
          : WeaponStat.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeaponDataToJson(WeaponData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'metadata': instance.metadata?.toJson(),
      'stats': instance.stats?.toJson(),
    };

Weapon _$WeaponFromJson(Map<String, dynamic> json) => Weapon(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WeaponData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
