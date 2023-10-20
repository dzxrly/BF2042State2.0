import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';

class OverviewListItemContent {
  final String keyName;
  final double? showValue;
  final String? showValueString;
  final int? fractionDigits;

  OverviewListItemContent(
      {required this.keyName,
      this.showValue,
      this.showValueString,
      this.fractionDigits});
}

class OverviewList extends StatelessWidget {
  const OverviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final List<OverviewListItemContent> overviewListItems = [
        OverviewListItemContent(
          keyName: '击杀数 (含AI)',
          showValue: (playerInfo.playerInfo?.kills ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '死亡次数',
          showValue: (playerInfo.playerInfo?.deaths ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: 'K/D (含AI)',
          showValue: playerInfo.playerInfo?.killDeath ?? 0.0,
          fractionDigits: 2,
        ),
        OverviewListItemContent(
          keyName: 'KPM (含AI)',
          showValue: playerInfo.playerInfo?.killsPerMinute ?? 0.0,
          fractionDigits: 2,
        ),
        OverviewListItemContent(
          keyName: '总伤害量 (含AI)',
          showValue: (playerInfo.playerInfo?.damage ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: 'MVP',
          showValue: (playerInfo.playerInfo?.mvp ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '最佳小队',
          showValue: (playerInfo.playerInfo?.bestSquad ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '助攻次数',
          showValue: (playerInfo.playerInfo?.killAssists ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '获胜次数',
          showValue: (playerInfo.playerInfo?.wins ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '战败次数',
          showValue: (playerInfo.playerInfo?.loses ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '摧毁载具',
          showValue:
              (playerInfo.playerInfo?.vehiclesDestroyed ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '索敌次数',
          showValue: (playerInfo.playerInfo?.enemiesSpotted ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '急救次数',
          showValue: (playerInfo.playerInfo?.revives ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '补给次数',
          showValue: (playerInfo.playerInfo?.resupplies ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        OverviewListItemContent(
          keyName: '维修次数',
          showValue: (playerInfo.playerInfo?.repairs ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
      ];

      return Container(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            shrinkWrap: true,
            prototypeItem: OverviewListItem(
              keyName: '击杀数 (含AI)',
              showValue: 0,
              fractionDigits: 0,
            ),
            itemCount: overviewListItems.length,
            itemBuilder: (context, index) {
              return OverviewListItem(
                keyName: overviewListItems[index].keyName,
                showValue: overviewListItems[index].showValue,
                showValueString: overviewListItems[index].showValueString,
                fractionDigits: overviewListItems[index].fractionDigits,
              );
            },
          ));
    });
  }
}

class OverviewListItem extends StatelessWidget {
  final String keyName;
  final double? showValue;
  final String? showValueString;
  final int? fractionDigits;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  OverviewListItem(
      {required this.keyName,
      this.showValue,
      this.showValueString,
      this.fractionDigits,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keyName, style: Theme.of(context).textTheme.labelLarge),
          Text(
            showValue != null
                ? numberFormat.format(double.parse(
                    showValue!.toStringAsFixed(fractionDigits ?? 2)))
                : showValueString ?? '未知',
            style: TextStyle(
              fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight,
              fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
