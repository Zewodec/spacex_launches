import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spacex_launches/core/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(
      {super.key,
      required this.missionDate,
      required this.missionTime,
      required this.missionTitle,
      required this.missionDescription,
      required this.youtubeID});

  final String missionDate;
  final String missionTime;
  final String missionTitle;
  final String missionDescription;
  final String youtubeID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchUrl(context, youtubeID);
      },
      child: Container(
        // width: 370,
        height: 96,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.secondary),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: 105,
                    child: Text(missionDate, style: missionDateText)),
                Text(
                  missionTime,
                  style: missionTimeText,
                )
              ],
            ),
            const SizedBox(
              width: 21,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 220,
                    child: AutoSizeText(
                      missionTitle,
                      maxLines: 1,
                      style: missionTitleText,
                    ),
                  ),
                  SizedBox(
                    width: 212,
                    child: AutoSizeText(
                      missionDescription,
                      maxLines: 2,
                      style: missionDescriptionText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchUrl(var context, youtubeID) async {
  try {
    if (youtubeID == null || youtubeID == '') {
      throw "Sorry for this mission there no youtube session.";
    }

    Uri url = Uri(
        scheme: "https",
        host: "www.youtube.com",
        path: "/watch",
        queryParameters: {"v": "$youtubeID"});
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(
          "Can't open url!\n$e",
          style: TextStyle(color: Theme.of(context).colorScheme.onError),
        ),
      ),
    );
  }
}
