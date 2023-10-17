import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Platform {
  pc('PC', 'pc'),
  psn('PlayStation', 'psn'),
  xboxone('XBOX ONE', 'xboxone'),
  xboxseries('XBOX SERIES X/S', 'xboxseries');

  const Platform(this.label, this.value, [this.icon]);

  final String label;
  final String value;
  final Icon? icon;
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [LoginContainer()],
    ));
  }
}

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      SvgPicture.asset(
        'assets/bf_2042_white_logo.svg',
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.modulate,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
      ),
      Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          color: Theme.of(context).colorScheme.primary,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            '战绩查询助手',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          )),
      const Padding(padding: EdgeInsets.only(top: 16)),
      const LoginForm()
    ]));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController playerNameController = TextEditingController();
  String? platformName;
  String? playerName;
  String? playerUid;
  bool enablePlayerUidQuery = false;

  String get playerNameTextFieldLabel => enablePlayerUidQuery ? 'UID' : '玩家昵称';

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Platform>> platformItems = Platform.values
        .map((Platform platform) => DropdownMenuEntry<Platform>(
              value: platform,
              label: platform.label,
            ))
        .toList();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownMenu<Platform>(
            width: MediaQuery.of(context).size.width * 0.8,
            controller: platformController,
            label: const Text('游戏平台'),
            dropdownMenuEntries: platformItems,
            leadingIcon: Icon(Icons.gamepad,
                color: Theme.of(context).colorScheme.primary),
            inputDecorationTheme: InputDecorationTheme(
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
            ),
            onSelected: (Platform? platform) {
              setState(() {
                platformName = platform?.value;
              });
            },
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 60,
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
          const Padding(padding: EdgeInsets.only(top: 16)),
          // submit button
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  if (platformName == null ||
                      playerName == null ||
                      platformName!.isEmpty ||
                      playerName!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 8)),
                            const Text('游戏平台或玩家昵称不能为空',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(19)),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    );
                  } else {
                    // TODO: submit
                    // print platformName and playerName to console
                    log('platformName: $platformName, playerName: $playerName');
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                    Padding(padding: EdgeInsets.only(left: 8)),
                    Text('查询', style: TextStyle(fontSize: 16)),
                  ],
                )),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: enablePlayerUidQuery,
                      onChanged: (bool value) {
                        setState(() {
                          enablePlayerUidQuery = value;
                          platformName = null;
                          platformController.clear();
                          playerName = null;
                          playerNameController.clear();
                        });
                      }),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  const Text('启用增强查询',
                      style: TextStyle(
                        fontSize: 14,
                      ))
                ]),
          )
        ],
      ),
    );
  }
}
