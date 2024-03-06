// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiteeIssuesUser _$GiteeIssuesUserFromJson(Map<String, dynamic> json) =>
    GiteeIssuesUser(
      id: json['id'] as int?,
    );

Map<String, dynamic> _$GiteeIssuesUserToJson(GiteeIssuesUser instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

GiteeIssuesCommit _$GiteeIssuesCommitFromJson(Map<String, dynamic> json) =>
    GiteeIssuesCommit(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : GiteeIssuesUser.fromJson(json['user'] as Map<String, dynamic>),
      body: json['body'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$GiteeIssuesCommitToJson(GiteeIssuesCommit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'body': instance.body,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

GiteeIssues _$GiteeIssuesFromJson(Map<String, dynamic> json) => GiteeIssues(
      commits: (json['commits'] as List<dynamic>?)
          ?.map((e) => GiteeIssuesCommit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GiteeIssuesToJson(GiteeIssues instance) =>
    <String, dynamic>{
      'commits': instance.commits?.map((e) => e.toJson()).toList(),
    };
