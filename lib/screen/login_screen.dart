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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/player_info_model.dart';

enum Platform {
  pc('PC', 'pc', FaIcon(FontAwesomeIcons.windows)),
  psn('PlayStation (PSN)', 'psn', FaIcon(FontAwesomeIcons.playstation)),
  xboxseries('XBOX SERIES X/S', 'xboxseries', FaIcon(FontAwesomeIcons.xbox));

  const Platform(this.label, this.value, [this.icon]);

  final String label;
  final String value;
  final FaIcon? icon;
}

class LoginScreen extends StatelessWidget {
  final double loginScreenWidthScale;
  final double playerInfoCardWidthScale;

  const LoginScreen(
      {required this.loginScreenWidthScale,
      required this.playerInfoCardWidthScale,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoginContainer(
          loginScreenWidthScale: loginScreenWidthScale,
          playerInfoCardWidthScale: playerInfoCardWidthScale,
        )
      ],
    ));
  }
}

class LoginContainer extends StatelessWidget {
  final double loginScreenWidthScale;
  final double playerInfoCardWidthScale;

  const LoginContainer(
      {required this.loginScreenWidthScale,
      required this.playerInfoCardWidthScale,
      super.key});

  @override
  Widget build(BuildContext context) {
    final formWidth = MediaQuery.of(context).size.width * loginScreenWidthScale;

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
              fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
              fontWeight: Theme.of(context).textTheme.labelLarge?.fontWeight,
              letterSpacing: 10,
            ),
            textAlign: TextAlign.center,
          )),
      const Padding(padding: EdgeInsets.only(top: 16)),
      LoginForm(
        loginScreenWidthScale: loginScreenWidthScale,
        playerInfoCardWidthScale: playerInfoCardWidthScale,
      ),
    ]));
  }
}

class LoginForm extends StatefulWidget {
  final double loginScreenWidthScale;
  final double playerInfoCardWidthScale;

  const LoginForm(
      {required this.loginScreenWidthScale,
      required this.playerInfoCardWidthScale,
      super.key});

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
  FocusNode playerNameFocusNode = FocusNode();

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
            leading: Platform.values[index].icon,
            title: Text(
              Platform.values[index].label,
              style: Theme.of(context).textTheme.titleMedium,
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

  void queryBtnOnPressed(
    BuildContext context,
    double playerInfoCardWidthScale,
  ) async {
    platformFocusNode.unfocus();
    playerNameFocusNode.unfocus();
    if (platformName == null ||
        playerName == null ||
        platformName!.isEmpty ||
        playerName!.isEmpty) {
      ErrorSnackBar.showErrorSnackBar(
          context, '游戏平台或玩家昵称不能为空!', widget.loginScreenWidthScale);
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
            builder: (context) => PlayerInfoScreen(
              playerInfoCardWidthScale: playerInfoCardWidthScale,
            ),
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
            context, error.toString(), widget.loginScreenWidthScale);
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    queryHistory.playerUidHistory[index],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  onTap: () {
                    setState(() {
                      platformName = queryHistory.playerPlatformHistory[index];
                      // set platformName to platformController, by platform value index platform label
                      platformController.text = Platform.values
                          .firstWhere((element) =>
                              element.value ==
                              queryHistory.playerPlatformHistory[index])
                          .label;
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
                style: Theme.of(context).textTheme.titleMedium,
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
    final formWidth =
        MediaQuery.of(context).size.width * widget.loginScreenWidthScale;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: formWidth,
            child: TextField(
              focusNode: platformFocusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                labelText: '游戏平台',
                prefixIcon: const Icon(Icons.gamepad),
                // if playerName is not null, show clear button
                suffixIcon: platformName != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
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
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                labelText: playerNameTextFieldLabel,
                prefixIcon: const Icon(Icons.person),
                // if playerName is not null, show clear button
                suffixIcon: playerName != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
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
              focusNode: playerNameFocusNode,
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
                  onPressed: queryBtnLoading
                      ? null
                      : () => queryBtnOnPressed(
                          context, widget.playerInfoCardWidthScale),
                  child: queryBtnLoading
                      ? SpinKitCubeGrid(
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.search),
                            const Padding(padding: EdgeInsets.only(left: 8)),
                            Text('查询',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontSize,
                                  fontWeight: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontWeight,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                          ],
                        )),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
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
                            platformFocusNode.unfocus();
                            playerNameFocusNode.unfocus();
                            setState(() {
                              enablePlayerUidQuery = value!;
                              platformName = null;
                              platformController.clear();
                              playerName = null;
                              playerNameController.clear();
                            });
                          }),
                      Text('增强查询',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                  TextButton(
                      onPressed: () => queryHistoryBtnOnPressed(context),
                      child: Text('查询历史',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.fontWeight,
                            color: Theme.of(context).colorScheme.primary,
                          )))
                ]),
          )
        ],
      ),
    );
  }
}
