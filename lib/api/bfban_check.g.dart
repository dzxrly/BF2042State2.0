// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bfban_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BFBanCheck _$BFBanCheckFromJson(Map<String, dynamic> json) => BFBanCheck(
      url: json['url'] as String?,
      status: json['status'] as int?,
      hacker: json['hacker'] as bool?,
      originId: json['originId'] as String?,
      originPersonaId: json['originPersonaId'] as String?,
      originUserId: json['originUserId'] as String?,
    );

Map<String, dynamic> _$BFBanCheckToJson(BFBanCheck instance) =>
    <String, dynamic>{
      'url': instance.url,
      'status': instance.status,
      'hacker': instance.hacker,
      'originId': instance.originId,
      'originPersonaId': instance.originPersonaId,
      'originUserId': instance.originUserId,
    };
