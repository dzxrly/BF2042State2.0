import 'package:battlefield_2042_state/components/player_info_screen/key_info_view.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/model/player_info_tab.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PlayerInfoMainContent extends StatelessWidget {
  final double playerInfoCardWidthScale;
  final List<PlayerInfoTab> tabList;

  const PlayerInfoMainContent(
      {required this.playerInfoCardWidthScale,
      required this.tabList,
      super.key});

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
            tabList: tabList,
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
  final List<PlayerInfoTab> tabList;

  const PlayerDetailsInfoCard({
    super.key,
    required this.playerInfoCardWidthScale,
    required this.tabList,
  });

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
                    length: tabList.length,
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
                          tabs: tabList
                              .map((e) => Tab(
                                      child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                        Translator.appLocalizationsTranslate(
                                            AppLocalizations.of(context)!
                                                .playerInfoScreenTabItem(
                                                    e.tabName),
                                            e.tabName)),
                                  )))
                              .toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: tabList.map((e) => e.tabWidget).toList(),
                          ),
                        )
                      ],
                    )))));
  }
}
