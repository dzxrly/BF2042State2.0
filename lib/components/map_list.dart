import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class MapList extends StatelessWidget {
  const MapList({Key? key}) : super(key: key);

  void showVehicleDetails(BuildContext context, MapInfoEnsemble mapElement) {
    final List<InfoListItemContent> mapDetailList = [
      InfoListItemContent(
          keyName: '游玩场数', showValueString: mapElement.playedMatches),
      InfoListItemContent(keyName: '获胜次数', showValueString: mapElement.win),
      InfoListItemContent(keyName: '失败次数', showValueString: mapElement.lose),
      InfoListItemContent(
        keyName: '胜率',
        showValueString: mapElement.winRate,
      ),
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
                          Translator.gameMapTranslate(mapElement.mapName),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(mapElement.playedTime))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: const InfoListItem(
                    keyName: 'null', showValueString: 'null'),
                itemCount: mapDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: mapDetailList[index].keyName,
                      showValueString: mapDetailList[index].showValueString);
                },
              ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final mapList = playerInfo.playerInfoEnsemble.maps;
      mapList.sort((a, b) => (int.parse(b.playedMatches.replaceAll(',', '')))
          .compareTo(int.parse(a.playedMatches.replaceAll(',', ''))));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text('地图名称',
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
              prototypeItem: MapListItem(
                  mapElement: MapInfoEnsemble(
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
                '未知',
              )),
              itemCount: playerInfo.playerInfoEnsemble.maps.length,
              itemBuilder: (context, index) {
                return MapListItem(
                  mapElement: playerInfo.playerInfoEnsemble.maps[index],
                  onTap: () => {
                    showVehicleDetails(
                        context, playerInfo.playerInfoEnsemble.maps[index])
                  },
                );
              }));
    });
  }
}

class MapListItem extends StatelessWidget {
  final MapInfoEnsemble mapElement;
  final Function? onTap;

  const MapListItem({Key? key, required this.mapElement, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(Translator.gameMapTranslate(mapElement.mapName),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            mapElement.playedMatches,
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
            mapElement.winRate,
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
