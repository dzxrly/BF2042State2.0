import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/basic/rich_text_with_clickable_url.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/screen/login_screen.dart';
import 'package:battlefield_2042_state/theme/color_schemes.g.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (PlatformUtils.isWeb) {
    await Hive.initFlutter();
    await Hive.openBox('queryHistoryHiveBox');
  }

  runApp(ChangeNotifierProvider(
    create: (context) => PlayerInfoModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BF2042State',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: lightColorScheme,
        // fontFamily: 'HarmonyOS_Sans_SC',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        // fontFamily: 'HarmonyOS_Sans_SC',
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  );

  void transparentSystemUi() {
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void forcePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      transparentSystemUi();
      forcePortrait();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transparentSystemUi();
    forcePortrait();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {
                  ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
                      context, const BottomSheetInfo());
                },
                icon: const Icon(Icons.menu),
              ),
            )
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < WidthBreakpoints.minS) {
            return const LoginScreen(
              loginScreenWidthScale: 0.85,
              playerInfoCardWidthScale: 0.95,
            );
          } else if (constraints.maxWidth < WidthBreakpoints.minM) {
            return const LoginScreen(
                loginScreenWidthScale: 0.6, playerInfoCardWidthScale: 0.6);
          } else if (constraints.maxWidth < WidthBreakpoints.minL) {
            return const LoginScreen(
                loginScreenWidthScale: 0.4, playerInfoCardWidthScale: 0.4);
          } else if (constraints.maxWidth < WidthBreakpoints.minXL) {
            return const LoginScreen(
                loginScreenWidthScale: 0.3, playerInfoCardWidthScale: 0.3);
          } else {
            return const LoginScreen(
                loginScreenWidthScale: 0.2, playerInfoCardWidthScale: 0.2);
          }
        }));
  }
}

class BottomSheetInfo extends StatefulWidget {
  const BottomSheetInfo({super.key});

  @override
  State<StatefulWidget> createState() => _BottomSheetInfoState();
}

class _BottomSheetInfoState extends State<BottomSheetInfo> {
  late String version = 'null';
  late String buildNumber = '-1';

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> urlLauncher(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception(url);
    }
  }

  @override
  void initState() {
    getVersion();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.aboutPageTitle,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Ver.$version-$buildNumber',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.bodySmall?.fontWeight,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              const Padding(padding: EdgeInsets.all(4)),
              Text('by Egg Targaryen | EA ID: x_Reshiram',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.bodySmall?.fontWeight,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    urlLauncher('https://github.com/dzxrly/BF2042State2.0');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.github,
                        size: 14,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 4)),
                      Text('Github',
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodySmall?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontWeight,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    urlLauncher('https://ko-fi.com/F1F0PZH7X');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.mugHot,
                        size: 14,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 4)),
                      Text(
                          AppLocalizations.of(context)!.aboutPageDonateBtnTitle,
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodySmall?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.fontWeight,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    ],
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          RichTextWithClickableURL(
            AppLocalizations.of(context)!.aboutPageContent,
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => urlLauncher(
                    'https://github.com/dzxrly/BF2042State2.0/blob/main/privacy.md'),
                child: Text(
                  AppLocalizations.of(context)!.privacyBtnTitle,
                ),
              ),
              TextButton(
                onPressed: () => urlLauncher(
                    'https://github.com/dzxrly/BF2042State2.0?tab=MIT-1-ov-file#readme'),
                child: Text(
                  AppLocalizations.of(context)!.licenseBtnTitle,
                ),
              ),
              TextButton(
                onPressed: () => urlLauncher(
                    'https://github.com/dzxrly/BF2042State2.0/blob/main/README.md#faq'),
                child: Text(
                  AppLocalizations.of(context)!.qnaBtnTitle,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
