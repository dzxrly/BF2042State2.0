// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bftracker_player_map_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WlPercentage _$WlPercentageFromJson(Map<String, dynamic> json) => WlPercentage(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WlPercentageToJson(WlPercentage instance) =>
    <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

Wins _$WinsFromJson(Map<String, dynamic> json) => Wins(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$WinsToJson(Wins instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

Losses _$LossesFromJson(Map<String, dynamic> json) => Losses(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$LossesToJson(Losses instance) => <String, dynamic>{
      'percentile': instance.percentile,
      'value': instance.value,
    };

Matches _$MatchesFromJson(Map<String, dynamic> json) => Matches(
      percentile: (json['percentile'] as num?)?.toDouble(),
      value: json['value'] as int?,
    );

Map<String, dynamic> _$MatchesToJson(Matches instance) => <String, dynamic>{
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

MapStat _$MapStatFromJson(Map<String, dynamic> json) => MapStat(
      wlPercentage: json['wlPercentage'] == null
          ? null
          : WlPercentage.fromJson(json['wlPercentage'] as Map<String, dynamic>),
      wins: json['wins'] == null
          ? null
          : Wins.fromJson(json['wins'] as Map<String, dynamic>),
      losses: json['losses'] == null
          ? null
          : Losses.fromJson(json['losses'] as Map<String, dynamic>),
      matches: json['matches'] == null
          ? null
          : Matches.fromJson(json['matches'] as Map<String, dynamic>),
      timePlayed: json['timePlayed'] == null
          ? null
          : TimePlayed.fromJson(json['timePlayed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MapStatToJson(MapStat instance) => <String, dynamic>{
      'wlPercentage': instance.wlPercentage?.toJson(),
      'wins': instance.wins?.toJson(),
      'losses': instance.losses?.toJson(),
      'matches': instance.matches?.toJson(),
      'timePlayed': instance.timePlayed?.toJson(),
    };

MapMetadata _$MapMetadataFromJson(Map<String, dynamic> json) => MapMetadata(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$MapMetadataToJson(MapMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

MapData _$MapDataFromJson(Map<String, dynamic> json) => MapData(
      type: json['type'] as String?,
      stats: json['stats'] == null
          ? null
          : MapStat.fromJson(json['stats'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : MapMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MapDataToJson(MapData instance) => <String, dynamic>{
      'type': instance.type,
      'stats': instance.stats?.toJson(),
      'metadata': instance.metadata?.toJson(),
    };

BFTrackerMap _$BFTrackerMapFromJson(Map<String, dynamic> json) => BFTrackerMap(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MapData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BFTrackerMapToJson(BFTrackerMap instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
