import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

enum DataType {
  kpm('killsPerMinute'),
  uses('uses'),
  destroyCount('destroyCount');

  const DataType(this.value);

  final String value;
}

class GadgetList extends StatefulWidget {
  const GadgetList({super.key});

  @override
  GadgetListState createState() => GadgetListState();
}

class GadgetListState extends State<GadgetList> {
  String dataTypeValue = 'killsPerMinute';

  void showVehicleDetails(BuildContext context, GadgetInfoEnsemble gadget) {
    final List<InfoListItemContent> gadgetDetailList = [
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kills,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(gadget.kills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kpmTitle,
          showValueString:
              AppLocalizations.of(context)!.universalDoubleDisplay(gadget.KPM)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.vehiclesDestroyed,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gadget.killedVehicle)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.damage,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(gadget.damage)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.multiKillsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(gadget.multiKills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.usesTitle,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(gadget.used)),
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
                      child: Text(gadget.gadgetName,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: const InfoListItem(
                    keyName: 'null', showValueString: 'null'),
                itemCount: gadgetDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: gadgetDetailList[index].keyName,
                      showValueString: gadgetDetailList[index].showValueString);
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
                AppLocalizations.of(context)!
                    .gadgetDataType(DataType.values[index].value),
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
      final gadgetList = playerInfo.playerInfoEnsemble.gadgets;
      gadgetList.sort((a, b) => (b.kills - a.kills));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text(AppLocalizations.of(context)!.gadgetNameTitle,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text(AppLocalizations.of(context)!.killsTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: InkWell(
                    borderRadius: BorderRadius.circular(19),
                    onTap: () => {setDataTypeValue(context, dataTypeValue)},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .gadgetDataType(dataTypeValue),
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.primary,
                          size: 16,
                        )
                      ],
                    )))
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: GadgetListItem(
                  dataTypeValue: dataTypeValue,
                  gadget: GadgetInfoEnsemble(
                    'null',
                    'null',
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                  )),
              itemCount: playerInfo.playerInfoEnsemble.vehicles.length,
              itemBuilder: (context, index) {
                return GadgetListItem(
                  dataTypeValue: dataTypeValue,
                  gadget: playerInfo.playerInfoEnsemble.gadgets[index],
                  onTap: () => {
                    showVehicleDetails(
                        context, playerInfo.playerInfoEnsemble.gadgets[index])
                  },
                );
              }));
    });
  }
}

class GadgetListItem extends StatelessWidget {
  final GadgetInfoEnsemble gadget;
  final String dataTypeValue;
  final Function? onTap;

  const GadgetListItem(
      {super.key,
      required this.gadget,
      required this.dataTypeValue,
      this.onTap});

  String filterGadgetDataByDataTypeValue(
      BuildContext context, GadgetInfoEnsemble gadget, String value) {
    switch (value) {
      case 'killsPerMinute':
        return AppLocalizations.of(context)!.universalDoubleDisplay(gadget.KPM);
      case 'uses':
        return AppLocalizations.of(context)!.universalIntDisplay(gadget.used);
      case 'destroyCount':
        return AppLocalizations.of(context)!
            .universalIntDisplay(gadget.killedVehicle);
      default:
        return AppLocalizations.of(context)!.universalDoubleDisplay(gadget.KPM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(gadget.gadgetName,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            AppLocalizations.of(context)!.universalIntDisplay(gadget.kills),
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
            filterGadgetDataByDataTypeValue(context, gadget, dataTypeValue),
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
