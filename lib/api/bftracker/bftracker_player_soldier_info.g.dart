// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bftracker_player_soldier_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimePlayed _$TimePlayedFromJson(Map<String, dynamic> json) => TimePlayed(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$TimePlayedToJson(TimePlayed instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

Kills _$KillsFromJson(Map<String, dynamic> json) => Kills(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$KillsToJson(Kills instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

Deaths _$DeathsFromJson(Map<String, dynamic> json) => Deaths(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$DeathsToJson(Deaths instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

KdRatio _$KdRatioFromJson(Map<String, dynamic> json) => KdRatio(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$KdRatioToJson(KdRatio instance) => <String, dynamic>{
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

SoldierStat _$SoldierStatFromJson(Map<String, dynamic> json) => SoldierStat(
      timePlayed: json['timePlayed'] == null
          ? null
          : TimePlayed.fromJson(json['timePlayed'] as Map<String, dynamic>),
      kills: json['kills'] == null
          ? null
          : Kills.fromJson(json['kills'] as Map<String, dynamic>),
      deaths: json['deaths'] == null
          ? null
          : Deaths.fromJson(json['deaths'] as Map<String, dynamic>),
      kdRatio: json['kdRatio'] == null
          ? null
          : KdRatio.fromJson(json['kdRatio'] as Map<String, dynamic>),
      killsPerMinute: json['killsPerMinute'] == null
          ? null
          : KillsPerMinute.fromJson(
              json['killsPerMinute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SoldierStatToJson(SoldierStat instance) =>
    <String, dynamic>{
      'timePlayed': instance.timePlayed?.toJson(),
      'kills': instance.kills?.toJson(),
      'deaths': instance.deaths?.toJson(),
      'kdRatio': instance.kdRatio?.toJson(),
      'killsPerMinute': instance.killsPerMinute?.toJson(),
    };

SoldierMetadata _$SoldierMetadataFromJson(Map<String, dynamic> json) =>
    SoldierMetadata(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SoldierMetadataToJson(SoldierMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

SoldierData _$SoldierDataFromJson(Map<String, dynamic> json) => SoldierData(
      type: json['type'] as String?,
      stats: json['stats'] == null
          ? null
          : SoldierStat.fromJson(json['stats'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : SoldierMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SoldierDataToJson(SoldierData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'stats': instance.stats?.toJson(),
      'metadata': instance.metadata?.toJson(),
    };

BFTrackerSoldier _$BFTrackerSoldierFromJson(Map<String, dynamic> json) =>
    BFTrackerSoldier(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SoldierData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BFTrackerSoldierToJson(BFTrackerSoldier instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
