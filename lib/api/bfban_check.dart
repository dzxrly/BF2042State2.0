import 'package:json_annotation/json_annotation.dart';

part 'bfban_check.g.dart';

@JsonSerializable()
class BFBanCheck {
  BFBanCheck({
    this.url,
    this.status,
    this.hacker,
    this.originId,
    this.originPersonaId,
    this.originUserId,
  });

  final String? url;
  final int? status;
  final bool? hacker;
  final String? originId;
  final String? originPersonaId;
  final String? originUserId;

  factory BFBanCheck.fromJson(Map<String, dynamic> json) =>
      _$BFBanCheckFromJson(json);

  Map<String, dynamic> toJson() => _$BFBanCheckToJson(this);
}
