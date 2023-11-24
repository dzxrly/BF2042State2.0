import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
  String dataTypeValue = 'killsPerMinute';

  void showVehicleDetails(BuildContext context, Gadget gadget) {
    final List<InfoListItemContent> gadgetDetailList = [
      InfoListItemContent(
          keyName: '击杀数',
          showValue: (gadget.kills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: 'KPM', showValue: gadget.kpm ?? 0.0, fractionDigits: 2),
      InfoListItemContent(
          keyName: '摧毁载具',
          showValue: (gadget.vehiclesDestroyedWith ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '总伤害',
          showValue: (gadget.damage ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '连杀次数',
          showValue: (gadget.multiKills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '使用次数',
          showValue: (gadget.uses ?? 0).toDouble(),
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
                      child: Text(gadget.gadgetName ?? '未知装备',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: InfoListItem(
                    keyName: 'null',
                    showValue: 0.0,
                    showValueString: 'null',
                    fractionDigits: 0),
                itemCount: gadgetDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: gadgetDetailList[index].keyName,
                      showValue: gadgetDetailList[index].showValue,
                      showValueString: gadgetDetailList[index].showValueString,
                      fractionDigits: gadgetDetailList[index].fractionDigits);
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
      final gadgetList = playerInfo.playerInfo?.gadgets ?? [];
      gadgetList.sort((a, b) => (b.kills ?? 0).compareTo(a.kills ?? 0));

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
                  dataTypeValue: dataTypeValue, gadget: Gadget()),
              itemCount: playerInfo.playerInfo?.vehicles?.length ?? 0,
              itemBuilder: (context, index) {
                return GadgetListItem(
                  dataTypeValue: dataTypeValue,
                  gadget: playerInfo.playerInfo?.gadgets?[index] ?? Gadget(),
                  onTap: () => {
                    showVehicleDetails(context,
                        playerInfo.playerInfo?.gadgets?[index] ?? Gadget())
                  },
                );
              }));
    });
  }
}

class GadgetListItem extends StatelessWidget {
  final Gadget gadget;
  final String dataTypeValue;
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  GadgetListItem(
      {Key? key, required this.gadget, required this.dataTypeValue, this.onTap})
      : super(key: key);

  String filterGadgetDataByDataTypeValue(Gadget gadget, String value) {
    switch (value) {
      case 'killsPerMinute':
        return gadget.kpm.toString();
      case 'uses':
        return '${gadget.uses.toString()}次';
      case 'destroyCount':
        return gadget.vehiclesDestroyedWith.toString();
      default:
        return gadget.kpm.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(gadget.gadgetName ?? '未知装备',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            numberFormat.format(gadget.kills ?? 0),
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
