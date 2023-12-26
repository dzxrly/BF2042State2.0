import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class GameModeList extends StatelessWidget {
  const GameModeList({Key? key}) : super(key: key);

  void showVehicleDetails(BuildContext context, GameModeInfoEnsemble gamemode) {
    final List<InfoListItemContent> gameModeDetailList = [
      InfoListItemContent(keyName: '击杀数', showValueString: gamemode.kills),
      InfoListItemContent(keyName: 'KPM', showValueString: gamemode.KPM),
      InfoListItemContent(
          keyName: '游玩场数', showValueString: gamemode.playedMatches),
      InfoListItemContent(keyName: '获胜次数', showValueString: gamemode.win),
      InfoListItemContent(keyName: '失败次数', showValueString: gamemode.lose),
      InfoListItemContent(
        keyName: '胜率',
        showValueString: gamemode.winRate,
      ),
      InfoListItemContent(
          keyName: '占点时长 (小时)', showValueString: gamemode.objectTime),
      InfoListItemContent(
          keyName: '区域防守 (次)', showValueString: gamemode.sectorDefend),
      InfoListItemContent(
          keyName: '目标防守 (次)', showValueString: gamemode.objectDefend),
      InfoListItemContent(
          keyName: '目标占领 (次)', showValueString: gamemode.objectCapture),
      InfoListItemContent(
          keyName: '炸弹安放 (次)', showValueString: gamemode.boomPlant),
      InfoListItemContent(
          keyName: '炸弹拆除 (次)', showValueString: gamemode.boomDefuse),
      InfoListItemContent(
          keyName: '炸弹摧毁 (次)', showValueString: gamemode.boomDestroy),
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
                          Translator.gamemodeTranslate(gamemode.modeName),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(gamemode.playedTime))
                  ]),
              Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                prototypeItem:
                    InfoListItem(keyName: 'null', showValueString: 'null'),
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
      gameModeList.sort((a, b) =>
          (int.parse(b.playedMatches.replaceAll(',', '')))
              .compareTo(int.parse(a.playedMatches.replaceAll(',', ''))));

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
              prototypeItem: GameModeListItem(
                  gamemode: GameModeInfoEnsemble(
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
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
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

  const GameModeListItem({Key? key, required this.gamemode, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(Translator.gamemodeTranslate(gamemode.modeName),
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            gamemode.playedMatches,
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
