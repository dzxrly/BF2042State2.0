import 'package:json_annotation/json_annotation.dart';

part 'bftracker_player_vehicle_info.g.dart';

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
class DestroyedWith {
  DestroyedWith({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory DestroyedWith.fromJson(Map<String, dynamic> json) =>
      _$DestroyedWithFromJson(json);

  Map<String, dynamic> toJson() => _$DestroyedWithToJson(this);
}

@JsonSerializable()
class PassengerAssists {
  PassengerAssists({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory PassengerAssists.fromJson(Map<String, dynamic> json) =>
      _$PassengerAssistsFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerAssistsToJson(this);
}

@JsonSerializable()
class DriverAssists {
  DriverAssists({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory DriverAssists.fromJson(Map<String, dynamic> json) =>
      _$DriverAssistsFromJson(json);

  Map<String, dynamic> toJson() => _$DriverAssistsToJson(this);
}

@JsonSerializable()
class RoadKills {
  RoadKills({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory RoadKills.fromJson(Map<String, dynamic> json) =>
      _$RoadKillsFromJson(json);

  Map<String, dynamic> toJson() => _$RoadKillsToJson(this);
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
class DistanceTraveled {
  DistanceTraveled({
    this.percentile,
    this.value,
  });

  final double? percentile;
  final int? value;

  factory DistanceTraveled.fromJson(Map<String, dynamic> json) =>
      _$DistanceTraveledFromJson(json);

  Map<String, dynamic> toJson() => _$DistanceTraveledToJson(this);
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
class VehicleStat {
  VehicleStat({
    this.kills,
    this.timePlayed,
    this.damageDealt,
    this.destroyedWith,
    this.passengerAssists,
    this.driverAssists,
    this.roadKills,
    this.multiKills,
    this.killsPerMinute,
    this.distanceTraveled,
    this.dmgPerMin,
  });

  final Kills? kills;
  final TimePlayed? timePlayed;
  final DamageDealt? damageDealt;
  final DestroyedWith? destroyedWith;
  final PassengerAssists? passengerAssists;
  final DriverAssists? driverAssists;
  final RoadKills? roadKills;
  final MultiKills? multiKills;
  final KillsPerMinute? killsPerMinute;
  final DistanceTraveled? distanceTraveled;
  final DmgPerMin? dmgPerMin;

  factory VehicleStat.fromJson(Map<String, dynamic> json) =>
      _$VehicleStatFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleStatToJson(this);
}

@JsonSerializable()
class VehicleMetadata {
  VehicleMetadata({
    this.name,
  });

  final String? name;

  factory VehicleMetadata.fromJson(Map<String, dynamic> json) =>
      _$VehicleMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VehicleData {
  VehicleData({
    this.type,
    this.metadata,
    this.stats,
  });

  final String? type;
  final VehicleMetadata? metadata;
  final VehicleStat? stats;

  factory VehicleData.fromJson(Map<String, dynamic> json) =>
      _$VehicleDataFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BFTrackerVehicle {
  BFTrackerVehicle({
    this.data,
  });

  final List<VehicleData>? data;

  factory BFTrackerVehicle.fromJson(Map<String, dynamic> json) =>
      _$BFTrackerVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$BFTrackerVehicleToJson(this);
}
