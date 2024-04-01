import 'package:battlefield_2042_state/api/api.dart';
import 'package:battlefield_2042_state/api/gitee/version_check.dart';
import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateBottomModalSheet extends StatefulWidget {
  const UpdateBottomModalSheet({super.key});

  @override
  State<StatefulWidget> createState() => UpdateBottomModalSheetState();
}

class UpdateBottomModalSheetState extends State<UpdateBottomModalSheet> {
  bool isVersionOutdated = false;
  String? latestVersionDownloadUrl;
  String? updateLog;
  String? currentVersionName;
  String? newVersionName;

  GiteeVersionCheckAPI giteeVersionCheckAPI = GiteeVersionCheckAPI();
  String channelName =
      const String.fromEnvironment('CHANNEL', defaultValue: 'github');

  void getVersion() async {
    if (!PlatformUtils.isWeb) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        currentVersionName = packageInfo.version;
        GiteeVersionCheck giteeVersionCheck =
            await giteeVersionCheckAPI.fetchGiteeVersionCheck();
        if (giteeVersionCheck.tagName != null &&
            giteeVersionCheck.assets != null &&
            giteeVersionCheck.assets!.isNotEmpty) {
          if (UtilTools.versionCompare(
              currentVersionName!, giteeVersionCheck.tagName!)) {
            setState(() {
              isVersionOutdated = true;
              latestVersionDownloadUrl =
                  giteeVersionCheck.assets![0].browserDownloadUrl;
              updateLog = giteeVersionCheck.body;
              newVersionName = giteeVersionCheck.tagName;
            });
          }
        } else {
          throw 'Network Error';
        }
      } catch (error) {
        rethrow;
      }
    }
  }

  void showVersionUpdateDetail(BuildContext context) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context,
        Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(AppLocalizations.of(context)!.upgradeDiscoveryTip,
                        style: Theme.of(context).textTheme.titleMedium),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Text(currentVersionName ?? '0.0.0',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontWeight,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Text('->', style: Theme.of(context).textTheme.titleMedium),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Text(newVersionName ?? '0.0.0',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontWeight,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                const Divider(height: 1),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Text(AppLocalizations.of(context)!.upgradeLogTitle,
                    style: Theme.of(context).textTheme.titleMedium),
                const Padding(padding: EdgeInsets.only(top: 4)),
                Text(updateLog ?? '无',
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium),
                const Padding(padding: EdgeInsets.only(top: 16)),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      disabledBackgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    onPressed: () => UtilTools.urlLauncher(
                        latestVersionDownloadUrl ??
                            'https://gitee.com/egg-targaryen/BF2042State2.0/releases/latest'),
                    child: Text(
                        AppLocalizations.of(context)!
                            .upgradeDownloadButtonTitle,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontWeight,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ))),
              ],
            )));
  }

  @override
  initState() {
    if (!PlatformUtils.isWeb && channelName == 'github') {
      getVersion();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isVersionOutdated && !PlatformUtils.isWeb && channelName == 'github'
        ? TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => showVersionUpdateDetail(context),
            child: Text(AppLocalizations.of(context)!.upgradeDiscoveryTitle))
        : Container();
  }
}
