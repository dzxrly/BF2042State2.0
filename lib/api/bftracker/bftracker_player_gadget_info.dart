import 'package:json_annotation/json_annotation.dart';

part 'bftracker_player_gadget_info.g.dart';

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
class Uses {
  Uses({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory Uses.fromJson(Map<String, dynamic> json) => _$UsesFromJson(json);

  Map<String, dynamic> toJson() => _$UsesToJson(this);
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
class MultiKills {
  MultiKills({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory MultiKills.fromJson(Map<String, dynamic> json) =>
      _$MultiKillsFromJson(json);

  Map<String, dynamic> toJson() => _$MultiKillsToJson(this);
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

@JsonSerializable(explicitToJson: true)
class GadgetStat {
  GadgetStat({
    this.kills,
    this.timePlayed,
    this.uses,
    this.damageDealt,
    this.vehiclesDestroyed,
    this.multiKills,
    this.killsPerMinute,
    this.dmgPerMin,
  });

  final Kills? kills;
  final TimePlayed? timePlayed;
  final Uses? uses;
  final DamageDealt? damageDealt;
  final VehiclesDestroyed? vehiclesDestroyed;
  final MultiKills? multiKills;
  final KillsPerMinute? killsPerMinute;
  final DmgPerMin? dmgPerMin;

  factory GadgetStat.fromJson(Map<String, dynamic> json) =>
      _$GadgetStatFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetStatToJson(this);
}

@JsonSerializable()
class GadgetMetadata {
  GadgetMetadata({
    this.name,
  });

  final String? name;

  factory GadgetMetadata.fromJson(Map<String, dynamic> json) =>
      _$GadgetMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GadgetData {
  GadgetData({
    this.type,
    this.metadata,
    this.stats,
  });

  final String? type;
  final GadgetMetadata? metadata;
  final GadgetStat? stats;

  factory GadgetData.fromJson(Map<String, dynamic> json) =>
      _$GadgetDataFromJson(json);

  Map<String, dynamic> toJson() => _$GadgetDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BFTrackerGadgets {
  BFTrackerGadgets({
    this.data,
  });

  final List<GadgetData>? data;

  factory BFTrackerGadgets.fromJson(Map<String, dynamic> json) =>
      _$BFTrackerGadgetsFromJson(json);

  Map<String, dynamic> toJson() => _$BFTrackerGadgetsToJson(this);
}
