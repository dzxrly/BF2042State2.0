import 'package:json_annotation/json_annotation.dart';

part 'bf_play_info.g.dart';

@JsonSerializable()
class BFPlayInfo {
  BFPlayInfo({
    this.userId,
    this.userName,
    this.avatar,
    this.id,
    required this.bf3,
    required this.bf4,
    required this.bfh,
    required this.bf1,
    required this.bfv,
    required this.bf2042,
  });

  final int? userId;
  final String? userName;
  final String? avatar;
  final int? id;
  final bool bf3;
  final bool bf4;
  final bool bfh;
  final bool bf1;
  final bool bfv;
  final bool bf2042;

  factory BFPlayInfo.fromJson(Map<String, dynamic> json) =>
      _$BFPlayInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BFPlayInfoToJson(this);
}
