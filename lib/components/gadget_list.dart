import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

enum DataType {
  kpm('KPM', 'killsPerMinute'),
  uses('使用', 'uses'),
  destroyCount('摧毁载具', 'destroyCount');

  const DataType(this.label, this.value);

  final String label;
  final String value;
}

class GadgetList extends StatefulWidget {
  const GadgetList({Key? key}) : super(key: key);

  @override
  GadgetListState createState() => GadgetListState();
}

class GadgetListState extends State<GadgetList> {
  String dataTypeValue = 'killsPerMinute';

  void showVehicleDetails(BuildContext context, GadgetInfoEnsemble gadget) {
    final List<InfoListItemContent> gadgetDetailList = [
      InfoListItemContent(keyName: '击杀数', showValueString: gadget.kills),
      InfoListItemContent(keyName: 'KPM', showValueString: gadget.KPM),
      InfoListItemContent(
          keyName: '摧毁载具', showValueString: gadget.killedVehicle),
      InfoListItemContent(keyName: '总伤害', showValueString: gadget.damage),
      InfoListItemContent(keyName: '连杀次数', showValueString: gadget.multiKills),
      InfoListItemContent(keyName: '使用次数', showValueString: gadget.used),
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
                      child: Text(gadget.gadgetName ?? '未知装备',
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
      final gadgetList = playerInfo.playerInfoEnsemble.gadgets;
      gadgetList.sort((a, b) => (int.parse(b.kills.replaceAll(',', '')))
          .compareTo(int.parse(a.kills.replaceAll(',', ''))));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text('装备名称',
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodyLarge)),
            Expanded(
                flex: 1,
                child: Text('击杀数',
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
                            DataType.values
                                .firstWhere(
                                    (element) => element.value == dataTypeValue)
                                .label,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyLarge),
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
                    '未知',
                    '未知',
                    '未知',
                    '未知',
                    '未知',
                    '未知',
                    '未知',
                    '未知',
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
      {Key? key, required this.gadget, required this.dataTypeValue, this.onTap})
      : super(key: key);

  String filterGadgetDataByDataTypeValue(
      GadgetInfoEnsemble gadget, String value) {
    switch (value) {
      case 'killsPerMinute':
        return gadget.KPM;
      case 'uses':
        return gadget.used;
      case 'destroyCount':
        return gadget.killedVehicle;
      default:
        return gadget.KPM;
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
            gadget.kills,
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
            filterGadgetDataByDataTypeValue(gadget, dataTypeValue),
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
