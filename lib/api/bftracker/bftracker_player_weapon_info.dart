import 'package:json_annotation/json_annotation.dart';

part 'bftracker_player_weapon_info.g.dart';

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
class ShotsHit {
  ShotsHit({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory ShotsHit.fromJson(Map<String, dynamic> json) =>
      _$ShotsHitFromJson(json);

  Map<String, dynamic> toJson() => _$ShotsHitToJson(this);
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
class ShotsAccuracy {
  ShotsAccuracy({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final double? value;

  factory ShotsAccuracy.fromJson(Map<String, dynamic> json) =>
      _$ShotsAccuracyFromJson(json);

  Map<String, dynamic> toJson() => _$ShotsAccuracyToJson(this);
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
class WeaponStat {
  WeaponStat({
    this.kills,
    this.damageDealt,
    this.shotsHit,
    this.timePlayed,
    this.multiKills,
    this.killsPerMinute,
    this.shotsAccuracy,
    this.headshotPercentage,
    this.dmgPerMin,
  });

  final Kills? kills;
  final DamageDealt? damageDealt;
  final ShotsHit? shotsHit;
  final TimePlayed? timePlayed;
  final MultiKills? multiKills;
  final KillsPerMinute? killsPerMinute;
  final ShotsAccuracy? shotsAccuracy;
  final HeadshotPercentage? headshotPercentage;
  final DmgPerMin? dmgPerMin;

  factory WeaponStat.fromJson(Map<String, dynamic> json) =>
      _$WeaponStatFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponStatToJson(this);
}

@JsonSerializable()
class WeaponMetadata {
  WeaponMetadata({
    this.name,
  });

  final String? name;

  factory WeaponMetadata.fromJson(Map<String, dynamic> json) =>
      _$WeaponMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeaponData {
  WeaponData({
    this.type,
    this.metadata,
    this.stats,
  });

  final String? type;
  final WeaponMetadata? metadata;
  final WeaponStat? stats;

  factory WeaponData.fromJson(Map<String, dynamic> json) =>
      _$WeaponDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Weapon {
  Weapon({
    this.data,
  });

  final List<WeaponData>? data;

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponToJson(this);
}
