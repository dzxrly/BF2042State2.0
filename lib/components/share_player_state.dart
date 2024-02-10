import 'dart:io';

import 'package:battlefield_2042_state/components/basic/custom_snackbar.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SharePlayerState extends StatelessWidget {
  const SharePlayerState({super.key});

  void savePlayerInfoToFile(
    BuildContext context,
    PlayerInfoEnsemble playerInfoEnsemble,
    String platform,
  ) async {
    final nowTime = DateTime.now().toUtc();
    final fileName =
        'bf2042_${playerInfoEnsemble.personaId}_${nowTime.millisecondsSinceEpoch.toString()}.json';
    final playerInfoSnapshot = PlayerInfoSnapshot(
            playerInfoEnsemble, platform, nowTime.toIso8601String())
        .toJson()
        .toString();
    // save to file
    if (PlatformUtils.isAndroid) {
      final file = File('/storage/emulated/0/Documents/$fileName');
      await file.writeAsString(playerInfoSnapshot).then((value) {
        CustomSnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.exportPlayerStateSuccess,
          type: 'info',
        ).show(context);
      }).catchError((error) {
        CustomSnackBar.showSnackBar(
          context,
          '${AppLocalizations.of(context)!.exportPlayerStateFailed}: $error',
        ).show(context);
      });
    } else {
      // TODO: implement for Web
    }
  }

  void expertPlayerInfoOnPressed(
    BuildContext context,
    PlayerInfoEnsemble playerInfoEnsemble,
    String platform,
  ) {
    UtilTools.checkStoragePermission(
      () => savePlayerInfoToFile(context, playerInfoEnsemble, platform),
      () => {
        Navigator.pop(context),
        CustomSnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.permissionStorageIsDenied,
        ).show(context)
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(builder: (context, playerInfo, child) {
      return ListView(
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
                      AppLocalizations.of(context)!.exportPlayerStateBtnTitle,
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
