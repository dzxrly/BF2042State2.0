import 'package:battlefield_2042_state/components/basic/rich_text_with_clickable_url.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    if (mounted) {
      setState(() {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
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
              Text('by Egg Targaryen (EA ID: x_Reshiram)',
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
                    UtilTools.urlLauncher(
                        'https://github.com/dzxrly/BF2042State2.0');
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
                    UtilTools.urlLauncher('https://ko-fi.com/F1F0PZH7X');
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
                onPressed: () => UtilTools.urlLauncher(
                    'https://github.com/dzxrly/BF2042State2.0/blob/main/privacy.md'),
                child: Text(
                  AppLocalizations.of(context)!.privacyBtnTitle,
                ),
              ),
              TextButton(
                onPressed: () => UtilTools.urlLauncher(
                    'https://github.com/dzxrly/BF2042State2.0?tab=MIT-1-ov-file#readme'),
                child: Text(
                  AppLocalizations.of(context)!.licenseBtnTitle,
                ),
              ),
              TextButton(
                onPressed: () => UtilTools.urlLauncher(
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
