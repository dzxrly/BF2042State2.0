import 'package:battlefield_2042_state/components/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/player_detail_info_list.dart';
import 'package:battlefield_2042_state/model/info_list_item_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/player_info.dart';
import '../model/player_info_model.dart';

class WeaponList extends StatelessWidget {
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  WeaponList({Key? key}) : super(key: key);

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
          keyName: '每次击杀命中数',
          showValue: weapon.hitVKills ?? 0.0,
          fractionDigits: 2),
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
                    Text(weapon.weaponName ?? '未知武器',
                        style: Theme.of(context).textTheme.titleMedium),
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
                    style: Theme.of(context).textTheme.labelLarge)),
            Expanded(
                child: Text('击杀数',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge)),
            Expanded(
                child: Text('KPM',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge)),
            Expanded(
                child: Text('时长 (小时)',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelLarge)),
          ],
          listChild: ListView.builder(
            shrinkWrap: true,
            prototypeItem: WeaponListItem(weapon: Weapon()),
            itemCount: playerInfo.playerInfo?.weapons?.length ?? 0,
            itemBuilder: (context, index) {
              return WeaponListItem(
                onTap: () => {
                  showWeaponDetails(context,
                      playerInfo.playerInfo?.weapons?[index] ?? Weapon())
                },
                weapon: playerInfo.playerInfo?.weapons?[index] ?? Weapon(),
              );
            },
          ));
    });
  }
}

class WeaponListItem extends StatelessWidget {
  final Weapon weapon;
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  WeaponListItem({Key? key, required this.weapon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          child: Text(weapon.weaponName ?? '未知武器',
              softWrap: true,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelLarge)),
      Expanded(
          child: Text(
        numberFormat.format(weapon.kills ?? 0),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.labelLarge?.fontWeight,
          fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
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
        numberFormat.format(double.parse(
            ((weapon.timeEquipped ?? 0) / 3600.0).toStringAsFixed(2))),
        textAlign: TextAlign.right,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.labelLarge?.fontWeight,
          fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
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
