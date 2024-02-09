import 'package:battlefield_2042_state/api/gametools/bfban_check.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/api.dart';
import '../model/player_info_model.dart';

class KeyInfoView extends StatefulWidget {
  final String userId;

  const KeyInfoView({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => _KeyInfoViewState();
}

class _KeyInfoViewState extends State<KeyInfoView> {
  late int bfbanStatus;
  late String? bfbanUrl;
  BFBanCheckAPI bfBanCheckAPI = BFBanCheckAPI();

  _KeyInfoViewState() {
    bfbanStatus = -2; // -2: loading, -3: error, -1: not banned
    bfbanUrl = null;
  }

  void getBFBanCheckStatus(String userId) async {
    if (userId != '' || userId.isNotEmpty) {
      try {
        BFBanCheck bfBanCheck = await bfBanCheckAPI.fetchBFBanCheck(userId);
        if (mounted) {
          setState(() {
            bfbanStatus = bfBanCheck.status ?? -1;
            bfbanUrl = bfBanCheck.originPersonaId == null
                ? bfBanCheck.url
                : 'https://bfban.gametools.network/player/${bfBanCheck.originPersonaId}';
          });
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            bfbanStatus = -3;
            bfbanUrl = null;
          });
        }
      }
    }
  }

  Future<void> urlLauncher(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Error! Can not open URL: $url');
    }
  }

  @override
  void initState() {
    getBFBanCheckStatus(widget.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.realKD,
                    showValueString: AppLocalizations.of(context)!
                        .universalDoubleDisplay(
                            playerInfo.playerInfoEnsemble.realKD),
                  ),
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.realKPM,
                    showValueString: AppLocalizations.of(context)!
                        .universalDoubleDisplay(
                            playerInfo.playerInfoEnsemble.realKPM),
                  ),
                  KeyInfoWidget(
                      keyName: AppLocalizations.of(context)!.headshotRate,
                      showValueString: playerInfo.playerInfoEnsemble.hsRate),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.realKills,
                    showValueString: AppLocalizations.of(context)!
                        .universalIntDisplay(
                            playerInfo.playerInfoEnsemble.realKills),
                  ),
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.realKillsRate,
                    showValueString: playerInfo.playerInfoEnsemble.readKillRate,
                  ),
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.damagePerMatch,
                    showValueString: AppLocalizations.of(context)!
                        .universalDoubleDisplay(
                            playerInfo.playerInfoEnsemble.damagePerMatch),
                  ),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.winRate,
                    showValueString: playerInfo.playerInfoEnsemble.winRate,
                  ),
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.damagePerMinute,
                    showValueString: AppLocalizations.of(context)!
                        .universalDoubleDisplay(
                            playerInfo.playerInfoEnsemble.damagePerMinute),
                  ),
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.accuracy,
                    showValueString: playerInfo.playerInfoEnsemble.accuracy,
                  ),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.realKillsPerMatch,
                    showValueString: AppLocalizations.of(context)!
                        .universalDoubleDisplay(
                            playerInfo.playerInfoEnsemble.realKillsPerMatch),
                  ),
                  KeyInfoWidget(
                    keyName: AppLocalizations.of(context)!.matches,
                    showValueString: AppLocalizations.of(context)!
                        .universalIntDisplay(
                            playerInfo.playerInfoEnsemble.playedMatches),
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(19),
                        onTap: () => {
                          if (bfbanUrl != null)
                            {
                              urlLauncher(bfbanUrl!),
                            }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.bfban,
                                style: Theme.of(context).textTheme.bodyMedium,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                              const Padding(padding: EdgeInsets.only(top: 8)),
                              FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      bfbanStatus != -2
                                          ? Icon(
                                              bfbanStatus == -1
                                                  ? Icons.check_circle_outline
                                                  : Icons.error_outline,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.fontSize,
                                              color: bfbanStatus != 1
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                            )
                                          : SizedBox(
                                              width: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.fontSize,
                                              height: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.fontSize,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                      const Padding(
                                          padding: EdgeInsets.only(left: 2)),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .bfbanStatus(
                                                Translator.bfbanStatusTranslate(
                                                    bfbanStatus)),
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.fontWeight,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.fontSize,
                                          color: bfbanStatus != 1
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )),
                ]),
          ],
        ),
      );
    });
  }
}

class KeyInfoWidget extends StatelessWidget {
  final String keyName;
  final String? showValueString;

  const KeyInfoWidget({required this.keyName, this.showValueString, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                keyName,
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  showValueString ?? 'Unknown',
                  style: TextStyle(
                    fontWeight:
                        Theme.of(context).textTheme.bodyMedium?.fontWeight,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
