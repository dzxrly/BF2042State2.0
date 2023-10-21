import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
          bfbanUrl = bfBanCheck.url;
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
                    showValue: playerInfo.playerInfo?.infantryKillDeath ?? 0.0,
                    fractionDigits: 2,
                  ),
                  KeyInfoWidget(
                    keyName: '真实KPM',
                    showValue: double.parse(
                            (playerInfo.playerInfo?.humanPrecentage ?? '0')
                                .replaceAll('%', '')) /
                        100 *
                        (playerInfo.playerInfo?.killsPerMinute ?? 0.0),
                    fractionDigits: 2,
                  ),
                  KeyInfoWidget(
                    keyName: '爆头率',
                    showValueString:
                        playerInfo.playerInfo?.headshots ?? '0.00%',
                  ),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: '真实击杀数',
                    showValue: double.parse(
                            (playerInfo.playerInfo?.humanPrecentage ?? '0')
                                .replaceAll('%', '')) /
                        100 *
                        (playerInfo.playerInfo?.kills ?? 0),
                    fractionDigits: 0,
                  ),
                  KeyInfoWidget(
                    keyName: '真实击杀比',
                    showValueString:
                        '${double.parse((playerInfo.playerInfo?.humanPrecentage ?? '0').replaceAll('%', '')).toStringAsFixed(2)}%',
                  ),
                  KeyInfoWidget(
                    keyName: '场均伤害',
                    showValue: playerInfo.playerInfo?.damagePerMatch ?? 0.0,
                    fractionDigits: 2,
                  ),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: '胜率',
                    showValueString:
                        playerInfo.playerInfo?.winPercent ?? '0.00%',
                  ),
                  KeyInfoWidget(
                    keyName: 'DPM',
                    showValue: playerInfo.playerInfo?.damagePerMinute ?? 0.0,
                    fractionDigits: 2,
                  ),
                  KeyInfoWidget(
                    keyName: '命中率',
                    showValueString:
                        '${((playerInfo.playerInfo?.shotsHit ?? 0.0) / (playerInfo.playerInfo?.shotsFired ?? 1.0) * 100).toStringAsFixed(2)}%',
                  ),
                ]),
            Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  KeyInfoWidget(
                    keyName: '场均击杀',
                    showValue: playerInfo.playerInfo?.killsPerMatch ?? 0.0,
                    fractionDigits: 2,
                  ),
                  KeyInfoWidget(
                    keyName: '游玩场次',
                    showValue: (playerInfo.playerInfo?.matchesPlayed ?? 0.0)
                        .toDouble(),
                    fractionDigits: 0,
                  ),
                  Expanded(
                      flex: 1,
                      child: InkWell(
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
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const Padding(padding: EdgeInsets.only(top: 8)),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  Translator.bfbanStatusTranslate(bfbanStatus),
                                  style: TextStyle(
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.fontWeight,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.fontSize,
                                    color: bfbanStatus != 1
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
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
  final double? showValue;
  final String? showValueString;
  final int? fractionDigits;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  KeyInfoWidget(
      {required this.keyName,
      this.showValue,
      this.showValueString,
      this.fractionDigits,
      super.key});

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
                  showValue != null
                      ? numberFormat.format(double.parse(
                          showValue!.toStringAsFixed(fractionDigits ?? 2)))
                      : showValueString ?? '未知',
                  style: TextStyle(
                    fontWeight:
                        Theme.of(context).textTheme.bodyLarge?.fontWeight,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
