import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class GameModeList extends StatelessWidget {
  const GameModeList({super.key});

  void showVehicleDetails(BuildContext context, GameModeInfoEnsemble gamemode) {
    final List<InfoListItemContent> gameModeDetailList = [
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kills,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.kills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kpmTitle,
          showValueString: AppLocalizations.of(context)!
              .universalDoubleDisplay(gamemode.KPM)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.matches,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.playedMatches)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.wins,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(gamemode.win)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.losses,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(gamemode.lose)),
      InfoListItemContent(
        keyName: AppLocalizations.of(context)!.winRate,
        showValueString: gamemode.winRate,
      ),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.objectTimeTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.objectTime)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.sectorDefendsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.sectorDefend)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.objectDefendsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.objectDefend)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.objectTakenTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.objectCapture)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.objectArmedTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.boomPlant)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.objectDisarmedTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.boomDefuse)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.objectDestroyedTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gamemode.boomDestroy)),
    ];

    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          Translator.appLocalizationsTranslate(
                              AppLocalizations.of(context)!
                                  .gameModeName(gamemode.modeName),
                              gamemode.modeName),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(AppLocalizations.of(context)!
                            .playedTime(gamemode.playedTime)))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: const InfoListItem(
                    keyName: 'null', showValueString: 'null'),
                itemCount: gameModeDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: gameModeDetailList[index].keyName,
                      showValueString:
                          gameModeDetailList[index].showValueString);
                },
              ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final gameModeList = playerInfo.playerInfoEnsemble.gameModes;
      gameModeList.sort((a, b) => (b.playedMatches - a.playedMatches));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text(AppLocalizations.of(context)!.gamemodeNameTitle,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.matches,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.winRate,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: GameModeListItem(
                  gamemode: GameModeInfoEnsemble(
                'null',
                'null',
                0,
                0,
                0,
                0,
                0,
                'null',
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
              )),
              itemCount: playerInfo.playerInfoEnsemble.gameModes.length,
              itemBuilder: (context, index) {
                return GameModeListItem(
                  gamemode: playerInfo.playerInfoEnsemble.gameModes[index],
                  onTap: () => {
                    showVehicleDetails(
                        context, playerInfo.playerInfoEnsemble.gameModes[index])
                  },
                );
              }));
    });
  }
}

class GameModeListItem extends StatelessWidget {
  final GameModeInfoEnsemble gamemode;
  final Function? onTap;

  const GameModeListItem({super.key, required this.gamemode, this.onTap});

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                Translator.appLocalizationsTranslate(
                    AppLocalizations.of(context)!
                        .gameModeName(gamemode.modeName),
                    gamemode.modeName),
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            AppLocalizations.of(context)!
                .universalIntDisplay(gamemode.playedMatches),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
      Expanded(
          flex: 1,
          child: Text(
            gamemode.winRate,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
    ];

    return TouchableListItem(
      expandChildren: expandChildren,
      onTap: onTap,
    );
  }
}
