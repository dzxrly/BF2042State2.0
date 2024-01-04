import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';
import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

enum DataType {
  kpm('KPM', 'killsPerMinute'),
  secondsPlayed('时长', 'timePlayed'),
  destroyCount('摧毁载具', 'destroyCount');

  const DataType(this.label, this.value);

  final String label;
  final String value;
}

class VehicleList extends StatefulWidget {
  const VehicleList({Key? key}) : super(key: key);

  @override
  VehicleListState createState() => VehicleListState();
}

class VehicleListState extends State<VehicleList> {
  String dataTypeValue = 'killsPerMinute';

  void showVehicleDetails(BuildContext context, VehicleInfoEnsemble vehicle) {
    final List<InfoListItemContent> vehicleDetailList = [
      InfoListItemContent(keyName: '击杀数', showValueString: vehicle.kills),
      InfoListItemContent(keyName: 'KPM', showValueString: vehicle.KPM),
      InfoListItemContent(
          keyName: '摧毁载具', showValueString: vehicle.killedVehicle),
      InfoListItemContent(keyName: '撞死人数', showValueString: vehicle.roadKills),
      InfoListItemContent(keyName: '总伤害', showValueString: vehicle.damage),
      InfoListItemContent(keyName: '连杀次数', showValueString: vehicle.multiKills),
      InfoListItemContent(
          keyName: '驾驶助攻', showValueString: vehicle.driverAssists),
      InfoListItemContent(
          keyName: '乘客助攻', showValueString: vehicle.passengerAssists),
      InfoListItemContent(
          keyName: '行驶距离 (KM)', showValueString: vehicle.distanceTraveled),
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
                      child: Text(vehicle.vehicleName,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 16)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(vehicle.playedTime))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: const InfoListItem(
                    keyName: 'null', showValueString: 'null'),
                itemCount: vehicleDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: vehicleDetailList[index].keyName,
                      showValueString:
                          vehicleDetailList[index].showValueString);
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
      final vehicleList = playerInfo.playerInfoEnsemble.vehicles;
      vehicleList.sort((a, b) => (int.parse(b.kills.replaceAll(',', '')))
          .compareTo(int.parse(a.kills.replaceAll(',', ''))));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text('载具名称',
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
                    ))),
          ],
          listChild: ListView.builder(
              shrinkWrap: true,
              prototypeItem: VehicleListItem(
                vehicle: VehicleInfoEnsemble(
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
                ),
                dataTypeValue: dataTypeValue,
              ),
              itemCount: playerInfo.playerInfoEnsemble.vehicles.length,
              itemBuilder: (context, index) {
                return VehicleListItem(
                  vehicle: playerInfo.playerInfoEnsemble.vehicles[index],
                  onTap: () => {
                    showVehicleDetails(
                        context, playerInfo.playerInfoEnsemble.vehicles[index])
                  },
                  dataTypeValue: dataTypeValue,
                );
              }));
    });
  }
}

class VehicleListItem extends StatelessWidget {
  final VehicleInfoEnsemble vehicle;
  final String dataTypeValue;
  final Function? onTap;

  const VehicleListItem(
      {Key? key,
      required this.vehicle,
      required this.dataTypeValue,
      this.onTap})
      : super(key: key);

  String filterVehicleDataByDataTypeValue(
      VehicleInfoEnsemble vehicle, String value) {
    switch (value) {
      case 'killsPerMinute':
        return vehicle.KPM;
      case 'timePlayed':
        return vehicle.playedTime;
      case 'destroyCount':
        return vehicle.killedVehicle;
      default:
        return vehicle.KPM;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(vehicle.vehicleName,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium),
          )),
      Expanded(
          flex: 1,
          child: Text(
            vehicle.kills,
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
            filterVehicleDataByDataTypeValue(vehicle, dataTypeValue),
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
