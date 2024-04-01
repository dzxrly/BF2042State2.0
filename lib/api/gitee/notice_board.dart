import 'package:json_annotation/json_annotation.dart';

part 'notice_board.g.dart';

@JsonSerializable()
class GiteeIssuesUser {
  GiteeIssuesUser({
    this.id,
  });

  final int? id;

  factory GiteeIssuesUser.fromJson(Map<String, dynamic> json) =>
      _$GiteeIssuesUserFromJson(json);

  Map<String, dynamic> toJson() => _$GiteeIssuesUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GiteeIssuesCommit {
  GiteeIssuesCommit({
    this.id,
    this.user,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final GiteeIssuesUser? user;
  final String? body;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  factory GiteeIssuesCommit.fromJson(Map<String, dynamic> json) =>
      _$GiteeIssuesCommitFromJson(json);

  Map<String, dynamic> toJson() => _$GiteeIssuesCommitToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GiteeIssues {
  GiteeIssues({
    this.commits,
  });

  final List<GiteeIssuesCommit>? commits;

  factory GiteeIssues.fromJson(List<dynamic> json) {
    return GiteeIssues(
      commits: json
          .map((dynamic e) =>
              GiteeIssuesCommit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$GiteeIssuesToJson(this);
}
