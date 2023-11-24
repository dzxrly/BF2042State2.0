import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/player_info.dart';
import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class GameModeList extends StatelessWidget {
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  GameModeList({Key? key}) : super(key: key);

  void showVehicleDetails(BuildContext context, Gamemode gamemode) {
    final List<InfoListItemContent> gameModeDetailList = [
      InfoListItemContent(
          keyName: '击杀数',
          showValue: (gamemode.kills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: 'KPM', showValue: gamemode.kpm ?? 0.0, fractionDigits: 2),
      InfoListItemContent(
          keyName: '游玩场数',
          showValue: (gamemode.matches ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '获胜次数',
          showValue: (gamemode.wins ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '失败次数',
          showValue: (gamemode.losses ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
        keyName: '胜率',
        showValueString: gamemode.winPercent ?? '0.00%',
      ),
      InfoListItemContent(
          keyName: '占点时长 (小时)',
          showValueString: numberFormat.format(double.parse(
              ((gamemode.objetiveTime ?? 0) / 3600.0).toStringAsFixed(2)))),
      InfoListItemContent(
          keyName: '区域防守 (次)',
          showValue: (gamemode.sectorDefend ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '目标防守 (次)',
          showValue: (gamemode.objectivesDefended ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '目标占领 (次)',
          showValue: (gamemode.objectivesCaptured ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '炸弹安放 (次)',
          showValue: (gamemode.objectivesArmed ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '炸弹拆除 (次)',
          showValue: (gamemode.objectivesDisarmed ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '炸弹摧毁 (次)',
          showValue: (gamemode.objectivesDestroyed ?? 0).toDouble(),
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
                          Translator.gamemodeTranslate(
                              gamemode.gamemodeName ?? '未知模式'),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(
                            '${numberFormat.format(double.parse(((gamemode.secondsPlayed ?? 0) / 3600.0).toStringAsFixed(2)))}小时'))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: InfoListItem(
                    keyName: 'null',
                    showValue: 0.0,
                    showValueString: 'null',
                    fractionDigits: 0),
                itemCount: gameModeDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: gameModeDetailList[index].keyName,
                      showValue: gameModeDetailList[index].showValue,
                      showValueString:
                          gameModeDetailList[index].showValueString,
                      fractionDigits: gameModeDetailList[index].fractionDigits);
                },
              ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final gameModeList = playerInfo.playerInfo?.gamemodes ?? [];
      gameModeList.sort((a, b) => (b.matches ?? 0).compareTo(a.matches ?? 0));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text('模式名称',
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text('游玩场数',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text('胜率',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: GameModeListItem(gamemode: Gamemode()),
              itemCount: playerInfo.playerInfo?.gamemodes?.length ?? 0,
              itemBuilder: (context, index) {
                return GameModeListItem(
                  gamemode:
                      playerInfo.playerInfo?.gamemodes?[index] ?? Gamemode(),
                  onTap: () => {
                    showVehicleDetails(context,
                        playerInfo.playerInfo?.gamemodes?[index] ?? Gamemode())
                  },
                );
              }));
    });
  }
}

class GameModeListItem extends StatelessWidget {
  final Gamemode gamemode;
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  GameModeListItem({Key? key, required this.gamemode, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                Translator.gamemodeTranslate(gamemode.gamemodeName ?? '未知模式'),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            numberFormat.format(gamemode.matches ?? 0),
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
            gamemode.winPercent ?? '0.00%',
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
