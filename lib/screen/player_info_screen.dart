import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerInfoScreen extends StatelessWidget {
  const PlayerInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerInfoModel>(
      builder: (context, playerInfo, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(playerInfo.playerInfo?.userName ?? 'None'),
          ),
          body: Text(playerInfo.playerInfo?.userName ?? 'None'),
        );
      },
    );
  }
}
