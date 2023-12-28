import 'package:json_annotation/json_annotation.dart';

part 'bftracker_player_soldier_info.g.dart';

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

@JsonSerializable()
class Kills {
  Kills({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Kills.fromJson(Map<String, dynamic> json) => _$KillsFromJson(json);

  Map<String, dynamic> toJson() => _$KillsToJson(this);
}

@JsonSerializable()
class Deaths {
  Deaths({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Deaths.fromJson(Map<String, dynamic> json) => _$DeathsFromJson(json);

  Map<String, dynamic> toJson() => _$DeathsToJson(this);
}

@JsonSerializable()
class KdRatio {
  KdRatio({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory KdRatio.fromJson(Map<String, dynamic> json) =>
      _$KdRatioFromJson(json);

  Map<String, dynamic> toJson() => _$KdRatioToJson(this);
}

@JsonSerializable()
class KillsPerMinute {
  KillsPerMinute({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory KillsPerMinute.fromJson(Map<String, dynamic> json) =>
      _$KillsPerMinuteFromJson(json);

  Map<String, dynamic> toJson() => _$KillsPerMinuteToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SoldierStat {
  SoldierStat({
    this.timePlayed,
    this.kills,
    this.deaths,
    this.kdRatio,
    this.killsPerMinute,
  });

  final TimePlayed? timePlayed;
  final Kills? kills;
  final Deaths? deaths;
  final KdRatio? kdRatio;
  final KillsPerMinute? killsPerMinute;

  factory SoldierStat.fromJson(Map<String, dynamic> json) =>
      _$SoldierStatFromJson(json);

  Map<String, dynamic> toJson() => _$SoldierStatToJson(this);
}

@JsonSerializable()
class SoldierMetadata {
  SoldierMetadata({
    this.name,
  });

  final String? name;

  factory SoldierMetadata.fromJson(Map<String, dynamic> json) =>
      _$SoldierMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SoldierMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SoldierData {
  SoldierData({
    this.type,
    this.stats,
    this.metadata,
  });

  final String? type;
  final SoldierStat? stats;
  final SoldierMetadata? metadata;

  factory SoldierData.fromJson(Map<String, dynamic> json) =>
      _$SoldierDataFromJson(json);

  Map<String, dynamic> toJson() => _$SoldierDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BFTrackerSoldier {
  BFTrackerSoldier({
    this.data,
  });

  final List<SoldierData>? data;

  factory BFTrackerSoldier.fromJson(Map<String, dynamic> json) =>
      _$BFTrackerSoldierFromJson(json);

  Map<String, dynamic> toJson() => _$BFTrackerSoldierToJson(this);
}
