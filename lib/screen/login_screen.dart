import 'package:battlefield_2042_state/api/api.dart';
import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/basic/custom_snackbar.dart';
import 'package:battlefield_2042_state/components/update_bottom_modal_sheet.dart';
import 'package:battlefield_2042_state/model/player_info_ensemble.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/model/query_history.dart';
import 'package:battlefield_2042_state/screen/player_info_screen.dart';
import 'package:battlefield_2042_state/utils/lang.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

enum GamePlatform {
  pc('PC', 'pc', FaIcon(FontAwesomeIcons.windows)),
  psn('PlayStation (PSN)', 'psn', FaIcon(FontAwesomeIcons.playstation)),
  xboxseries('XBOX SERIES X/S', 'xboxseries', FaIcon(FontAwesomeIcons.xbox));

  const GamePlatform(this.label, this.value, this.icon);

  final String label;
  final String value;
  final FaIcon icon;
}

enum QueryAPI {
  gametools('GAMETOOLS', 'gametools', true, true),
  gametoolsRaw('GAMETOOLS RAW', 'gametoolsraw', true, true),
  bftracker('BFTRACKER', 'bftracker', false, false);

  const QueryAPI(this.label, this.value, this.enableUse, this.enableUID);

  final String label;
  final String value;
  final bool enableUse;
  final bool enableUID;
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
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginContainer(
                loginScreenWidthScale: loginScreenWidthScale,
                playerInfoCardWidthScale: playerInfoCardWidthScale,
              ),
            ],
          ),
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
            AppLocalizations.of(context)!.loginScreenLogoTitle,
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
  final TextEditingController queryAPIController = TextEditingController();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController playerNameController = TextEditingController();
  final QueryHistory queryHistory = QueryHistory();
  String queryAPIName = 'gametools';
  bool allowUIDQuery = true;
  String? platformName;
  String? playerName;
  String? playerUid;
  bool enablePlayerUidQuery = false;
  bool queryBtnLoading = false;
  FocusNode queryAPIFocusNode = FocusNode();
  FocusNode platformFocusNode = FocusNode();
  FocusNode playerNameFocusNode = FocusNode();

  GametoolsPlayerInfoAPI gametoolsPlayerInfoAPI = GametoolsPlayerInfoAPI();
  GametoolsPlayerInfoRawAPI gametoolsPlayerInfoRawAPI =
      GametoolsPlayerInfoRawAPI();
  BFTrackerPlayerInfoAPIMain bfTrackerPlayerInfoAPIMain =
      BFTrackerPlayerInfoAPIMain();
  BFTrackerPlayerInfoAPIWeapon bfTrackerPlayerInfoAPIWeapon =
      BFTrackerPlayerInfoAPIWeapon();
  BFTrackerPlayerInfoAPIVehicle bfTrackerPlayerInfoAPIVehicle =
      BFTrackerPlayerInfoAPIVehicle();
  BFTrackerPlayerInfoAPISoldier bfTrackerPlayerInfoAPISoldier =
      BFTrackerPlayerInfoAPISoldier();
  BFTrackerPlayerInfoAPIMap bfTrackerPlayerInfoAPIMap =
      BFTrackerPlayerInfoAPIMap();
  BFTrackerPlayerInfoAPIGadgets bfTrackerPlayerInfoAPIGadgets =
      BFTrackerPlayerInfoAPIGadgets();

  void platformTextFieldOnTap(BuildContext context) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
      context,
      ListView.builder(
        shrinkWrap: true,
        itemCount: GamePlatform.values.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: GamePlatform.values[index].icon,
            title: Text(
              GamePlatform.values[index].label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            tileColor: platformName == GamePlatform.values[index].value
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            onTap: () {
              setState(() {
                platformName = GamePlatform.values[index].value;
                platformController.text = GamePlatform.values[index].label;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  void queryAPIOnTap(BuildContext context) {
    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
      context,
      ListView.builder(
        shrinkWrap: true,
        itemCount: QueryAPI.values.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              QueryAPI.values[index].label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              Translator.appLocalizationsTranslate(
                  AppLocalizations.of(context)!.dataAPIDescription(
                    QueryAPI.values[index].value,
                  ),
                  QueryAPI.values[index].value),
            ),
            tileColor: queryAPIName == QueryAPI.values[index].value
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            onTap: () {
              if (QueryAPI.values[index].enableUse) {
                setState(() {
                  queryAPIName = QueryAPI.values[index].value;
                  queryAPIController.text = QueryAPI.values[index].label;
                  platformFocusNode.unfocus();
                  playerNameFocusNode.unfocus();
                  platformName = null;
                  platformController.clear();
                  playerName = null;
                  playerNameController.clear();
                  playerUid = null;
                  enablePlayerUidQuery = false;
                  allowUIDQuery = QueryAPI.values[index].enableUID;
                });
                Navigator.pop(context);
              } else {
                CustomSnackBar.showSnackBar(
                  context,
                  AppLocalizations.of(context)!.dataAPINotOpenErrorTip,
                ).show(context);
              }
            },
          );
        },
      ),
    );
  }

  void queryByGametoolsAPI(
    BuildContext context,
  ) async {
    gametoolsPlayerInfoAPI
        .fetchPlayerInfo(
            platformName!.trim(),
            enablePlayerUidQuery ? '' : playerName!.trim(),
            enablePlayerUidQuery ? playerUid!.trim() : '',
            enablePlayerUidQuery)
        .then((response) {
      if (response.userName != null &&
          response.userId != null &&
          response.userName != '' &&
          response.userId != 0 &&
          response.secondsPlayed != null &&
          response.secondsPlayed != 0) {
        queryHistory
            .insertQueryHistory(QueryHistoryInterface(
              name: response.userName!,
              platform: platformName!,
              uid: response.userId.toString(),
            ))
            .then((value) => {
                  Provider.of<PlayerInfoModel>(context, listen: false)
                      .updatePlayerInfo(
                          PlayerInfoEnsemble.gametoolsAPI(response),
                      GamePlatform.values
                              .firstWhere(
                                  (element) => element.value == platformName)
                              .icon
                              .icon,
                          platformName),
                  setState(() {
                    platformFocusNode.unfocus();
                    playerNameFocusNode.unfocus();
                    platformName = null;
                    platformController.clear();
                    playerName = null;
                    playerNameController.clear();
                    playerUid = null;
                  }),
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PlayerInfoScreen(),
                    ),
                  )
                })
            .catchError((error) {
          CustomSnackBar.showSnackBar(
            context,
            '${AppLocalizations.of(context)!.writeCacheErrorTip}: $error',
          ).show(context);
        });
      } else {
        throw AppLocalizations.of(context)!
            .requestErrorTip(ErrorResponse.notPlay2042.value);
      }
      setState(() {
        queryBtnLoading = false;
      });
    }).catchError((error) {
      setState(() {
        queryBtnLoading = false;
      });
      CustomSnackBar.showSnackBar(
        context,
        Translator.appLocalizationsTranslate(
            AppLocalizations.of(context)!.requestErrorTip(error.toString()),
            error.toString()),
      ).show(context);
    });
  }

  void queryByGametoolsRawAPI(
    BuildContext context,
  ) async {
    gametoolsPlayerInfoRawAPI
        .fetchPlayerInfo(
            platformName!.trim(),
            enablePlayerUidQuery ? '' : playerName!.trim(),
            enablePlayerUidQuery ? playerUid!.trim() : '',
            enablePlayerUidQuery)
        .then((response) {
      if (response.result?.inventory?.loadouts?.first.name != null &&
          response.result?.inventory?.loadouts?.first.name != '' &&
          response.result?.inventory?.loadouts?.first.level != null &&
          response.result?.inventory?.loadouts?.first.level != 0 &&
          response.result?.inventory?.loadouts?.first.player?.nucleusId !=
              null &&
          response.result?.inventory?.loadouts?.first.player?.nucleusId != 0) {
        queryHistory
            .insertQueryHistory(QueryHistoryInterface(
              name: response.result?.inventory?.loadouts?.first.name ?? 'null',
              platform: platformName!,
              uid: response.result?.inventory?.loadouts?.first.player?.nucleusId
                      .toString() ??
                  'null',
            ))
            .then((value) => {
                  Provider.of<PlayerInfoModel>(context, listen: false)
                      .updatePlayerInfo(
                          PlayerInfoEnsemble.gametoolsRawAPI(response),
                          GamePlatform.values
                              .firstWhere(
                                  (element) => element.value == platformName)
                              .icon
                              .icon,
                          platformName),
                  setState(() {
                    platformFocusNode.unfocus();
                    playerNameFocusNode.unfocus();
                    platformName = null;
                    platformController.clear();
                    playerName = null;
                    playerNameController.clear();
                    playerUid = null;
                  }),
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PlayerInfoScreen(),
                    ),
                  )
                })
            .catchError((error) {
          CustomSnackBar.showSnackBar(
            context,
            '${AppLocalizations.of(context)!.writeCacheErrorTip}: $error',
          ).show(context);
        });
      } else {
        throw AppLocalizations.of(context)!
            .requestErrorTip(ErrorResponse.notPlay2042.value);
      }
      setState(() {
        queryBtnLoading = false;
      });
    }).catchError((error) {
      setState(() {
        queryBtnLoading = false;
      });
      CustomSnackBar.showSnackBar(
        context,
        Translator.appLocalizationsTranslate(
            AppLocalizations.of(context)!.requestErrorTip(error.toString()),
            error.toString()),
      ).show(context);
    });
  }

  void queryBFTrackerAPI(
    BuildContext context,
  ) async {
    String bftrackerPlatform = 'origin';
    if (platformName == 'pc') {
      bftrackerPlatform = 'origin';
    } else if (platformName == 'psn') {
      bftrackerPlatform = 'psn';
    } else if (platformName == 'xboxseries') {
      bftrackerPlatform = 'xbl';
    } else {
      throw AppLocalizations.of(context)!.platformUnknownErrorTip;
    }
    bfTrackerPlayerInfoAPIMain
        .fetchPlayerInfo(bftrackerPlatform, playerName!.trim())
        .then((response) {
      if (response.data != null) {
        if (response.data?.platformInfo?.platformUserId != null &&
            response.data?.platformInfo?.platformUserId != '') {
          // TODO

          setState(() {
            platformFocusNode.unfocus();
            playerNameFocusNode.unfocus();
            platformName = null;
            platformController.clear();
            playerName = null;
            playerNameController.clear();
            playerUid = null;
          });
        } else {
          throw AppLocalizations.of(context)!
              .requestErrorTip(ErrorResponse.notPlay2042.value);
        }
      } else {
        throw AppLocalizations.of(context)!
            .requestErrorTip(ErrorResponse.privateLimitError.value);
      }
      setState(() {
        queryBtnLoading = false;
      });
    }).catchError((error) {
      setState(() {
        queryBtnLoading = false;
      });
      CustomSnackBar.showSnackBar(
        context,
        Translator.appLocalizationsTranslate(
            AppLocalizations.of(context)!.requestErrorTip(error.toString()),
            error.toString()),
      ).show(context);
    });
  }

  void queryBtnOnPressed(
    BuildContext context,
    double playerInfoCardWidthScale,
  ) async {
    platformFocusNode.unfocus();
    playerNameFocusNode.unfocus();
    if (platformName == null ||
        (enablePlayerUidQuery && playerUid == null) ||
        (!enablePlayerUidQuery && playerName == null)) {
      CustomSnackBar.showSnackBar(
        context,
        enablePlayerUidQuery
            ? AppLocalizations.of(context)!.playerUIDTextFieldNotNone
            : AppLocalizations.of(context)!.playerNameTextFieldNotNone,
      ).show(context);
    } else {
      setState(() {
        queryBtnLoading = true;
      });
      if (queryAPIName == 'gametools') {
        queryByGametoolsAPI(context);
      } else if (queryAPIName == 'gametoolsraw') {
        queryByGametoolsRawAPI(context);
      } else if (queryAPIName == 'bftracker') {
        queryBFTrackerAPI(context);
      } else {
        throw AppLocalizations.of(context)!.dataAPIUnknownErrorTip;
      }
    }
  }

  void queryHistoryBtnOnPressed(BuildContext context) {
    queryHistory
        .queryAllQueryHistory()
        .then((value) => {
              ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
                context,
                value.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                        itemCount: value.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              key: Key(value[index].uid),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                queryHistory
                                    .deleteQueryHistory(value[index].uid);
                                // close modal bottom sheet
                                Navigator.pop(context);
                              },
                              background: Container(
                                color: Theme.of(context).colorScheme.error,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(right: 16)),
                                    Icon(Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError),
                                    const Padding(
                                        padding: EdgeInsets.only(right: 16)),
                                  ],
                                ),
                              ),
                              child: ListTile(
                                // set leading icon to platform icon
                                leading: GamePlatform.values
                                    .firstWhere((element) =>
                                        element.value == value[index].platform)
                                    .icon,
                                title: Text(
                                  value[index].name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Text(
                                  value[index].uid,
                                ),
                                tileColor: playerUid == value[index].uid
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(19),
                                ),
                                onTap: () {
                                  setState(() {
                                    platformName = value[index].platform;
                                    // set platformName to platformController, by platform value index platform label
                                    platformController.text = GamePlatform
                                        .values
                                        .firstWhere((element) =>
                                            element.value ==
                                            value[index].platform)
                                        .label;
                                    playerName = value[index].name;
                                    playerUid = value[index].uid;
                                    playerNameController.text =
                                        enablePlayerUidQuery
                                            ? value[index].uid
                                            : value[index].name;
                                  });
                                  Navigator.pop(context);
                                },
                              ));
                        },
                      )
                    : Center(
                        child: Text(
                          AppLocalizations.of(context)!.searchHistoryIsNone,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
              )
            })
        .catchError((error) {
      CustomSnackBar.showSnackBar(context, error.toString()).show(context);
    });
  }

  void checkInputPlayerNameIsInHistory(String? userInput) async {
    // check input playerName is in history, if not, set playerUID to null,
    // if in, do nothing
    if (await queryHistory.isNameExist(userInput ?? '')) {
    } else {
      setState(() {
        playerUid = null;
      });
    }
  }

  // load history when initState
  @override
  initState() {
    queryAPIController.text = QueryAPI.gametools.label;
    super.initState();
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
              focusNode: queryAPIFocusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                labelText:
                    AppLocalizations.of(context)!.queryAPITextFieldPlaceholder,
                prefixIcon: const Icon(Icons.api),
              ),
              controller: queryAPIController,
              readOnly: true,
              onChanged: (String value) {
                setState(() {
                  queryAPIName = value;
                });
              },
              onTap: () => {
                if (!queryBtnLoading)
                  {
                    queryAPIFocusNode.unfocus(),
                    queryAPIOnTap(context),
                  }
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          SizedBox(
            width: formWidth,
            child: TextField(
              focusNode: platformFocusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                labelText:
                    AppLocalizations.of(context)!.platformTextFieldPlaceholder,
                prefixIcon: const Icon(Icons.gamepad),
                // if playerName is not null, show clear button
                suffixIcon: platformName != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: queryBtnLoading
                            ? null
                            : () {
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
                setState(() {
                  platformName = value;
                });
              },
              onTap: () => {
                if (!queryBtnLoading)
                  {platformFocusNode.unfocus(), platformTextFieldOnTap(context)}
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
                labelText: enablePlayerUidQuery
                    ? AppLocalizations.of(context)!
                        .playerUIDTextFieldPlaceholder
                    : AppLocalizations.of(context)!
                        .playerNameTextFieldPlaceholder,
                prefixIcon: const Icon(Icons.person),
                // if playerName is not null, show clear button
                suffixIcon: enablePlayerUidQuery
                    ? playerUid != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: queryBtnLoading
                                ? null
                                : () {
                                    setState(() {
                                      playerName = null;
                                      playerNameController.clear();
                                      playerNameFocusNode.unfocus();
                                      playerUid = null;
                                    });
                                  },
                          )
                        : null
                    : playerName != null
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                  onPressed: queryBtnLoading
                                ? null
                                : () {
                                    setState(() {
                                      playerName = null;
                                      playerNameController.clear();
                                      playerNameFocusNode.unfocus();
                                      playerUid = null;
                                    });
                                  },
                          )
                        : null,
              ),
              textInputAction: TextInputAction.search,
              controller: playerNameController,
              focusNode: playerNameFocusNode,
              readOnly: queryBtnLoading,
              onChanged: (String? value) {
                setState(() {
                  if (enablePlayerUidQuery) {
                    playerUid = value;
                  } else {
                    checkInputPlayerNameIsInHistory(value);
                    playerName = value;
                  }
                });
              },
              onEditingComplete: () =>
                  queryBtnOnPressed(context, widget.playerInfoCardWidthScale),
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
                            Text(
                                AppLocalizations.of(context)!.searchButtonTitle,
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
                          onChanged: queryBtnLoading || !allowUIDQuery
                              ? null
                              : (value) {
                                  platformFocusNode.unfocus();
                                  playerNameFocusNode.unfocus();
                                  setState(() {
                                    enablePlayerUidQuery = value!;
                                    platformName = null;
                                    platformController.clear();
                                    playerName = null;
                                    playerNameController.clear();
                                    playerUid = null;
                                  });
                                }),
                      Text(
                          AppLocalizations.of(context)!
                              .enhancedSearchButtonTitle,
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                  TextButton(
                      onPressed: queryBtnLoading
                          ? null
                          : () => queryHistoryBtnOnPressed(context),
                      child:
                          Text(AppLocalizations.of(context)!.searchResultsTitle,
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
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          const UpdateBottomModalSheet()
        ],
      ),
    );
  }
}
