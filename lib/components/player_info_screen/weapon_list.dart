import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/basic/error_chip.dart';
import 'package:battlefield_2042_state/components/basic/info_list_item_content.dart';
import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class WeaponList extends StatefulWidget {
  const WeaponList({super.key});

  @override
  WeaponListState createState() => WeaponListState();
}

class WeaponListState extends State<WeaponList> {
  final WeaponInfoEnsemble initWeapon = WeaponInfoEnsemble(
    'null',
    'null',
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    'null',
    0,
  );
  String dataTypeValue = 'headshotRate';
  List<String> dataType = [
    'timePlayed',
    'headshotRate',
    'accuracy',
    'efficiency'
  ];

  void showWeaponDetails(BuildContext context, WeaponInfoEnsemble weapon) {
    final List<InfoListItemContent> weaponDetailList = [
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.killsTitle,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(weapon.kills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kpmTitle,
          showValueString:
              AppLocalizations.of(context)!.universalDoubleDisplay(weapon.KPM)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.dpmTitle,
          showValueString:
              AppLocalizations.of(context)!.universalDoubleDisplay(weapon.DPM)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.headshotRate,
          showValueString: AppLocalizations.of(context)!
              .universalPercentDisplay(weapon.hsRate)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.accuracy,
          showValueString: AppLocalizations.of(context)!
              .universalPercentDisplay(weapon.accuracy)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.weaponHipfireKillsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(weapon.hipfireKills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.damage,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(weapon.damage)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.multiKillsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(weapon.multiKills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.efficiencyTitle,
          showValueString: AppLocalizations.of(context)!
              .universalDoubleDisplay(weapon.efficiency)),
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
                    if (weapon.cheatCheck)
                      ErrorChip(
                          label: AppLocalizations.of(context)!
                              .weaponCheatCheckTips),
                    if (weapon.cheatCheck)
                      const Padding(padding: EdgeInsets.all(4)),
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(weapon.weaponName,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontWeight,
                              color: Theme.of(context).colorScheme.onSurface,
                            ))),
                    const Padding(padding: EdgeInsets.all(4)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(AppLocalizations.of(context)!
                            .playedTime(weapon.playedTime))),
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

  void showAbnormalWeaponList(
      BuildContext context, List<WeaponInfoEnsemble> weaponList) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context,
        TouchableList(
          listTitle: [
            Expanded(
                child: Text(AppLocalizations.of(context)!.weaponNameTitle,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                child: Text(AppLocalizations.of(context)!.kpmTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                child: Text(AppLocalizations.of(context)!.headshotRate,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
          listChild: ListView.builder(
            shrinkWrap: true,
            prototypeItem: WeaponListItem(
              weapon: initWeapon,
              dataTypeValue: dataTypeValue,
            ),
            itemCount: weaponList.length,
            itemBuilder: (context, index) {
              return TouchableListItem(
                expandChildren: [
                  Expanded(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(weaponList[index].weaponName,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontWeight,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.fontSize,
                              color: Theme.of(context).colorScheme.onSurface,
                            ))
                      ],
                    ),
                  )),
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context)!
                        .universalDoubleDisplay(weaponList[index].KPM),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium?.fontWeight,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )),
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context)!
                        .universalPercentDisplay(weaponList[index].hsRate),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight:
                          Theme.of(context).textTheme.bodyMedium?.fontWeight,
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )),
                ],
                onTap: () => {
                  showWeaponDetails(context, weaponList[index]),
                },
              );
            },
          ),
          topPositionWidget: ErrorChip(
              label: AppLocalizations.of(context)!
                  .weaponCheatCheckTitleWithoutClickTip(weaponList.length)),
        ));
  }

  void setDataTypeValue(BuildContext context, String value) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context,
        ListView.builder(
          shrinkWrap: true,
          itemCount: dataType.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                AppLocalizations.of(context)!.weaponDataType(dataType[index]),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              tileColor: dataTypeValue == dataType[index]
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
              onTap: () => {
                setState(() {
                  dataTypeValue = dataType[index];
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
      weaponList.sort((a, b) => (b.kills - a.kills));
      final abnormalWeaponList = weaponList.where((element) {
        return element.cheatCheck;
      }).toList();

      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final bool showKPM =
            constraints.maxWidth > WidthBreakpoints.minFoldedScreen;
        if (!showKPM) {
          if (!dataType.contains('killsPerMinute')) {
            dataType.add('killsPerMinute');
          }
        } else {
          if (dataType.contains('killsPerMinute')) {
            dataType.remove('killsPerMinute');
          }
        }
        return TouchableList(
            listTitle: [
              Expanded(
                  child: Text(AppLocalizations.of(context)!.weaponNameTitle,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyLarge)),
              Expanded(
                  child: Text(AppLocalizations.of(context)!.killsTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge)),
              if (showKPM)
                Expanded(
                    child: Text(AppLocalizations.of(context)!.kpmTitle,
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
                            AppLocalizations.of(context)!
                                .weaponDataType(dataTypeValue),
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
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
                weapon: initWeapon,
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
                  showKPM: showKPM,
                );
              },
            ),
            topPositionWidget: abnormalWeaponList.isEmpty
                ? null
                : InkWell(
                    onTap: () =>
                        showAbnormalWeaponList(context, abnormalWeaponList),
                    child: ErrorChip(
                        label: AppLocalizations.of(context)!
                            .weaponCheatCheckTitle(abnormalWeaponList.length)),
                  ));
      });
    });
  }
}

