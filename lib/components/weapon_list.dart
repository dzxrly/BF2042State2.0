import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/basic/info_list_item_content.dart';
import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';

enum DataType {
  secondsPlayed('时长', 'timePlayed'),
  headshotRate('爆头率', 'headshotRate'),
  accuracy('命中率', 'accuracy'),
  efficiency('效率', 'efficiency');

  const DataType(this.label, this.value);

  final String label;
  final String value;
}

class WeaponList extends StatefulWidget {
  const WeaponList({Key? key}) : super(key: key);

  @override
  WeaponListState createState() => WeaponListState();
}

class WeaponListState extends State<WeaponList> {
  String dataTypeValue = 'timePlayed';

  void showWeaponDetails(BuildContext context, WeaponInfoEnsemble weapon) {
    final List<InfoListItemContent> weaponDetailList = [
      InfoListItemContent(keyName: '击杀数', showValueString: weapon.kills),
      InfoListItemContent(keyName: 'KPM', showValueString: weapon.KPM),
      InfoListItemContent(keyName: 'DPM', showValueString: weapon.DPM),
      InfoListItemContent(keyName: '爆头率', showValueString: weapon.hsRate),
      InfoListItemContent(keyName: '命中率', showValueString: weapon.accuracy),
      InfoListItemContent(keyName: '总伤害', showValueString: weapon.damage),
      InfoListItemContent(keyName: '连杀次数', showValueString: weapon.multiKills),
      InfoListItemContent(keyName: '效率', showValueString: weapon.efficiency),
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
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(weapon.weaponName ?? '未知武器',
                            style: Theme.of(context).textTheme.titleLarge)),
                    const Padding(padding: EdgeInsets.only(left: 16)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(weapon.playedTime))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: const InfoListItem(
                    keyName: 'null', showValueString: 'null'),
                itemCount: weaponDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: weaponDetailList[index].keyName,
                      showValueString: weaponDetailList[index].showValueString);
                },
              ))
            ],
          ),
        ));
  }

  void setDataTypeValue(BuildContext context, String value) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context,
        ListView.builder(
          shrinkWrap: true,
          itemCount: DataType.values.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                DataType.values[index].label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              tileColor: dataTypeValue == DataType.values[index].value
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
              onTap: () => {
                setState(() {
                  dataTypeValue = DataType.values[index].value;
                }),
                Navigator.pop(context)
              },
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final weaponList = playerInfo.playerInfoEnsemble.weapons;
      weaponList.sort((a, b) => (int.parse(b.kills.replaceAll(',', '')))
          .compareTo(int.parse(a.kills.replaceAll(',', ''))));

      return TouchableList(
          listTitle: [
            Expanded(
                child: Text('武器名称',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                child: Text('击杀数',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                child: Text('KPM',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                child: InkWell(
                    borderRadius: BorderRadius.circular(19),
                    onTap: () => {setDataTypeValue(context, dataTypeValue)},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DataType.values
                              .firstWhere(
                                  (element) => element.value == dataTypeValue)
                              .label,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Icon(Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.primary,
                            size: 16)
                      ],
                    ))),
          ],
          listChild: ListView.builder(
            shrinkWrap: true,
            prototypeItem: WeaponListItem(
              weapon: WeaponInfoEnsemble(
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
              ),
              dataTypeValue: dataTypeValue,
            ),
            itemCount: playerInfo.playerInfoEnsemble.weapons.length,
            itemBuilder: (context, index) {
              return WeaponListItem(
                onTap: () => {
                  showWeaponDetails(
                      context, playerInfo.playerInfoEnsemble.weapons[index])
                },
                weapon: playerInfo.playerInfoEnsemble.weapons[index],
                dataTypeValue: dataTypeValue,
              );
            },
          ));
    });
  }
}

class WeaponListItem extends StatelessWidget {
  final WeaponInfoEnsemble weapon;
  final String dataTypeValue;
  final Function? onTap;

  const WeaponListItem(
      {Key? key, required this.weapon, required this.dataTypeValue, this.onTap})
      : super(key: key);

  String filterWeaponDataByDataTypeValue(
      WeaponInfoEnsemble weapon, String value) {
    switch (value) {
      case 'timePlayed':
        return weapon.playedTime;
      case 'headshotRate':
        return weapon.hsRate;
      case 'accuracy':
        return weapon.accuracy;
      case 'efficiency':
        return weapon.efficiency;
      default:
        return weapon.playedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
            child: Text(weapon.weaponName,
            softWrap: true,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium),
      )),
      Expanded(
          child: Text(
            weapon.kills,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      )),
      Expanded(
          child: Text(
            weapon.KPM,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      )),
      Expanded(
          child: Text(
        filterWeaponDataByDataTypeValue(weapon, dataTypeValue),
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      ))
    ];

    return TouchableListItem(
      expandChildren: expandChildren,
      onTap: onTap,
    );
  }
}
