import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../basic/constraints_modal_bottom_sheet.dart';
import '../basic/info_list_item_content.dart';

class MapList extends StatelessWidget {
  const MapList({super.key});

  void showVehicleDetails(BuildContext context, MapInfoEnsemble mapElement) {
    final List<InfoListItemContent> mapDetailList = [
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.matches,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(mapElement.playedMatches)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.wins,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(mapElement.win)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.losses,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(mapElement.lose)),
      InfoListItemContent(
        keyName: AppLocalizations.of(context)!.winRate,
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
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          Translator.appLocalizationsTranslate(
                              AppLocalizations.of(context)!
                                  .mapName(mapElement.mapName),
                              mapElement.mapName),
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(AppLocalizations.of(context)!
                            .playedTime(mapElement.playedTime)))
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
      mapList.sort((a, b) => (b.playedMatches - a.playedMatches));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text(AppLocalizations.of(context)!.mapNameTitle,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.matches,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.winRate,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyLarge)),
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: MapListItem(
                  mapElement: MapInfoEnsemble(
                'null',
                'null',
                0,
                0,
                'null',
                0,
                0,
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

  const MapListItem({super.key, required this.mapElement, this.onTap});

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                Translator.appLocalizationsTranslate(
                    AppLocalizations.of(context)!.mapName(mapElement.mapName),
                    mapElement.mapName),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            AppLocalizations.of(context)!
                .universalIntDisplay(mapElement.playedMatches),
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
