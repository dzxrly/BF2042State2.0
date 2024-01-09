import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class ClassesList extends StatelessWidget {
  const ClassesList({super.key});

  void showVehicleDetails(BuildContext context, CharacterInfoEnsemble classes) {
    final List<InfoListItemContent> classesDetailList = [
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kdTitle,
          showValueString:
              AppLocalizations.of(context)!.universalDoubleDisplay(classes.KD)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kpmTitle,
          showValueString: AppLocalizations.of(context)!
              .universalDoubleDisplay(classes.KPM)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.killsTitle,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(classes.kills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.deaths,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(classes.deaths)),
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
                          AppLocalizations.of(context)!
                              .characterName(classes.characterName),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(AppLocalizations.of(context)!
                            .playedTime(classes.playedTime)))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: const InfoListItem(
                    keyName: 'null', showValueString: 'null'),
                itemCount: classesDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: classesDetailList[index].keyName,
                      showValueString:
                          classesDetailList[index].showValueString);
                },
              ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final classesList = playerInfo.playerInfoEnsemble.characters;
      classesList.sort((a, b) => (b.kills - a.kills));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text(AppLocalizations.of(context)!.characterNameTitle,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 2,
                child: Text(AppLocalizations.of(context)!.killsTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.kdTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.kpmTitle,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: ClassesListItem(
                  classes: CharacterInfoEnsemble(
                'null',
                'null',
                0,
                0,
                0,
                0,
                'null',
                0,
              )),
              itemCount: playerInfo.playerInfoEnsemble.characters.length,
              itemBuilder: (context, index) {
                return ClassesListItem(
                  classes: playerInfo.playerInfoEnsemble.characters[index],
                  onTap: () => {
                    showVehicleDetails(context,
                        playerInfo.playerInfoEnsemble.characters[index])
                  },
                );
              }));
    });
  }
}

class ClassesListItem extends StatelessWidget {
  final CharacterInfoEnsemble classes;
  final Function? onTap;

  const ClassesListItem({super.key, required this.classes, this.onTap});

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                AppLocalizations.of(context)!
                    .characterName(classes.characterName),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 2,
          child: Text(
            AppLocalizations.of(context)!.universalIntDisplay(classes.kills),
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
            AppLocalizations.of(context)!.universalDoubleDisplay(classes.KD),
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
            AppLocalizations.of(context)!.universalDoubleDisplay(classes.KPM),
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
