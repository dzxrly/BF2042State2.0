import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/api.dart';
import '../api/bfban_check.dart';
import '../model/player_info_model.dart';

class KeyInfoView extends StatefulWidget {
  final String userId;

  const KeyInfoView({required this.userId, Key? key}) : super(key: key);

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
        setState(() {
          bfbanStatus = bfBanCheck.status ?? -1;
          bfbanUrl = bfBanCheck.originPersonaId == null
              ? bfBanCheck.url
              : 'https://bfban.gametools.network/player/${bfBanCheck.originPersonaId}';
        });
      } catch (e) {
        setState(() {
          bfbanStatus = -3;
          bfbanUrl = null;
        });
      }
    }
  }

  Future<void> urlLauncher(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('错误! 无法打开: $url');
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
                    keyName: '真实K/D',
                    showValueString: playerInfo.playerInfoEnsemble.realKD,
                  ),
                  KeyInfoWidget(
                    keyName: '真实KPM',
                    showValueString: playerInfo.playerInfoEnsemble.realKPM,
                  ),
                  KeyInfoWidget(
                      keyName: '爆头率',
                      showValueString: playerInfo.playerInfoEnsemble.hsRate),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: '真实击杀数',
                    showValueString: playerInfo.playerInfoEnsemble.realKills,
                  ),
                  KeyInfoWidget(
                    keyName: '真实击杀比',
                    showValueString: playerInfo.playerInfoEnsemble.readKillRate,
                  ),
                  KeyInfoWidget(
                    keyName: '场均伤害',
                    showValueString:
                        playerInfo.playerInfoEnsemble.damagePerMatch,
                  ),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: '胜率',
                    showValueString: playerInfo.playerInfoEnsemble.winRate,
                  ),
                  KeyInfoWidget(
                    keyName: 'DPM',
                    showValueString:
                        playerInfo.playerInfoEnsemble.damagePerMinute,
                  ),
                  KeyInfoWidget(
                    keyName: '命中率',
                    showValueString: playerInfo.playerInfoEnsemble.accuracy,
                  ),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: '场均击杀',
                    showValueString:
                        playerInfo.playerInfoEnsemble.killsPerMatch,
                  ),
                  KeyInfoWidget(
                    keyName: '游玩场次',
                    showValueString:
                        playerInfo.playerInfoEnsemble.playedMatches,
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
                                'BFBan',
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                        Translator.bfbanStatusTranslate(
                                            bfbanStatus),
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

  KeyInfoWidget({required this.keyName, this.showValueString, super.key});

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
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  showValueString ?? '未知',
                  style: TextStyle(
                    fontWeight:
                        Theme.of(context).textTheme.bodyMedium?.fontWeight,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
