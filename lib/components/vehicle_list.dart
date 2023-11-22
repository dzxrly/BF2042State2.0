import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/player_info.dart';
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
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');
  String dataTypeValue = 'killsPerMinute';

  void showVehicleDetails(BuildContext context, Vehicle vehicle) {
    final List<InfoListItemContent> vehicleDetailList = [
      InfoListItemContent(
          keyName: '击杀数',
          showValue: (vehicle.kills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: 'KPM',
          showValue: vehicle.killsPerMinute ?? 0.0,
          fractionDigits: 2),
      InfoListItemContent(
          keyName: '摧毁载具',
          showValue: (vehicle.vehiclesDestroyedWith ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '撞死人数',
          showValue: (vehicle.roadKills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '总伤害',
          showValue: (vehicle.damage ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '连杀次数',
          showValue: (vehicle.multiKills ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '驾驶助攻',
          showValue: (vehicle.driverAssists ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '乘客助攻',
          showValue: (vehicle.passengerAssists ?? 0).toDouble(),
          fractionDigits: 0),
      InfoListItemContent(
          keyName: '行驶距离 (KM)',
          showValue: ((vehicle.distanceTraveled ?? 0) / 1000).toDouble(),
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
                      child: Text(vehicle.vehicleName ?? '未知载具',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Badge(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        label: Text(
                            '${numberFormat.format(double.parse(((vehicle.timeIn ?? 0) / 3600.0).toStringAsFixed(2)))}小时'))
                  ]),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                prototypeItem: InfoListItem(
                    keyName: 'null',
                    showValue: 0.0,
                    showValueString: 'null',
                    fractionDigits: 0),
                itemCount: vehicleDetailList.length,
                itemBuilder: (context, index) {
                  return InfoListItem(
                      keyName: vehicleDetailList[index].keyName,
                      showValue: vehicleDetailList[index].showValue,
                      showValueString: vehicleDetailList[index].showValueString,
                      fractionDigits: vehicleDetailList[index].fractionDigits);
                },
              ))
            ],
          ),
        ));
  }

  void setDataTypeValue(String value) {
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
      final vehicleList = playerInfo.playerInfo?.vehicles ?? [];
      vehicleList.sort((a, b) => (b.kills ?? 0).compareTo(a.kills ?? 0));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 3,
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
                flex: 2,
                child: InkWell(
                    borderRadius: BorderRadius.circular(19),
                    onTap: () => {setDataTypeValue(dataTypeValue)},
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
                vehicle: Vehicle(),
                dataTypeValue: dataTypeValue,
              ),
              itemCount: playerInfo.playerInfo?.vehicles?.length ?? 0,
              itemBuilder: (context, index) {
                return VehicleListItem(
                  vehicle: playerInfo.playerInfo?.vehicles?[index] ?? Vehicle(),
                  onTap: () => {
                    showVehicleDetails(context,
                        playerInfo.playerInfo?.vehicles?[index] ?? Vehicle())
                  },
                  dataTypeValue: dataTypeValue,
                );
              }));
    });
  }
}

class VehicleListItem extends StatelessWidget {
  final Vehicle vehicle;
  final String dataTypeValue;
  final Function? onTap;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  VehicleListItem(
      {Key? key,
      required this.vehicle,
      required this.dataTypeValue,
      this.onTap})
      : super(key: key);

  String filterVehicleDataByDataTypeValue(Vehicle vehicle, String value) {
    switch (value) {
      case 'killsPerMinute':
        return vehicle.killsPerMinute?.toStringAsFixed(2) ?? '0.00';
      case 'timePlayed':
        return '${numberFormat.format(double.parse(((vehicle.timeIn ?? 0) / 3600.0).toStringAsFixed(2)))}小时';
      case 'destroyCount':
        return numberFormat.format(vehicle.vehiclesDestroyedWith ?? 0);
      default:
        return numberFormat.format(vehicle.timeIn ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> expandChildren = [
      Expanded(
          flex: 3,
          child: Text(vehicle.vehicleName ?? '未知载具',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium)),
      Expanded(
          flex: 1,
          child: Text(
            numberFormat.format(vehicle.kills ?? 0),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
              color: Theme.of(context).colorScheme.primary,
            ),
          )),
      Expanded(
          flex: 2,
          child: Text(
            filterVehicleDataByDataTypeValue(vehicle, dataTypeValue),
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
