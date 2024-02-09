import 'package:battlefield_2042_state/components/basic/custom_snackbar.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SharePlayerState extends StatelessWidget {
  const SharePlayerState({super.key});

  void expertPlayerInfoOnPressed(BuildContext context) {
    UtilTools.checkPermission(
      () => {
        // TODO: Implement the export player state feature
      },
      () => {
        Navigator.pop(context),
        CustomSnackBar.showSnackBar(
          context,
          AppLocalizations.of(context)!.permissionStorageIsDenied,
        ).show(context)
      },
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
            onTap: () => expertPlayerInfoOnPressed(context),
            child: Container(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 12, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
