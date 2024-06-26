import 'package:battlefield_2042_state/api/api.dart';
import 'package:battlefield_2042_state/api/gametools/bf_play_info.dart';
import 'package:battlefield_2042_state/api/gametools/player_feslid.dart';
import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/basic/custom_snackbar.dart';
import 'package:battlefield_2042_state/components/basic/info_list_item_content.dart';
import 'package:battlefield_2042_state/components/player_info_screen/classes_list.dart';
import 'package:battlefield_2042_state/components/player_info_screen/gadget_list.dart';
import 'package:battlefield_2042_state/components/player_info_screen/gamemode_list.dart';
import 'package:battlefield_2042_state/components/player_info_screen/map_list.dart';
import 'package:battlefield_2042_state/components/player_info_screen/overview_list.dart';
import 'package:battlefield_2042_state/components/player_info_screen/player_info_screen_card.dart';
import 'package:battlefield_2042_state/components/player_info_screen/share_player_stats.dart';
import 'package:battlefield_2042_state/components/player_info_screen/vehicle_list.dart';
import 'package:battlefield_2042_state/components/player_info_screen/weapon_list.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/model/player_info_tab.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlayerInfoScreen extends StatelessWidget {
  final NumberFormat timeFormat = NumberFormat('#,###.00');
  final BFPlayInfoAPI bfPlayInfoAPI = BFPlayInfoAPI();
  final PostPlayerFeslidAPI postPlayerFeslidAPI = PostPlayerFeslidAPI();

  PlayerInfoScreen({super.key});

  Future<BFPlayInfo?> getBFPlayInfo(String name) async {
    try {
      BFPlayInfo bfPlayInfo = await bfPlayInfoAPI.fetchBFPlayInfo(name);
      return bfPlayInfo;
    } catch (e) {
      return null;
    }
  }

  Future<PlayerFeslid?> getPlayerFeslid(
    String platform,
    String personaId,
    String nucleusId,
  ) async {
    // pc: 1, psn: 2, xboxseries: 3
    String platformId = '1';
    switch (platform) {
      case 'pc':
        platformId = '1';
        break;
      case 'psn':
        platformId = '2';
        break;
      case 'xboxseries':
        platformId = '3';
        break;
      default:
        platformId = '1';
        break;
    }
    try {
      PlayerFeslid playerFeslid = await postPlayerFeslidAPI.postPlayerFeslid(
        platformId,
        personaId,
        nucleusId,
      );
      return playerFeslid;
    } catch (e) {
      return null;
    }
  }

  void onInfoButtonPressed(BuildContext context, String name) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context,
        FutureBuilder<BFPlayInfo?>(
            future: getBFPlayInfo(name),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitCubeGrid(
                          size: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Text(
                          AppLocalizations.of(context)!
                              .playerBFHistorySearching,
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .playerBFHistorySearchingError,
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.playerBFHistoryTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          InfoListItem(
                            keyName: AppLocalizations.of(context)!.battlefield3,
                            showValueString: snapshot.data!.bf3
                                ? AppLocalizations.of(context)!
                                    .playerBFHistoryPlayed
                                : AppLocalizations.of(context)!
                                    .playerBFHistoryNotPlayed,
                            textColor: snapshot.data!.bf3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                          ),
                          InfoListItem(
                            keyName: AppLocalizations.of(context)!.battlefield4,
                            showValueString: snapshot.data!.bf4
                                ? AppLocalizations.of(context)!
                                    .playerBFHistoryPlayed
                                : AppLocalizations.of(context)!
                                    .playerBFHistoryNotPlayed,
                            textColor: snapshot.data!.bf4
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                          ),
                          InfoListItem(
                            keyName: AppLocalizations.of(context)!.battlefieldH,
                            showValueString: snapshot.data!.bfh
                                ? AppLocalizations.of(context)!
                                    .playerBFHistoryPlayed
                                : AppLocalizations.of(context)!
                                    .playerBFHistoryNotPlayed,
                            textColor: snapshot.data!.bfh
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                          ),
                          InfoListItem(
                            keyName: AppLocalizations.of(context)!.battlefield1,
                            showValueString: snapshot.data!.bf1
                                ? AppLocalizations.of(context)!
                                    .playerBFHistoryPlayed
                                : AppLocalizations.of(context)!
                                    .playerBFHistoryNotPlayed,
                            textColor: snapshot.data!.bf1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                          ),
                          InfoListItem(
                            keyName: AppLocalizations.of(context)!.battlefieldV,
                            showValueString: snapshot.data!.bfv
                                ? AppLocalizations.of(context)!
                                    .playerBFHistoryPlayed
                                : AppLocalizations.of(context)!
                                    .playerBFHistoryNotPlayed,
                            textColor: snapshot.data!.bfv
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error,
                          ),
                        ],
                      );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .playerBFHistorySearchingError,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              }
            }));
  }

  void onShareBtnPressed(BuildContext context) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
        context, const SharePlayerState());
  }

  List<PlayerInfoTab> getTabList(PlayerInfoEnsemble playerInfo,
      {bool addOverview = true}) {
    List<PlayerInfoTab> tabList = [];
    if (addOverview) {
      tabList.add(
        PlayerInfoTab(
          tabWidget: const OverviewList(),
          tabName: 'overview',
        ),
      );
    }
    if (playerInfo.weapons.isNotEmpty) {
      tabList.add(
        PlayerInfoTab(
          tabWidget: const WeaponList(),
          tabName: 'weapons',
        ),
      );
    }
    if (playerInfo.vehicles.isNotEmpty) {
      tabList.add(
        PlayerInfoTab(
          tabWidget: const VehicleList(),
          tabName: 'vehicles',
        ),
      );
    }
    if (playerInfo.gadgets.isNotEmpty) {
      tabList.add(
        PlayerInfoTab(
          tabWidget: const GadgetList(),
          tabName: 'gadgets',
        ),
      );
    }
    if (playerInfo.characters.isNotEmpty) {
      tabList.add(
        PlayerInfoTab(
          tabWidget: const ClassesList(),
          tabName: 'classes',
        ),
      );
    }
    if (playerInfo.gameModes.isNotEmpty) {
      tabList.add(
        PlayerInfoTab(
          tabWidget: const GameModeList(),
          tabName: 'gamemodes',
        ),
      );
    }
    if (playerInfo.maps.isNotEmpty) {
      tabList.add(
        PlayerInfoTab(
          tabWidget: const MapList(),
          tabName: 'maps',
        ),
      );
    }
    return tabList;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      return Scaffold(
          appBar: AppBar(
              title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 42,
                    height: 42,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: FutureBuilder<PlayerFeslid?>(
                            future: getPlayerFeslid(
                              playerInfo.platform ?? '1',
                              playerInfo.playerInfoEnsemble.personaId,
                              playerInfo.playerInfoEnsemble.nucleusId,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitCubeGrid(
                                  size: 24,
                                  color: Theme.of(context).colorScheme.primary,
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data == null) {
                                  return Image.asset(
                                    'assets/avatar_span.png',
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Image.network(
                                    snapshot.data!.avatar ??
                                        'assets/avatar_span.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/avatar_span.png',
                                        fit: BoxFit.cover,
                                        cacheHeight: 42,
                                        cacheWidth: 42,
                                      );
                                    },
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return SpinKitCubeGrid(
                                          size: 24,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        );
                                      }
                                    },
                                  );
                                }
                              } else {
                                return Image.asset(
                                  'assets/avatar_span.png',
                                  fit: BoxFit.cover,
                                );
                              }
                            }))),
                const Padding(padding: EdgeInsets.only(left: 8)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Badge(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            textColor: Theme.of(context).colorScheme.onPrimary,
                            textStyle: Theme.of(context).textTheme.labelSmall,
                            label: Text(
                                'Lv.${playerInfo.playerInfoEnsemble.level.toString()}')),
                        const Padding(padding: EdgeInsets.only(left: 4)),
                        FittedBox(
                          child: Text(
                            playerInfo.playerInfoEnsemble.username,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (playerInfo.iconData != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                playerInfo.iconData,
                                size: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.fontSize,
                              ),
                              const Padding(padding: EdgeInsets.only(left: 4)),
                            ],
                          ),
                        Text(
                          'UID: ',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.fontWeight,
                          ),
                        ),
                        SelectableText(
                          playerInfo.playerInfoEnsemble.nucleusId,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.fontWeight,
                          ),
                          selectionControls: MaterialTextSelectionControls(),
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text: playerInfo
                                        .playerInfoEnsemble.nucleusId))
                                .then((value) => {
                              CustomSnackBar.showSnackBar(
                                        context,
                                        AppLocalizations.of(context)!
                                            .playerUidCopied,
                                      ).show(context)
                                    })
                                .catchError((error) => {
                              CustomSnackBar.showSnackBar(
                                        context,
                                        AppLocalizations.of(context)!
                                            .playerUidCopyError,
                                      ).show(context)
                                    });
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          AppLocalizations.of(context)!.playedTime(
                              playerInfo.playerInfoEnsemble.playedTime),
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.fontWeight,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(left: 8)),
                IconButton(
                  onPressed: () => onShareBtnPressed(context),
                  icon: const Icon(Icons.share_rounded),
                ),
                IconButton(
                  onPressed: () => onInfoButtonPressed(
                      context, playerInfo.playerInfoEnsemble.username),
                  icon: const Icon(Icons.help_outline),
                )
              ],
            ),
          )),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < WidthBreakpoints.minS) {
                  return PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.95,
                    tabList: getTabList(playerInfo.playerInfoEnsemble),
                  );
                } else if (constraints.maxWidth < WidthBreakpoints.minM) {
                  return PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.7,
                    tabList: getTabList(playerInfo.playerInfoEnsemble),
                  );
                } else if (constraints.maxWidth < WidthBreakpoints.minL) {
                  return PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.6,
                    tabList: getTabList(playerInfo.playerInfoEnsemble),
                  );
                } else if (constraints.maxWidth < WidthBreakpoints.minXL) {
                  return PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.5,
                    tabList: getTabList(playerInfo.playerInfoEnsemble),
                  );
                } else {
                  return PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.4,
                    tabList: getTabList(playerInfo.playerInfoEnsemble),
                  );
                }
              },
            ),
          ));
    });
  }
}
