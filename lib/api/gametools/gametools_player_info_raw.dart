import 'package:json_annotation/json_annotation.dart';

part 'gametools_player_info_raw.g.dart';

@JsonSerializable()
class Fields {
  Fields({
    this.name,
    this.value,
  });

  String? name;
  int? value;

  factory Fields.fromJson(Map<String, dynamic> json) => _$FieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CatFields {
  CatFields({
    this.fields,
  });

  List<Fields>? fields;

  factory CatFields.fromJson(Map<String, dynamic> json) =>
      _$CatFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$CatFieldsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Categories {
  Categories({
    this.catFields,
  });

  CatFields? catFields;

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PlayerStats {
  PlayerStats({
    this.categories,
  });

  List<Categories>? categories;

  factory PlayerStats.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatsFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerStatsToJson(this);
}

@JsonSerializable()
class Player {
  Player({
    this.nucleusId,
    this.platformId,
    this.personaId,
  });

  int? nucleusId;
  int? platformId;
  int? personaId;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Loadouts {
  Loadouts({
    this.player,
    this.name,
    this.level,
  });

  Player? player;
  String? name;
  int? level;

  factory Loadouts.fromJson(Map<String, dynamic> json) =>
      _$LoadoutsFromJson(json);

  Map<String, dynamic> toJson() => _$LoadoutsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Inventory {
  Inventory({this.loadouts});

  List<Loadouts>? loadouts;

  factory Inventory.fromJson(Map<String, dynamic> json) =>
      _$InventoryFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Result {
  Result({
    this.inventory,
  });

  Inventory? inventory;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GametoolsPlayerInfoRaw {
  GametoolsPlayerInfoRaw({
    this.playerStats,
    this.result,
  });

  List<PlayerStats>? playerStats;
  Result? result;

  factory GametoolsPlayerInfoRaw.fromJson(Map<String, dynamic> json) =>
      _$GametoolsPlayerInfoRawFromJson(json);

  Map<String, dynamic> toJson() => _$GametoolsPlayerInfoRawToJson(this);
}
