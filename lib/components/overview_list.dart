import 'package:battlefield_2042_state/components/info_list_item_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';

class OverviewList extends StatelessWidget {
  const OverviewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final List<InfoListItemContent> overviewListItems = [
        InfoListItemContent(
          keyName: '击杀数 (含AI)',
          showValue: (playerInfo.playerInfo?.kills ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '死亡次数',
          showValue: (playerInfo.playerInfo?.deaths ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: 'K/D (含AI)',
          showValue: playerInfo.playerInfo?.killDeath ?? 0.0,
          fractionDigits: 2,
        ),
        InfoListItemContent(
          keyName: 'KPM (含AI)',
          showValue: playerInfo.playerInfo?.killsPerMinute ?? 0.0,
          fractionDigits: 2,
        ),
        InfoListItemContent(
          keyName: '总伤害量 (含AI)',
          showValue: (playerInfo.playerInfo?.damage ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: 'MVP',
          showValue: (playerInfo.playerInfo?.mvp ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '最佳小队',
          showValue: (playerInfo.playerInfo?.bestSquad ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '助攻次数',
          showValue: (playerInfo.playerInfo?.killAssists ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '获胜次数',
          showValue: (playerInfo.playerInfo?.wins ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '战败次数',
          showValue: (playerInfo.playerInfo?.loses ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '摧毁载具',
          showValue:
              (playerInfo.playerInfo?.vehiclesDestroyed ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '索敌次数',
          showValue: (playerInfo.playerInfo?.enemiesSpotted ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '急救次数',
          showValue: (playerInfo.playerInfo?.revives ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '补给次数',
          showValue: (playerInfo.playerInfo?.resupplies ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
        InfoListItemContent(
          keyName: '维修次数',
          showValue: (playerInfo.playerInfo?.repairs ?? 0.0).toDouble(),
          fractionDigits: 0,
        ),
      ];

      return Container(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            shrinkWrap: true,
            prototypeItem: InfoListItem(
              keyName: '击杀数 (含AI)',
              showValue: 0,
              fractionDigits: 0,
            ),
            itemCount: overviewListItems.length,
            itemBuilder: (context, index) {
              return InfoListItem(
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
