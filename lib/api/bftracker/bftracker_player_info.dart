import 'package:json_annotation/json_annotation.dart';

part 'bftracker_player_info.g.dart';

@JsonSerializable()
class HumanKdRatio {
  HumanKdRatio({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory HumanKdRatio.fromJson(Map<String, dynamic> json) =>
      _$HumanKdRatioFromJson(json);

  Map<String, dynamic> toJson() => _$HumanKdRatioToJson(this);
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

@JsonSerializable()
class HeadshotPercentage {
  HeadshotPercentage({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory HeadshotPercentage.fromJson(Map<String, dynamic> json) =>
      _$HeadshotPercentageFromJson(json);

  Map<String, dynamic> toJson() => _$HeadshotPercentageToJson(this);
}

@JsonSerializable()
class HumanKills {
  HumanKills({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory HumanKills.fromJson(Map<String, dynamic> json) =>
      _$HumanKillsFromJson(json);

  Map<String, dynamic> toJson() => _$HumanKillsToJson(this);
}

@JsonSerializable()
class DamagePerMatch {
  DamagePerMatch({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory DamagePerMatch.fromJson(Map<String, dynamic> json) =>
      _$DamagePerMatchFromJson(json);

  Map<String, dynamic> toJson() => _$DamagePerMatchToJson(this);
}

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
class DmgPerMin {
  DmgPerMin({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory DmgPerMin.fromJson(Map<String, dynamic> json) =>
      _$DmgPerMinFromJson(json);

  Map<String, dynamic> toJson() => _$DmgPerMinToJson(this);
}

@JsonSerializable()
class KillsPerMatch {
  KillsPerMatch({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory KillsPerMatch.fromJson(Map<String, dynamic> json) =>
      _$KillsPerMatchFromJson(json);

  Map<String, dynamic> toJson() => _$KillsPerMatchToJson(this);
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
class Assists {
  Assists({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Assists.fromJson(Map<String, dynamic> json) =>
      _$AssistsFromJson(json);

  Map<String, dynamic> toJson() => _$AssistsToJson(this);
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
class DamageDealt {
  DamageDealt({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory DamageDealt.fromJson(Map<String, dynamic> json) =>
      _$DamageDealtFromJson(json);

  Map<String, dynamic> toJson() => _$DamageDealtToJson(this);
}

@JsonSerializable()
class Mvps {
  Mvps({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Mvps.fromJson(Map<String, dynamic> json) => _$MvpsFromJson(json);

  Map<String, dynamic> toJson() => _$MvpsToJson(this);
}

@JsonSerializable()
class BestSquad {
  BestSquad({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory BestSquad.fromJson(Map<String, dynamic> json) =>
      _$BestSquadFromJson(json);

  Map<String, dynamic> toJson() => _$BestSquadToJson(this);
}

@JsonSerializable()
class VehiclesDestroyed {
  VehiclesDestroyed({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory VehiclesDestroyed.fromJson(Map<String, dynamic> json) =>
      _$VehiclesDestroyedFromJson(json);

  Map<String, dynamic> toJson() => _$VehiclesDestroyedToJson(this);
}

@JsonSerializable()
class Revives {
  Revives({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Revives.fromJson(Map<String, dynamic> json) =>
      _$RevivesFromJson(json);

  Map<String, dynamic> toJson() => _$RevivesToJson(this);
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

@JsonSerializable()
class DefendedObjectives {
  DefendedObjectives({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory DefendedObjectives.fromJson(Map<String, dynamic> json) =>
      _$DefendedObjectivesFromJson(json);

  Map<String, dynamic> toJson() => _$DefendedObjectivesToJson(this);
}

@JsonSerializable()
class DefendedSectors {
  DefendedSectors({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory DefendedSectors.fromJson(Map<String, dynamic> json) =>
      _$DefendedSectorsFromJson(json);

  Map<String, dynamic> toJson() => _$DefendedSectorsToJson(this);
}

@JsonSerializable()
class ObjectivesArmed {
  ObjectivesArmed({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory ObjectivesArmed.fromJson(Map<String, dynamic> json) =>
      _$ObjectivesArmedFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectivesArmedToJson(this);
}

@JsonSerializable()
class ObjectivesCaptured {
  ObjectivesCaptured({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory ObjectivesCaptured.fromJson(Map<String, dynamic> json) =>
      _$ObjectivesCapturedFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectivesCapturedToJson(this);
}

@JsonSerializable()
class ObjectivesDestroyed {
  ObjectivesDestroyed({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory ObjectivesDestroyed.fromJson(Map<String, dynamic> json) =>
      _$ObjectivesDestroyedFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectivesDestroyedToJson(this);
}

@JsonSerializable()
class ObjectivesDisarmed {
  ObjectivesDisarmed({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory ObjectivesDisarmed.fromJson(Map<String, dynamic> json) =>
      _$ObjectivesDisarmedFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectivesDisarmedToJson(this);
}

@JsonSerializable()
class ObjectiveTime {
  ObjectiveTime({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory ObjectiveTime.fromJson(Map<String, dynamic> json) =>
      _$ObjectiveTimeFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectiveTimeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Stats {
  Stats(
      this.humanKdRatio,
      this.killsPerMinute,
      this.headshotPercentage,
      this.humanKills,
      this.damagePerMatch,
      this.wlPercentage,
      this.wins,
      this.losses,
      this.matches,
      this.dmgPerMin,
      this.killsPerMatch,
      this.kills,
      this.deaths,
      this.assists,
      this.kdRatio,
      this.damageDealt,
      this.mvps,
      this.bestSquad,
      this.vehiclesDestroyed,
      this.revives,
      this.timePlayed,
      this.defendedObjectives,
      this.defendedSectors,
      this.objectivesArmed,
      this.objectivesCaptured,
      this.objectivesDestroyed,
      this.objectivesDisarmed,
      this.objectiveTime);

  final HumanKdRatio? humanKdRatio;
  final KillsPerMinute? killsPerMinute;
  final HeadshotPercentage? headshotPercentage;
  final HumanKills? humanKills;
  final DamagePerMatch? damagePerMatch;
  final WlPercentage? wlPercentage;
  final Wins? wins;
  final Losses? losses;
  final Matches? matches;
  final DmgPerMin? dmgPerMin;
  final KillsPerMatch? killsPerMatch;
  final Kills? kills;
  final Deaths? deaths;
  final Assists? assists;
  final KdRatio? kdRatio;
  final DamageDealt? damageDealt;
  final Mvps? mvps;
  final BestSquad? bestSquad;
  final VehiclesDestroyed? vehiclesDestroyed;
  final Revives? revives;
  final TimePlayed? timePlayed;
  final DefendedObjectives? defendedObjectives;
  final DefendedSectors? defendedSectors;
  final ObjectivesArmed? objectivesArmed;
  final ObjectivesCaptured? objectivesCaptured;
  final ObjectivesDestroyed? objectivesDestroyed;
  final ObjectivesDisarmed? objectivesDisarmed;
  final ObjectiveTime? objectiveTime;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);
}

@JsonSerializable()
class SegmentsMetadata {
  SegmentsMetadata({
    this.name,
  });

  final String? name;

  factory SegmentsMetadata.fromJson(Map<String, dynamic> json) =>
      _$SegmentsMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentsMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataSegmentsItem {
  DataSegmentsItem({
    this.type,
    this.metadata,
    this.stats,
  });

  final String? type;
  final SegmentsMetadata? metadata;
  final Stats? stats;

  factory DataSegmentsItem.fromJson(Map<String, dynamic> json) =>
      _$DataSegmentsItemFromJson(json);

  Map<String, dynamic> toJson() => _$DataSegmentsItemToJson(this);
}

@JsonSerializable()
class PlatformInfo {
  PlatformInfo({
    this.platformSlug,
    this.platformUserId,
    this.platformUserHandle,
    this.platformUserIdentifier,
    this.avatarUrl,
  });

  final String? platformSlug;
  final String? platformUserId;
  final String? platformUserHandle;
  final String? platformUserIdentifier;
  final String? avatarUrl;

  factory PlatformInfo.fromJson(Map<String, dynamic> json) =>
      _$PlatformInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BFTrackerPlayerInfoData {
  BFTrackerPlayerInfoData({
    this.platformInfo,
    this.segments,
  });

  final PlatformInfo? platformInfo;
  final List<DataSegmentsItem>? segments;

  factory BFTrackerPlayerInfoData.fromJson(Map<String, dynamic> json) =>
      _$BFTrackerPlayerInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$BFTrackerPlayerInfoDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BFTrackerPlayerInfo {
  BFTrackerPlayerInfo({
    this.data,
  });

  final BFTrackerPlayerInfoData? data;

  factory BFTrackerPlayerInfo.fromJson(Map<String, dynamic> json) =>
      _$BFTrackerPlayerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BFTrackerPlayerInfoToJson(this);
}
