import 'package:battlefield_2042_state/components/basic/custom_snackbar.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SharePlayerState extends StatelessWidget {
  const SharePlayerState({super.key});

  List<String> createJsonSnapshotFile(
    PlayerInfoEnsemble playerInfoEnsemble,
    String platform,
  ) {
    final nowTime = DateTime.now().toUtc();
    final fileName =
        'bf2042_${playerInfoEnsemble.personaId}_${nowTime.millisecondsSinceEpoch.toString()}.json';
    final playerInfoSnapshot = PlayerInfoSnapshot(
            playerInfoEnsemble, platform, nowTime.toIso8601String())
        .toJson()
        .toString();
    return [fileName, playerInfoSnapshot];
  }

  void expertPlayerInfoOnPressed(
    BuildContext context,
    PlayerInfoEnsemble playerInfoEnsemble,
    String platform,
  ) {
    final file = createJsonSnapshotFile(playerInfoEnsemble, platform);
    final fileName = file[0];
    final playerInfoSnapshot = file[1];
    FileExporter()
        .exportFile(
          fileName,
          playerInfoSnapshot,
        )
        .then((value) => {
              CustomSnackBar.showSnackBar(
                      context,
                      AppLocalizations.of(context)!
                          .exportPlayerStats('success'),
                      type: 'info')
                  .show(context)
            })
        .catchError((error) => {
              CustomSnackBar.showSnackBar(
                context,
                AppLocalizations.of(context)!.exportPlayerStats(error),
              ).show(context)
            });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      return ListView(
        shrinkWrap: true,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(19),
            onTap: () => expertPlayerInfoOnPressed(
              context,
              playerInfo.playerInfoEnsemble,
              playerInfo.platform ?? 'Unknown',
            ),
            child: Container(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 16)),
                    Text(
                      AppLocalizations.of(context)!.exportPlayerStatsBtnTitle,
                      style: TextStyle(
                        fontWeight:
                            Theme.of(context).textTheme.bodyMedium?.fontWeight,
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium?.fontSize,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )),
          )
        ],
      );
    });
  }
}
