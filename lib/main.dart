import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/screen/login_screen.dart';
import 'package:battlefield_2042_state/theme/color_schemes.g.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
                    context, const BottomSheetInfo());
              },
              icon: const Icon(Icons.menu),
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
      throw Exception('错误! 无法打开: $url');
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
          Text('战地2042战绩查询助手',
              style: Theme.of(context).textTheme.headlineSmall),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Row(
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
              const Padding(padding: EdgeInsets.only(left: 8)),
              Text('by Egg Targaryen',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight:
                        Theme.of(context).textTheme.bodySmall?.fontWeight,
                    color: Theme.of(context).colorScheme.primary,
                  )),
            ],
          ),
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
                        fontWeight:
                            Theme.of(context).textTheme.bodySmall?.fontWeight,
                        color: Theme.of(context).colorScheme.primary,
                      )),
                ],
              )),
          const Divider(),
          Text(
            '本应用由 Egg Targaryen 开发 (橘子: Xx__Koraidon__xX)。'
            '玩家数据接口来自 gametools.network，非常感谢其提供的接口。'
            'BFBan数据来自 bfban.com，结果仅供参考，'
            '本应用及作者不对该结果负责，如有疑问请自行联系BFBan。',
            softWrap: true,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
