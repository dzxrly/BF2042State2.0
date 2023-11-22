import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/basic/info_list_item_content.dart';
import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/player_info.dart';
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
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
  String dataTypeValue = 'timePlayed';

  void showWeaponDetails(BuildContext context, Weapon weapon) {
    final List<InfoListItemContent> weaponDetailList = [
      InfoListItemContent(
          keyName: '击杀数',
          showValue: (weapon.kills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: 'KPM',
          showValue: weapon.killsPerMinute ?? 0.0,
          fractionDigits: 2),
      InfoListItemContent(
          keyName: 'DPM',
          showValue: weapon.damagePerMinute ?? 0.0,
          fractionDigits: 2),
      InfoListItemContent(
          keyName: '爆头率',
          showValueString:
              '${((weapon.headshotKills ?? 0) / (weapon.kills ?? 1) * 100).toStringAsFixed(2)}%'),
      InfoListItemContent(
          keyName: '命中率',
          showValueString:
              '${((weapon.shotsHit ?? 0) / (weapon.shotsFired ?? 1) * 100).toStringAsFixed(2)}%'),
      InfoListItemContent(
          keyName: '总伤害',
          showValue: (weapon.damage ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '连杀次数',
          showValue: (weapon.multiKills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '效率', showValue: weapon.hitVKills ?? 0.0, fractionDigits: 2),
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
                        child: Text(weapon.weaponName ?? '未知武器',
                            style: Theme.of(context).textTheme.titleLarge)),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(
                            '${numberFormat.format(double.parse(((weapon.timeEquipped ?? 0) / 3600.0).toStringAsFixed(2)))}小时'))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: InfoListItem(
                    keyName: 'null',
                    showValue: 0.0,
                    showValueString: 'null',
                    fractionDigits: 0),
                itemCount: weaponDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: weaponDetailList[index].keyName,
                      showValue: weaponDetailList[index].showValue,
                      showValueString: weaponDetailList[index].showValueString,
                      fractionDigits: weaponDetailList[index].fractionDigits);
                },
              ))
            ],
          ),
        ));
  }

  void setDataTypeValue(String value) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context,
        ListView.builder(
          shrinkWrap: true,
          itemCount: DataType.values.length,
          itemBuilder: (context, index) {
            return RadioListTile(
              title: Text(DataType.values[index].label),
              value: DataType.values[index].value,
              groupValue: dataTypeValue,
              onChanged: (value) {
                setState(() {
                  dataTypeValue = value.toString();
                });
                Navigator.pop(context);
              },
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final weaponList = playerInfo.playerInfo?.weapons ?? [];
      weaponList.sort((a, b) => (b.kills ?? 0).compareTo(a.kills ?? 0));

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
                    onTap: () => {setDataTypeValue(dataTypeValue)},
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
              weapon: Weapon(),
              dataTypeValue: dataTypeValue,
            ),
            itemCount: playerInfo.playerInfo?.weapons?.length ?? 0,
            itemBuilder: (context, index) {
              return WeaponListItem(
                onTap: () => {
                  showWeaponDetails(context,
                      playerInfo.playerInfo?.weapons?[index] ?? Weapon())
                },
                weapon: playerInfo.playerInfo?.weapons?[index] ?? Weapon(),
                dataTypeValue: dataTypeValue,
              );
            },
          ));
    });
  }
}

class WeaponListItem extends StatelessWidget {
  final Weapon weapon;
  final String dataTypeValue;
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  WeaponListItem(
      {Key? key, required this.weapon, required this.dataTypeValue, this.onTap})
      : super(key: key);

  String filterWeaponDataByDataTypeValue(Weapon weapon, String value) {
    switch (value) {
      case 'timePlayed':
        return '${numberFormat.format(double.parse(((weapon.timeEquipped ?? 0) / 3600.0).toStringAsFixed(2)))}小时';
      case 'headshotRate':
        return '${((weapon.headshotKills ?? 0) / (weapon.kills ?? 1) * 100).toStringAsFixed(2)}%';
      case 'accuracy':
        return '${((weapon.shotsHit ?? 0) / (weapon.shotsFired ?? 1) * 100).toStringAsFixed(2)}%';
      case 'efficiency':
        return (weapon.hitVKills ?? 0.0).toStringAsFixed(2);
      default:
        return numberFormat.format(double.parse(
            ((weapon.timeEquipped ?? 0) / 3600.0).toStringAsFixed(2)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          child: Text(weapon.weaponName ?? '未知武器',
              softWrap: true,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium)),
      Expanded(
          child: Text(
        numberFormat.format(weapon.kills ?? 0),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      )),
      Expanded(
          child: Text(
        weapon.killsPerMinute?.toStringAsFixed(2) ?? '0.00',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.labelLarge?.fontWeight,
          fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
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
