import 'package:battlefield_2042_state/components/basic/info_list_item_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';

class OverviewList extends StatelessWidget {
  const OverviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final List<InfoListItemContent> overviewListItems = [
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kills,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.kills),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.deaths,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.deaths),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kd,
          showValueString: AppLocalizations.of(context)!
              .universalDoubleDisplay(playerInfo.playerInfoEnsemble.KD),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kpm,
          showValueString: AppLocalizations.of(context)!
              .universalDoubleDisplay(playerInfo.playerInfoEnsemble.KPM),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.killsPerMatch,
          showValueString: AppLocalizations.of(context)!.universalDoubleDisplay(
              playerInfo.playerInfoEnsemble.killsPerMatch),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.multiKillsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.multiKills),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.damage,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.damage),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.mvp,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.MVP),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.bestSquad,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.bestSquad),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.assists,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.assists),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.wins,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.win),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.losses,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.lose),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.vehiclesDestroyed,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.killedVehicle),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.spotEnemies,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.spotEnemy),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.revives,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.recovery),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.resupplies,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.supply),
        ),
        InfoListItemContent(
          keyName: AppLocalizations.of(context)!.repairs,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(playerInfo.playerInfoEnsemble.repair),
        ),
      ];

      return Container(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            shrinkWrap: true,
            prototypeItem: const InfoListItem(
              keyName: 'kills',
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
