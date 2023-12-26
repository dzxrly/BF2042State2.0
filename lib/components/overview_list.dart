import 'package:battlefield_2042_state/components/basic/info_list_item_content.dart';
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
          showValueString: playerInfo.playerInfoEnsemble.kills,
        ),
        InfoListItemContent(
          keyName: '死亡次数',
          showValueString: playerInfo.playerInfoEnsemble.deaths,
        ),
        InfoListItemContent(
          keyName: 'K/D (含AI)',
          showValueString: playerInfo.playerInfoEnsemble.KD,
        ),
        InfoListItemContent(
          keyName: 'KPM (含AI)',
          showValueString: playerInfo.playerInfoEnsemble.KPM,
        ),
        InfoListItemContent(
          keyName: '总伤害量 (含AI)',
          showValueString: playerInfo.playerInfoEnsemble.damage,
        ),
        InfoListItemContent(
          keyName: 'MVP',
          showValueString: playerInfo.playerInfoEnsemble.MVP,
        ),
        InfoListItemContent(
          keyName: '最佳小队',
          showValueString: playerInfo.playerInfoEnsemble.bestSquad,
        ),
        InfoListItemContent(
          keyName: '助攻次数',
          showValueString: playerInfo.playerInfoEnsemble.assists,
        ),
        InfoListItemContent(
          keyName: '获胜次数',
          showValueString: playerInfo.playerInfoEnsemble.win,
        ),
        InfoListItemContent(
          keyName: '战败次数',
          showValueString: playerInfo.playerInfoEnsemble.lose,
        ),
        InfoListItemContent(
          keyName: '摧毁载具',
          showValueString: playerInfo.playerInfoEnsemble.killedVehicle,
        ),
        InfoListItemContent(
          keyName: '索敌次数',
          showValueString: playerInfo.playerInfoEnsemble.spotEnemy,
        ),
        InfoListItemContent(
          keyName: '急救次数',
          showValueString: playerInfo.playerInfoEnsemble.recovery,
        ),
        InfoListItemContent(
          keyName: '补给次数',
          showValueString: playerInfo.playerInfoEnsemble.supply,
        ),
        InfoListItemContent(
          keyName: '维修次数',
          showValueString: playerInfo.playerInfoEnsemble.repair,
        ),
      ];

      return Container(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            shrinkWrap: true,
            prototypeItem: InfoListItem(
              keyName: '击杀数 (含AI)',
              showValueString: '9999',
            ),
            itemCount: overviewListItems.length,
            itemBuilder: (context, index) {
              return InfoListItem(
                keyName: overviewListItems[index].keyName,
                showValueString: overviewListItems[index].showValueString,
              );
            },
          ));
    });
  }
}
