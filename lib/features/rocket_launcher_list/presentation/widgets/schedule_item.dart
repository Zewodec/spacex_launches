import 'package:flutter/material.dart';
import 'package:spacex_launches/core/text_styles.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem(
      {super.key,
      required this.missionDate,
      required this.missionTime,
      required this.missionTitle,
      required this.missionDescription});

  final String missionDate;
  final String missionTime;
  final String missionTitle;
  final String missionDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361,
      height: 96,
      color: Theme.of(context).colorScheme.secondary,
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
              Text(missionDate, style: missionDateText),
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
                Text(
                  missionTitle,
                  style: missionTitleText,
                ),
                Text(
                  missionDescription,
                  style: missionDescriptionText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
