// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gametools_player_info_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fields _$FieldsFromJson(Map<String, dynamic> json) => Fields(
      name: json['name'] as String?,
      value: json['value'] as int?,
    );

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

CatFields _$CatFieldsFromJson(Map<String, dynamic> json) => CatFields(
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Fields.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CatFieldsToJson(CatFields instance) => <String, dynamic>{
      'fields': instance.fields?.map((e) => e.toJson()).toList(),
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      catFields: json['catFields'] == null
          ? null
          : CatFields.fromJson(json['catFields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'catFields': instance.catFields?.toJson(),
    };

PlayerStats _$PlayerStatsFromJson(Map<String, dynamic> json) => PlayerStats(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerStatsToJson(PlayerStats instance) =>
    <String, dynamic>{
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      nucleusId: json['nucleusId'] as int?,
      platformId: json['platformId'] as int?,
      personaId: json['personaId'] as int?,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'nucleusId': instance.nucleusId,
      'platformId': instance.platformId,
      'personaId': instance.personaId,
    };

Loadouts _$LoadoutsFromJson(Map<String, dynamic> json) => Loadouts(
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
      name: json['name'] as String?,
      level: json['level'] as int?,
    );

Map<String, dynamic> _$LoadoutsToJson(Loadouts instance) => <String, dynamic>{
      'player': instance.player?.toJson(),
      'name': instance.name,
      'level': instance.level,
    };

Inventory _$InventoryFromJson(Map<String, dynamic> json) => Inventory(
      loadouts: (json['loadouts'] as List<dynamic>?)
          ?.map((e) => Loadouts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'loadouts': instance.loadouts?.map((e) => e.toJson()).toList(),
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      inventory: json['inventory'] == null
          ? null
          : Inventory.fromJson(json['inventory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'inventory': instance.inventory?.toJson(),
    };

GametoolsPlayerInfoRaw _$GametoolsPlayerInfoRawFromJson(
        Map<String, dynamic> json) =>
    GametoolsPlayerInfoRaw(
      playerStats: (json['playerStats'] as List<dynamic>?)
          ?.map((e) => PlayerStats.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GametoolsPlayerInfoRawToJson(
        GametoolsPlayerInfoRaw instance) =>
    <String, dynamic>{
      'playerStats': instance.playerStats?.map((e) => e.toJson()).toList(),
      'result': instance.result?.toJson(),
    };
