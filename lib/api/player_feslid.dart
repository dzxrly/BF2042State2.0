import 'package:json_annotation/json_annotation.dart';

part 'player_feslid.g.dart';

@JsonSerializable()
class PlayerFeslid {
  PlayerFeslid({
    this.avatar,
  });

  final String? avatar;

  factory PlayerFeslid.fromJson(Map<String, dynamic> json) =>
      _$PlayerFeslidFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerFeslidToJson(this);
}
