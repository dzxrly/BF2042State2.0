import 'package:json_annotation/json_annotation.dart';

part 'bftracker_player_map_info.g.dart';

@JsonSerializable()
class WlPercentage {
  WlPercentage({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory WlPercentage.fromJson(Map<String, dynamic> json) =>
      _$WlPercentageFromJson(json);

  Map<String, dynamic> toJson() => _$WlPercentageToJson(this);
}

@JsonSerializable()
class Wins {
  Wins({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Wins.fromJson(Map<String, dynamic> json) => _$WinsFromJson(json);

  Map<String, dynamic> toJson() => _$WinsToJson(this);
}

@JsonSerializable()
class Losses {
  Losses({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Losses.fromJson(Map<String, dynamic> json) => _$LossesFromJson(json);

  Map<String, dynamic> toJson() => _$LossesToJson(this);
}

@JsonSerializable()
class Matches {
  Matches({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Matches.fromJson(Map<String, dynamic> json) =>
      _$MatchesFromJson(json);

  Map<String, dynamic> toJson() => _$MatchesToJson(this);
}

@JsonSerializable()
class TimePlayed {
  TimePlayed({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory TimePlayed.fromJson(Map<String, dynamic> json) =>
      _$TimePlayedFromJson(json);

  Map<String, dynamic> toJson() => _$TimePlayedToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MapStat {
  MapStat({
    this.wlPercentage,
    this.wins,
    this.losses,
    this.matches,
    this.timePlayed,
  });

  final WlPercentage? wlPercentage;
  final Wins? wins;
  final Losses? losses;
  final Matches? matches;
  final TimePlayed? timePlayed;

  factory MapStat.fromJson(Map<String, dynamic> json) =>
      _$MapStatFromJson(json);

  Map<String, dynamic> toJson() => _$MapStatToJson(this);
}

@JsonSerializable()
class MapMetadata {
  MapMetadata({
    this.name,
  });

  final String? name;

  factory MapMetadata.fromJson(Map<String, dynamic> json) =>
      _$MapMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MapMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MapData {
  MapData({
    this.type,
    this.stats,
    this.metadata,
  });

  final String? type;
  final MapStat? stats;
  final MapMetadata? metadata;

  factory MapData.fromJson(Map<String, dynamic> json) =>
      _$MapDataFromJson(json);

  Map<String, dynamic> toJson() => _$MapDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BFTrackerMap {
  BFTrackerMap({
    this.data,
  });

  final List<MapData>? data;

  factory BFTrackerMap.fromJson(Map<String, dynamic> json) =>
      _$BFTrackerMapFromJson(json);

  Map<String, dynamic> toJson() => _$BFTrackerMapToJson(this);
}
