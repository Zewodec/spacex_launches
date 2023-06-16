import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex_launches/features/rocket_launcher_list/presentation/widgets/schedule_item.dart';

import '../../data/models/rocket_launches_model.dart';
import '../cubit/rocket_launches_cubit.dart';

class ScheduleList extends StatefulWidget {
  const ScheduleList({super.key, required this.rocketsLaunchesCubit});

  final RocketLaunchesCubit rocketsLaunchesCubit;

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.rocketsLaunchesCubit,
      listener: (context, state) {
        if (state is RocketLaunchesLoadingError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Error loading rockets launches: ${state.errorMessage}",
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
        }
      },
      builder: (context, state) {
        if (state is RocketLaunchesLoading) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onSecondary,
          );
        } else if (state is RocketLaunchesLoaded) {
          return Expanded(
            child: SizedBox(
              width: 370,
              child: ListView.builder(
                  itemCount: state.rocketLaunches.length,
                  itemBuilder: (context, index) {
                    RocketLaunchesModel rocketLaunch =
                        state.rocketLaunches[index];
                    String missionDate =
                        DateFormat('dd/MM/yyyy').format(rocketLaunch.dateUtc);
                    String missionTime =
                        DateFormat('hh:mm a').format(rocketLaunch.dateUtc);
                    String missionTitle = rocketLaunch.name;
                    String missionDescription =
                        state.launchpadsForRocketsLaunches[index];
                    String youtubeID = rocketLaunch.links.youtubeId ?? "";
                    return Column(
                      children: [
                        ScheduleItem(
                          missionDate: missionDate,
                          missionTime: missionTime,
                          missionTitle: missionTitle,
                          missionDescription: missionDescription,
                          youtubeID: youtubeID,
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  }),
            ),
          );
        }
        return const CircularProgressIndicator(
          color: Colors.redAccent,
        );
      },
    );
  }
}
