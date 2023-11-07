import 'package:json_annotation/json_annotation.dart';

part 'version_check.g.dart';

@JsonSerializable(explicitToJson: true)
class GiteeVersionCheck {
  GiteeVersionCheck({
    this.id,
    this.tagName,
    this.body,
    this.assets,
  });

  final int? id;
  @JsonKey(name: 'tag_name')
  final String? tagName;
  final String? body;
  final List<ReleaseAssets>? assets;

  factory GiteeVersionCheck.fromJson(Map<String, dynamic> json) =>
      _$GiteeVersionCheckFromJson(json);

  Map<String, dynamic> toJson() => _$GiteeVersionCheckToJson(this);
}

@JsonSerializable()
class ReleaseAssets {
  ReleaseAssets({
    this.browserDownloadUrl,
    this.name,
  });

  @JsonKey(name: 'browser_download_url')
  final String? browserDownloadUrl;
  final String? name;

  factory ReleaseAssets.fromJson(Map<String, dynamic> json) =>
      _$ReleaseAssetsFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseAssetsToJson(this);
}
