// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bf_play_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BFPlayInfo _$BFPlayInfoFromJson(Map<String, dynamic> json) => BFPlayInfo(
      userId: json['userId'] as int?,
      userName: json['userName'] as String?,
      avatar: json['avatar'] as String?,
      id: json['id'] as int?,
      bf3: json['bf3'] as bool,
      bf4: json['bf4'] as bool,
      bfh: json['bfh'] as bool,
      bf1: json['bf1'] as bool,
      bfv: json['bfv'] as bool,
      bf2042: json['bf2042'] as bool,
    );

Map<String, dynamic> _$BFPlayInfoToJson(BFPlayInfo instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'avatar': instance.avatar,
      'id': instance.id,
      'bf3': instance.bf3,
      'bf4': instance.bf4,
      'bfh': instance.bfh,
      'bf1': instance.bf1,
      'bfv': instance.bfv,
      'bf2042': instance.bf2042,
    };
