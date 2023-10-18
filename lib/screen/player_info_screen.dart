import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayerInfoScreen extends StatelessWidget {
  final double playerInfoCardWidthScale;

  const PlayerInfoScreen({required this.playerInfoCardWidthScale, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
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
        ));
  }
}

class PlayerBaseInfoCard extends StatelessWidget {
  final double playerInfoCardWidthScale;

  const PlayerBaseInfoCard({required this.playerInfoCardWidthScale, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(
      builder: (context, playerInfo, child) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
          child: Container(
              width:
                  MediaQuery.of(context).size.width * playerInfoCardWidthScale,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              playerInfo.playerInfo?.avatar ?? '#',
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/avatar_span.png');
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return SpinKitCubeGrid(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  );
                                }
                              },
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(playerInfo.playerInfo?.userName ?? '未知',
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontSize,
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontWeight,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                Text(
                                  'UID: ${playerInfo.playerInfo?.userId.toString()}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                Text(
                                  '${((playerInfo.playerInfo?.secondsPlayed ?? 0) / 3600).toStringAsFixed(2)} 小时',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  Text(
                    'BFBan查询结果: TODO',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              )),
        );
      },
    );
  }
}

class PlayerDetailsInfoCard extends StatelessWidget {
  final double playerInfoCardWidthScale;

  const PlayerDetailsInfoCard(
      {required this.playerInfoCardWidthScale, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      return Expanded(
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
              child: Container(
                  width: MediaQuery.of(context).size.width *
                      playerInfoCardWidthScale,
                  padding: const EdgeInsets.only(top: 8),
                  child: const DefaultTabController(
                      length: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            isScrollable: true,
                            tabs: [
                              Tab(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.chartSimple,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text('总览')
                                ],
                              )),
                              Tab(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.personRifle,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text('步兵')
                                ],
                              )),
                              Tab(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.gun,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text('武器')
                                ],
                              )),
                              Tab(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.jetFighter,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text('载具')
                                ],
                              )),
                              Tab(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.toolbox,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text('装备')
                                ],
                              )),
                              Tab(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.bars,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text('模式')
                                ],
                              )),
                              Tab(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.map,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(left: 8)),
                                  Text('地图')
                                ],
                              )),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Center(child: Text('总览')),
                                Center(child: Text('步兵')),
                                Center(child: Text('武器')),
                                Center(child: Text('载具')),
                                Center(child: Text('装备')),
                                Center(child: Text('模式')),
                                Center(child: Text('地图')),
                              ],
                            ),
                          )
                        ],
                      )))));
    });
  }
}
