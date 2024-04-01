import 'package:battlefield_2042_state/api/api.dart';
import 'package:battlefield_2042_state/api/gitee/notice_board.dart';
import 'package:battlefield_2042_state/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NoticeBoardBottomSheet extends StatefulWidget {
  const NoticeBoardBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _NoticeBoardBottomSheet();
}

class _NoticeBoardBottomSheet extends State<NoticeBoardBottomSheet> {
  GiteeIssues? _giteeIssues;
  int loadingStatus = 0; // 0: loading, 1: loaded, 2: error
  final GiteeNoticeBoardCheck _giteeNoticeBoardCheck = GiteeNoticeBoardCheck();

  void _getGiteeIssues() async {
    loadingStatus = 0;
    GiteeIssues giteeIssues = await _giteeNoticeBoardCheck.fetchNotice();
    if (mounted) {
      setState(() {
        _giteeIssues = giteeIssues;
        if (_giteeIssues != null) {
          loadingStatus = 1;
        } else {
          loadingStatus = 2;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getGiteeIssues();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.announcementBottomSheetTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Padding(padding: EdgeInsets.only(top: 16)),
          if (loadingStatus == 0)
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitCubeGrid(
                  color: Theme.of(context).colorScheme.primary,
                  size: Theme.of(context).textTheme.titleMedium!.fontSize!,
                ),
                const Padding(padding: EdgeInsets.only(top: 4)),
                Text(AppLocalizations.of(context)!
                    .announcementBottomSheetFetchLoading)
              ],
            )
          else if (loadingStatus == 2)
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Theme.of(context).colorScheme.error,
                  size: Theme.of(context).textTheme.titleMedium!.fontSize,
                ),
                const Padding(padding: EdgeInsets.only(top: 4)),
                Text(AppLocalizations.of(context)!
                    .announcementBottomSheetFetchError)
              ],
            )
          else
            NoticeList(giteeIssues: _giteeIssues),
        ],
      ),
    );
  }
}

class NoticeList extends StatelessWidget {
  final GiteeIssues? giteeIssues;

  const NoticeList({super.key, required this.giteeIssues});

  @override
  Widget build(BuildContext context) {
    if (giteeIssues == null ||
        giteeIssues!.commits == null ||
        giteeIssues!.commits!.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: Theme.of(context).textTheme.titleMedium!.fontSize,
          ),
          const Padding(padding: EdgeInsets.only(top: 4)),
          Text(AppLocalizations.of(context)!.announcementBottomSheetNone)
        ],
      );
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: giteeIssues!.commits!.length,
              itemBuilder: (context, index) {
                return NoticeListItem(
                  updatedAt: giteeIssues!.commits![index].updatedAt!,
                  body: giteeIssues!.commits![index].body!,
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            TextButton(
              onPressed: () => UtilTools.urlLauncher(
                  'https://gitee.com/egg-targaryen/BF2042State2.0/issues/I96FFR'),
              child: Text(
                AppLocalizations.of(context)!.announcementBottomSheetMore,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                ),
              ),
            )
          ]);
    }
  }
}

class NoticeListItem extends StatelessWidget {
  final String updatedAt;
  final String body;

  const NoticeListItem(
      {super.key, required this.updatedAt, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Badge(
                  label: Text(
                    AppLocalizations.of(context)!
                        .announcementBottomSheetItemUpdatedAt(
                      DateTime.parse(updatedAt).toLocal(),
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  textStyle: Theme.of(context).textTheme.labelSmall,
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 2)),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
          ],
        ));
  }
}
