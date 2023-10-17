import 'package:battlefield_2042_state/model/player_info_model.dart';
import 'package:battlefield_2042_state/screen/login_screen.dart';
import 'package:battlefield_2042_state/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        fontFamily: 'HarmonyOS_Sans_SC',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        fontFamily: 'HarmonyOS_Sans_SC',
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final double widthScale = 0.85;

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const BottomSheetInfo();
                  });
            },
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: LoginScreen(
        widthScale: widthScale,
      ),
    );
  }
}

class BottomSheetInfo extends StatelessWidget {
  const BottomSheetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('战地2042战绩查询助手',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
