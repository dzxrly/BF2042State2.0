import 'package:battlefield_2042_state/api/player_info.dart';
import 'package:battlefield_2042_state/components/player_detail_info_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/info_list_item_content.dart';
import '../model/player_info_model.dart';
import 'constraints_modal_bottom_sheet.dart';

class GadgetList extends StatelessWidget {
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  GadgetList({Key? key}) : super(key: key);

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
                    Text(gadget.gadgetName ?? '未知装备',
                        style: Theme.of(context).textTheme.titleMedium),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label:
                            Text('使用${numberFormat.format(gadget.uses ?? 0)}次'))
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

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      final gadgetList = playerInfo.playerInfo?.gadgets ?? [];
      gadgetList.sort((a, b) => (b.kills ?? 0).compareTo(a.kills ?? 0));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 3,
                child: Text('装备名称',
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.labelLarge)),
            Expanded(
                flex: 1,
                child: Text('击杀数',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelLarge)),
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: GadgetListItem(gadget: Gadget()),
              itemCount: playerInfo.playerInfo?.vehicles?.length ?? 0,
              itemBuilder: (context, index) {
                return GadgetListItem(
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
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  GadgetListItem({Key? key, required this.gadget, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 3,
          child: Text(gadget.gadgetName ?? '未知装备',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelLarge)),
      Expanded(
          flex: 1,
          child: Text(
            numberFormat.format(gadget.kills ?? 0),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: Theme.of(context).textTheme.labelLarge?.fontWeight,
              fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
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
