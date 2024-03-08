import 'package:battlefield_2042_state/components/basic/constraints_modal_bottom_sheet.dart';
import 'package:battlefield_2042_state/components/main_framework/development_info.dart';
import 'package:battlefield_2042_state/components/main_framework/notice_board_bottom_sheet.dart';
import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/screen/login_screen.dart';
import 'package:battlefield_2042_state/theme/color_schemes.g.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

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
            IconButton(
              onPressed: () =>
                  ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
                      context, const NoticeBoardBottomSheet()),
              icon: const Icon(Icons.announcement_outlined),
            ),
            Container(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () =>
                    ConstraintsModalBottomSheet.showConstraintsModalBottomSheet(
                        context, const BottomSheetInfo()),
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
