import 'dart:developer';

import 'package:battlefield_2042_state/api/api.dart';
import 'package:battlefield_2042_state/api/gametools/bf_play_info.dart';
import 'package:battlefield_2042_state/api/gametools/player_feslid.dart';
import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/basic/info_list_item_content.dart';
import 'package:battlefield_2042_state/components/classes_list.dart';
import 'package:battlefield_2042_state/components/gadget_list.dart';
import 'package:battlefield_2042_state/components/gamemode_list.dart';
import 'package:battlefield_2042_state/components/map_list.dart';
import 'package:battlefield_2042_state/components/overview_list.dart';
import 'package:battlefield_2042_state/components/vehicle_list.dart';
import 'package:battlefield_2042_state/components/weapon_list.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/key_info_view.dart';
import '../utils/tools.dart';

enum TabList {
  overview('overview'),
  weapon('weapons'),
  vehicle('vehicles'),
  equipment('gadgets'),
  classes('classes'),
  mode('gamemodes'),
  map('maps');

  const TabList(this.name, {this.icon});

  final String name;
  final FaIcon? icon;
}

class PlayerInfoScreen extends StatelessWidget {
  final NumberFormat timeFormat = NumberFormat('#,###.00');
  final BFPlayInfoAPI bfPlayInfoAPI = BFPlayInfoAPI();
  final PostPlayerFeslidAPI postPlayerFeslidAPI = PostPlayerFeslidAPI();

  PlayerInfoScreen({super.key});

  Future<BFPlayInfo?> getBFPlayInfo(String name) async {
    log(name);
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
      String nucleusId,) async {
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
                        FittedBox(
                          child: Text(
                            playerInfo.playerInfoEnsemble.username,
                            style: TextStyle(
                              fontSize:
                              Theme.of(context).textTheme.titleLarge?.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
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
                              'UID: ${playerInfo.playerInfoEnsemble.nucleusId}',
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
                  return const PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.95,
                  );
                } else if (constraints.maxWidth < WidthBreakpoints.minM) {
                  return const PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.7,
                  );
                } else if (constraints.maxWidth < WidthBreakpoints.minL) {
                  return const PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.6,
                  );
                } else if (constraints.maxWidth < WidthBreakpoints.minXL) {
                  return const PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.5,
                  );
                } else {
                  return const PlayerInfoMainContent(
                    playerInfoCardWidthScale: 0.4,
                  );
                }
              },
            ),
          ));
    });
  }
}

class PlayerInfoMainContent extends StatelessWidget {
  final double playerInfoCardWidthScale;

  const PlayerInfoMainContent({required this.playerInfoCardWidthScale, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PlayerBaseInfoCard(
            playerInfoCardWidthScale: playerInfoCardWidthScale,
          ),
          const Padding(padding: EdgeInsets.only(top: 4)),
          PlayerDetailsInfoCard(
            playerInfoCardWidthScale: playerInfoCardWidthScale,
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
        ],
      ),
    );
  }
}

class PlayerBaseInfoCard extends StatelessWidget {
  final double playerInfoCardWidthScale;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  PlayerBaseInfoCard({required this.playerInfoCardWidthScale, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(
      builder: (context, playerInfo, child) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * playerInfoCardWidthScale,
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KeyInfoView(
                  userId: playerInfo.playerInfoEnsemble.nucleusId,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PlayerDetailsInfoCard extends StatelessWidget {
  final double playerInfoCardWidthScale;

  const PlayerDetailsInfoCard({required this.playerInfoCardWidthScale, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    playerInfoCardWidthScale,
                child: DefaultTabController(
                    length: TabList.values.length,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          tabAlignment: TabAlignment.start,
                          splashBorderRadius:
                          const BorderRadius.all(Radius.circular(19)),
                          indicator: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(19)),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          indicatorPadding: const EdgeInsets.only(
                            top: 45,
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          dividerHeight: 0,
                          isScrollable: true,
                          tabs: TabList.values
                              .map((e) => Tab(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8),
                                child: Text(AppLocalizations.of(context)!
                                    .playerInfoScreenTabItem(e.name)),
                              )))
                              .toList(),
                        ),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              OverviewList(),
                              WeaponList(),
                              VehicleList(),
                              GadgetList(),
                              ClassesList(),
                              GameModeList(),
                              MapList(),
                            ],
                          ),
                        )
                      ],
                    )))));
  }
}
