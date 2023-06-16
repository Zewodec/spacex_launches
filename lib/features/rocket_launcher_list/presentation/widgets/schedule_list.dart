import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/rocket_launches_cubit.dart';

class ScheduleList extends StatefulWidget {
  const ScheduleList({super.key});

  @override
  State<ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<ScheduleList> {
  late RocketLaunchesCubit rocketsLaunchesCubit;

  @override
  void initState() {
    rocketsLaunchesCubit = RocketLaunchesCubit();
    // TODO: Launch Load RocketLaunches for first rocket

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: rocketsLaunchesCubit,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RocketLaunchesLoading) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onSecondary,
          );
        }
        return const CircularProgressIndicator(
          color: Colors.redAccent,
        );
      },
    );
  }
}
