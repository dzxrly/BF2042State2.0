// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bftracker_player_gadget_info.dart';

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

Uses _$UsesFromJson(Map<String, dynamic> json) => Uses(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$UsesToJson(Uses instance) => <String, dynamic>{
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

VehiclesDestroyed _$VehiclesDestroyedFromJson(Map<String, dynamic> json) =>
    VehiclesDestroyed(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$VehiclesDestroyedToJson(VehiclesDestroyed instance) =>
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

DmgPerMin _$DmgPerMinFromJson(Map<String, dynamic> json) => DmgPerMin(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DmgPerMinToJson(DmgPerMin instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

GadgetStat _$GadgetStatFromJson(Map<String, dynamic> json) => GadgetStat(
      kills: json['kills'] == null
          ? null
          : Kills.fromJson(json['kills'] as Map<String, dynamic>),
      timePlayed: json['timePlayed'] == null
          ? null
          : TimePlayed.fromJson(json['timePlayed'] as Map<String, dynamic>),
      uses: json['uses'] == null
          ? null
          : Uses.fromJson(json['uses'] as Map<String, dynamic>),
      damageDealt: json['damageDealt'] == null
          ? null
          : DamageDealt.fromJson(json['damageDealt'] as Map<String, dynamic>),
      vehiclesDestroyed: json['vehiclesDestroyed'] == null
          ? null
          : VehiclesDestroyed.fromJson(
              json['vehiclesDestroyed'] as Map<String, dynamic>),
      multiKills: json['multiKills'] == null
          ? null
          : MultiKills.fromJson(json['multiKills'] as Map<String, dynamic>),
      killsPerMinute: json['killsPerMinute'] == null
          ? null
          : KillsPerMinute.fromJson(
              json['killsPerMinute'] as Map<String, dynamic>),
      dmgPerMin: json['dmgPerMin'] == null
          ? null
          : DmgPerMin.fromJson(json['dmgPerMin'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GadgetStatToJson(GadgetStat instance) =>
    <String, dynamic>{
      'kills': instance.kills?.toJson(),
      'timePlayed': instance.timePlayed?.toJson(),
      'uses': instance.uses?.toJson(),
      'damageDealt': instance.damageDealt?.toJson(),
      'vehiclesDestroyed': instance.vehiclesDestroyed?.toJson(),
      'multiKills': instance.multiKills?.toJson(),
      'killsPerMinute': instance.killsPerMinute?.toJson(),
      'dmgPerMin': instance.dmgPerMin?.toJson(),
    };

GadgetMetadata _$GadgetMetadataFromJson(Map<String, dynamic> json) =>
    GadgetMetadata(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GadgetMetadataToJson(GadgetMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

GadgetData _$GadgetDataFromJson(Map<String, dynamic> json) => GadgetData(
      type: json['type'] as String?,
      metadata: json['metadata'] == null
          ? null
          : GadgetMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      stats: json['stats'] == null
          ? null
          : GadgetStat.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GadgetDataToJson(GadgetData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'metadata': instance.metadata?.toJson(),
      'stats': instance.stats?.toJson(),
    };

BFTrackerGadgets _$BFTrackerGadgetsFromJson(Map<String, dynamic> json) =>
    BFTrackerGadgets(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GadgetData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BFTrackerGadgetsToJson(BFTrackerGadgets instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
