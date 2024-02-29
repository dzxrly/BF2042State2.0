import 'package:battlefield_2042_state/components/login_screen/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
