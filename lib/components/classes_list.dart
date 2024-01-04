import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class ClassesList extends StatelessWidget {
  const ClassesList({Key? key}) : super(key: key);

  void showVehicleDetails(BuildContext context, CharacterInfoEnsemble classes) {
    final List<InfoListItemContent> classesDetailList = [
      InfoListItemContent(keyName: 'K/D', showValueString: classes.KD),
      InfoListItemContent(keyName: 'KPM', showValueString: classes.KPM),
      InfoListItemContent(keyName: '击杀数', showValueString: classes.kills),
      InfoListItemContent(keyName: '死亡数', showValueString: classes.deaths),
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
                          Translator.classesTranslate(
                              classes.characterName ?? '未知专家'),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(classes.playedTime))
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
      classesList.sort((a, b) => (int.parse(b.kills.replaceAll(',', '')))
          .compareTo(int.parse(a.kills.replaceAll(',', ''))));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text('专家名称',
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 2,
                child: Text('击杀数',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text('K/D',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text('KPM',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: ClassesListItem(
                  classes: CharacterInfoEnsemble(
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
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

  const ClassesListItem({Key? key, required this.classes, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(Translator.classesTranslate(classes.characterName),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 2,
          child: Text(
            classes.kills,
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
            classes.KD,
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
            classes.KPM,
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
