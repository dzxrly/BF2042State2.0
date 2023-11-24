import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class ClassesList extends StatelessWidget {
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  ClassesList({Key? key}) : super(key: key);

  void showVehicleDetails(BuildContext context, Classes classes) {
    final List<InfoListItemContent> classesDetailList = [
      InfoListItemContent(
          keyName: 'K/D',
          showValue: classes.killDeath ?? 0.0,
          fractionDigits: 2),
      InfoListItemContent(
          keyName: 'KPM', showValue: classes.kpm ?? 0.0, fractionDigits: 2),
      InfoListItemContent(
          keyName: '击杀数',
          showValue: (classes.kills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '死亡数',
          showValue: (classes.deaths ?? 0).toDouble(),
          fractionDigits: 0),
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
                        label: Text(
                            '${numberFormat.format(double.parse(((classes.secondsPlayed ?? 0) / 3600.0).toStringAsFixed(2)))}小时'))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: InfoListItem(
                    keyName: 'null',
                    showValue: 0.0,
                    showValueString: 'null',
                    fractionDigits: 0),
                itemCount: classesDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: classesDetailList[index].keyName,
                      showValue: classesDetailList[index].showValue,
                      showValueString: classesDetailList[index].showValueString,
                      fractionDigits: classesDetailList[index].fractionDigits);
                },
              ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final classesList = playerInfo.playerInfo?.classes ?? [];
      classesList.sort((a, b) => (b.kills ?? 0).compareTo(a.kills ?? 0));

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
              prototypeItem: ClassesListItem(classes: Classes()),
              itemCount: playerInfo.playerInfo?.classes?.length ?? 0,
              itemBuilder: (context, index) {
                return ClassesListItem(
                  classes: playerInfo.playerInfo?.classes?[index] ?? Classes(),
                  onTap: () => {
                    showVehicleDetails(context,
                        playerInfo.playerInfo?.classes?[index] ?? Classes())
                  },
                );
              }));
    });
  }
}

class ClassesListItem extends StatelessWidget {
  final Classes classes;
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  ClassesListItem({Key? key, required this.classes, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                Translator.classesTranslate(classes.characterName ?? '未知专家'),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 2,
          child: Text(
            numberFormat.format(classes.kills ?? 0),
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
            classes.killDeath?.toStringAsFixed(2) ?? '0.00',
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
            classes.kpm?.toStringAsFixed(2) ?? '0.00',
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
