// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiteeVersionCheck _$GiteeVersionCheckFromJson(Map<String, dynamic> json) =>
    GiteeVersionCheck(
      id: json['id'] as int?,
      tagName: json['tag_name'] as String?,
      body: json['body'] as String?,
      assets: (json['assets'] as List<dynamic>?)
          ?.map((e) => ReleaseAssets.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GiteeVersionCheckToJson(GiteeVersionCheck instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_name': instance.tagName,
      'body': instance.body,
      'assets': instance.assets?.map((e) => e.toJson()).toList(),
    };

ReleaseAssets _$ReleaseAssetsFromJson(Map<String, dynamic> json) =>
    ReleaseAssets(
      browserDownloadUrl: json['browser_download_url'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ReleaseAssetsToJson(ReleaseAssets instance) =>
    <String, dynamic>{
      'browser_download_url': instance.browserDownloadUrl,
      'name': instance.name,
    };
