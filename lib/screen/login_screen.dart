import 'dart:developer';

import 'package:battlefield_2042_state/api/api.dart';
import 'package:battlefield_2042_state/components/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/error_snackbar.dart';
import 'package:battlefield_2042_state/model/query_history.dart';
import 'package:battlefield_2042_state/screen/player_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';

enum Platform {
  pc('PC', 'pc'),
  psn('PlayStation (PSN)', 'psn'),
  xboxone('XBOX ONE', 'xboxone'),
  xboxseries('XBOX SERIES X/S', 'xboxseries');

  const Platform(this.label, this.value, [this.icon]);

  final String label;
  final String value;
  final Icon? icon;
}

class LoginScreen extends StatelessWidget {
  final double widthScale;

  const LoginScreen({required this.widthScale, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginContainer(
              widthScale: widthScale,
            )
          ],
        ));
  }
}

class LoginContainer extends StatelessWidget {
  final double widthScale;

  const LoginContainer({required this.widthScale, super.key});

  @override
  Widget build(BuildContext context) {
    final formWidth = MediaQuery.of(context).size.width * widthScale;

    return Center(
        child: Column(children: [
          SvgPicture.asset(
            'assets/bf_2042_white_logo.svg',
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.modulate,
            ),
            width: formWidth,
          ),
          Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              color: Theme.of(context).colorScheme.primary,
              width: formWidth,
              child: Text(
                '战绩查询助手',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 14,
                  letterSpacing: 10,
                ),
                textAlign: TextAlign.center,
              )),
          const Padding(padding: EdgeInsets.only(top: 10)),
          LoginForm(
            widthScale: widthScale,
          ),
        ]));
  }
}

class LoginForm extends StatefulWidget {
  final double widthScale;

  const LoginForm({required this.widthScale, super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController playerNameController = TextEditingController();
  final QueryHistory queryHistory = QueryHistory();
  String? platformName;
  String? playerName;
  String? playerUid;
  bool enablePlayerUidQuery = false;
  bool queryBtnLoading = false;
  FocusNode platformFocusNode = FocusNode();

  String get playerNameTextFieldLabel => enablePlayerUidQuery ? 'UID' : '玩家昵称';
  PlayerInfoAPI playerInfoAPI = PlayerInfoAPI();

  void platformTextFieldOnTap(BuildContext context) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
      context,
      ListView.builder(
        shrinkWrap: true,
        itemCount: Platform.values.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              Platform.values[index].label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              setState(() {
                platformName = Platform.values[index].value;
                platformController.text = Platform.values[index].label;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  void queryBtnOnPressed(BuildContext context) async {
    if (platformName == null ||
        playerName == null ||
        platformName!.isEmpty ||
        playerName!.isEmpty) {
      ErrorSnackBar.showErrorSnackBar(
          context, '游戏平台或玩家昵称不能为空!', widget.widthScale);
    } else {
      setState(() {
        queryBtnLoading = true;
      });
      playerInfoAPI
          .fetchPlayerInfo(
              platformName!.trim(),
              enablePlayerUidQuery ? '' : playerName!.trim(),
              enablePlayerUidQuery ? playerUid!.trim() : '',
              enablePlayerUidQuery)
          .then((response) {
        if (response.userName != null && response.userId != null) {
          queryHistory.setHistory(
            response.userName!,
            platformName!,
            response.userId.toString(),
          );
        }
        Provider.of<PlayerInfoModel>(context, listen: false)
            .updatePlayerInfo(response);
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const PlayerInfoScreen(),
          ),
        );
        setState(() {
          queryBtnLoading = false;
        });
      }).catchError((error) {
        setState(() {
          queryBtnLoading = false;
        });
        ErrorSnackBar.showErrorSnackBar(
            context, error.toString(), widget.widthScale);
      });
    }
  }

  void queryHistoryBtnOnPressed(BuildContext context) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
      context,
      queryHistory.playerUidHistory.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: queryHistory.playerUidHistory.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    queryHistory.playerNameHistory[index],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    queryHistory.playerUidHistory[index],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      platformName = queryHistory.playerPlatformHistory[index];
                      platformController.text =
                          queryHistory.playerPlatformHistory[index];
                      playerName = queryHistory.playerNameHistory[index];
                      playerUid = queryHistory.playerUidHistory[index];
                      playerNameController.text = enablePlayerUidQuery
                          ? queryHistory.playerUidHistory[index]
                          : queryHistory.playerNameHistory[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            )
          : Center(
              child: Text(
                '暂无查询历史',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  // load history when initState
  @override
  initState() {
    super.initState();
    queryHistory.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final formWidth = MediaQuery.of(context).size.width * widget.widthScale;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 54,
            width: formWidth,
            child: TextField(
              focusNode: platformFocusNode,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                labelText: '游戏平台',
                prefixIcon: Icon(Icons.gamepad,
                    color: Theme.of(context).colorScheme.primary),
                // if playerName is not null, show clear button
                suffixIcon: platformName != null
                    ? IconButton(
                        icon: Icon(Icons.clear,
                            color: Theme.of(context).colorScheme.primary),
                        onPressed: () {
                          setState(() {
                            platformName = null;
                            platformController.clear();
                            platformFocusNode.unfocus();
                          });
                        },
                      )
                    : null,
              ),
              controller: platformController,
              readOnly: true,
              onChanged: (String? value) {
                log(value.toString());
                setState(() {
                  platformName = value;
                });
              },
              onTap: () => {
                platformFocusNode.unfocus(),
                platformTextFieldOnTap(context)
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            width: formWidth,
            height: 54,
            child: TextField(
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                labelText: playerNameTextFieldLabel,
                prefixIcon: Icon(Icons.person,
                    color: Theme.of(context).colorScheme.primary),
                // if playerName is not null, show clear button
                suffixIcon: playerName != null
                    ? IconButton(
                  icon: Icon(Icons.clear,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    setState(() {
                      playerName = null;
                      playerNameController.clear();
                    });
                  },
                )
                    : null,
              ),
              controller: playerNameController,
              onChanged: (String? value) {
                setState(() {
                  playerName = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          // submit button
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: formWidth,
              height: 48,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    disabledBackgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  onPressed:
                      queryBtnLoading ? null : () => queryBtnOnPressed(context),
                  child: queryBtnLoading
                      ? SpinKitCubeGrid(
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.search),
                            Padding(padding: EdgeInsets.only(left: 8)),
                      Text('查询', style: TextStyle(fontSize: 16)),
                    ],
                  )),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            height: 48,
            width: formWidth,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: enablePlayerUidQuery,
                          onChanged: (value) {
                            setState(() {
                              enablePlayerUidQuery = value!;
                              platformName = null;
                              platformController.clear();
                              playerName = null;
                              playerNameController.clear();
                            });
                          }),
                      const Text('启用增强查询',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                    ],
                  ),
                  TextButton(
                      onPressed: () => queryHistoryBtnOnPressed(context),
                      child: const Text('查询历史',
                          style: TextStyle(
                            fontSize: 14,
                          )))
                ]),
          )
        ],
      ),
    );
  }
}
