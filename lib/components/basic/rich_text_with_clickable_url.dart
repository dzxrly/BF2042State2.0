import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkableString {
  String content;
  bool isUrl;
  String? label;

  MarkableString(this.content, this.isUrl, {this.label});
}

class RichTextWithClickableURL extends StatelessWidget {
  final String originText;

  const RichTextWithClickableURL(this.originText, {super.key});

  List<MarkableString> parseString(String input) {
    List<MarkableString> result = [];

    RegExp urlRegExp = RegExp(r"<url label='(.*?)'>(.*?)<\/url>");

    while (input.isNotEmpty) {
      RegExpMatch? urlMatch = urlRegExp.firstMatch(input);

      if (urlMatch != null) {
        String urlLabel = urlMatch.group(1)!;
        String url = urlMatch.group(2)!;

        if (urlMatch.start > 0) {
          result.add(MarkableString(input.substring(0, urlMatch.start), false));
        }

        result.add(MarkableString(url, true, label: urlLabel));
        input = input.substring(urlMatch.end);
      } else {
        result.add(MarkableString(input, false));
        input = '';
      }
    }

    return result;
  }

  Future<void> urlLauncher(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
            children: parseString(originText).map((e) {
          if (e.isUrl) {
            return TextSpan(
                text: e.label ?? e.content,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    urlLauncher(e.content).catchError((error) {
                      log('Error: $error');
                    });
                  });
          } else {
            return TextSpan(
                text: e.content, style: Theme.of(context).textTheme.bodyMedium);
          }
        }).toList()));
  }
}
