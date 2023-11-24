import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/player_info.dart';
import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

class MapList extends StatelessWidget {
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  MapList({Key? key}) : super(key: key);

  void showVehicleDetails(BuildContext context, MapElement mapElement) {
    final List<InfoListItemContent> mapDetailList = [
      InfoListItemContent(
          keyName: '游玩场数',
          showValue: (mapElement.matches ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '获胜次数',
          showValue: (mapElement.wins ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '失败次数',
          showValue: (mapElement.losses ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
        keyName: '胜率',
        showValueString: mapElement.winPercent ?? '0.00%',
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
                          Translator.gameMapTranslate(
                              mapElement.mapName ?? '未知地图'),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(
                            '${numberFormat.format(double.parse(((mapElement.secondsPlayed ?? 0) / 3600.0).toStringAsFixed(2)))}小时'))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: InfoListItem(
                    keyName: 'null',
                    showValue: 0.0,
                    showValueString: 'null',
                    fractionDigits: 0),
                itemCount: mapDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: mapDetailList[index].keyName,
                      showValue: mapDetailList[index].showValue,
                      showValueString: mapDetailList[index].showValueString,
                      fractionDigits: mapDetailList[index].fractionDigits);
                },
              ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final mapList = playerInfo.playerInfo?.maps ?? [];
      mapList.sort((a, b) => (b.matches ?? 0).compareTo(a.matches ?? 0));

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
              prototypeItem: MapListItem(mapElement: MapElement()),
              itemCount: playerInfo.playerInfo?.maps?.length ?? 0,
              itemBuilder: (context, index) {
                return MapListItem(
                  mapElement:
                      playerInfo.playerInfo?.maps?[index] ?? MapElement(),
                  onTap: () => {
                    showVehicleDetails(context,
                        playerInfo.playerInfo?.maps?[index] ?? MapElement())
                  },
                );
              }));
    });
  }
}

class MapListItem extends StatelessWidget {
  final MapElement mapElement;
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  MapListItem({Key? key, required this.mapElement, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                Translator.gameMapTranslate(mapElement.mapName ?? '未知地图'),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            numberFormat.format(mapElement.matches ?? 0),
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
            mapElement.winPercent ?? '0.00%',
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