class WeaponListItem extends StatelessWidget {
  final WeaponInfoEnsemble weapon;
  final String dataTypeValue;
  final bool showKPM;
  final Function? onTap;

  const WeaponListItem(
      {super.key,
      required this.weapon,
      required this.dataTypeValue,
      this.showKPM = true,
      this.onTap});

  String filterWeaponDataByDataTypeValue(
      BuildContext context, WeaponInfoEnsemble weapon, String value) {
    switch (value) {
      case 'timePlayed':
        return AppLocalizations.of(context)!.playedTime(weapon.playedTime);
      case 'headshotRate':
        return AppLocalizations.of(context)!
            .universalPercentDisplay(weapon.hsRate);
      case 'accuracy':
        return AppLocalizations.of(context)!
            .universalPercentDisplay(weapon.accuracy);
      case 'efficiency':
        return AppLocalizations.of(context)!
            .universalDoubleDisplay(weapon.efficiency);
      case 'killsPerMinute':
        return AppLocalizations.of(context)!.universalDoubleDisplay(weapon.KPM);
      default:
        return AppLocalizations.of(context)!.playedTime(weapon.playedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (weapon.cheatCheck)
              Icon(Icons.warning,
                  color: Theme.of(context).colorScheme.error,
                  size: Theme.of(context).textTheme.bodyMedium?.fontSize),
            if (weapon.cheatCheck)
              const Padding(padding: EdgeInsets.only(left: 4)),
            Text(weapon.weaponName,
                softWrap: true,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight:
                      Theme.of(context).textTheme.bodyMedium?.fontWeight,
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                  color: weapon.cheatCheck
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onSurface,
                ))
          ],
        ),
      )),
      Expanded(
          child: Text(
        AppLocalizations.of(context)!.universalIntDisplay(weapon.kills),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      )),
      if (showKPM)
        Expanded(
            child: Text(
          AppLocalizations.of(context)!.universalDoubleDisplay(weapon.KPM),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
            color: Theme.of(context).colorScheme.primary,
          ),
        )),
      Expanded(
        child: Text(
          filterWeaponDataByDataTypeValue(context, weapon, dataTypeValue),
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      )
    ];

    return TouchableListItem(
      expandChildren: expandChildren,
      onTap: onTap,
    );
  }
}
