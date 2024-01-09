import 'package:battlefield_2042_state/components/basic/player_detail_info_list.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'basic/constraints_modal_bottom_sheet.dart';
import 'basic/info_list_item_content.dart';

enum DataType {
  kpm('killsPerMinute'),
  secondsPlayed('timePlayed'),
  destroyCount('destroyCount');

  const DataType(this.value);

  final String value;
}

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  VehicleListState createState() => VehicleListState();
}

class VehicleListState extends State<VehicleList> {
  String dataTypeValue = 'killsPerMinute';

  void showVehicleDetails(BuildContext context, VehicleInfoEnsemble vehicle) {
    final List<InfoListItemContent> vehicleDetailList = [
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.killsTitle,
          showValueString:
              AppLocalizations.of(context)!.universalIntDisplay(vehicle.kills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.kpmTitle,
          showValueString: AppLocalizations.of(context)!
              .universalDoubleDisplay(vehicle.KPM)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.vehiclesDestroyed,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(vehicle.killedVehicle)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.roadKillsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(vehicle.roadKills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.damage,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(vehicle.damage)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.multiKillsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(vehicle.multiKills)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.driverAssistsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(vehicle.driverAssists)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.passengerAssistsTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(vehicle.passengerAssists)),
      InfoListItemContent(
          keyName: AppLocalizations.of(context)!.distanceTraveledTitle,
          showValueString: AppLocalizations.of(context)!
              .universalIntDisplay(vehicle.distanceTraveled)),
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
                        label: Text(AppLocalizations.of(context)!
                            .playedTime(vehicle.playedTime)))
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
            return ListTile(
              title: Text(
                AppLocalizations.of(context)!
                    .vehicleDataType(DataType.values[index].value),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19)),
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
      final vehicleList = playerInfo.playerInfoEnsemble.vehicles;
      vehicleList.sort((a, b) => (b.kills - a.kills));

      return TouchableList(
          listTitle: [
            Expanded(
                flex: 2,
                child: Text(AppLocalizations.of(context)!.vehicleNameTitle,
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
                                .vehicleDataType(dataTypeValue),
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
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
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
      {super.key,
      required this.vehicle,
      required this.dataTypeValue,
      this.onTap});

  String filterVehicleDataByDataTypeValue(
      BuildContext context, VehicleInfoEnsemble vehicle, String value) {
    switch (value) {
      case 'killsPerMinute':
        return AppLocalizations.of(context)!
            .universalDoubleDisplay(vehicle.KPM);
      case 'timePlayed':
        return AppLocalizations.of(context)!.playedTime(vehicle.playedTime);
      case 'destroyCount':
        return AppLocalizations.of(context)!
            .universalIntDisplay(vehicle.killedVehicle);
      default:
        return AppLocalizations.of(context)!
            .universalDoubleDisplay(vehicle.KPM);
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
            AppLocalizations.of(context)!.universalIntDisplay(vehicle.kills),
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
            filterVehicleDataByDataTypeValue(context, vehicle, dataTypeValue),
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
