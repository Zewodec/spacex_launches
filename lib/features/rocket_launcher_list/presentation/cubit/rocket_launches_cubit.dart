import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:spacex_launches/features/rocket_launcher_list/data/repositories/rockets_launches_repository.dart';

import '../../data/models/rocket_launches_model.dart';

part 'rocket_launches_state.dart';

class RocketLaunchesCubit extends Cubit<RocketLaunchesState> {
  RocketLaunchesCubit(this.repository) : super(RocketLaunchesInitial());

  final RocketsLaunchesRepository repository;

  void loadAllUpcomingLaunches() async {
    emit(RocketLaunchesLoading());
    final rocketUpcomingLaunchesData =
        await repository.dioGetAllUpcomingLaunches();

    // Check if there error on output
    if (rocketUpcomingLaunchesData[0] is Map<String, String>) {
      final errorObj = rocketUpcomingLaunchesData[0] as Map<String, String>;
      if (errorObj.keys.first == "error") {
        emit(RocketLaunchesLoadingError(errorObj["error"]));
        return;
      }
    }

    final List<RocketLaunchesModel> rocketUpcomingLaunches = [];

    for (int i = 0; i < rocketUpcomingLaunchesData.length; i++) {
      rocketUpcomingLaunches
          .add(RocketLaunchesModel.fromJson(rocketUpcomingLaunchesData[i]));
    }

    emit(RocketLaunchesLoaded(rocketUpcomingLaunches));
  }

  void loadForRocketUpcomingLaunches(String rocketID) async {
    emit(RocketLaunchesLoading());
    final rocketUpcomingLaunchesData =
        await repository.dioGetAllUpcomingLaunches();

    // Check if there error on output
    if (rocketUpcomingLaunchesData[0] is Map<String, String>) {
      final errorObj = rocketUpcomingLaunchesData[0] as Map<String, String>;
      if (errorObj.keys.first == "error") {
        emit(RocketLaunchesLoadingError(errorObj["error"]));
        return;
      }
    }

    final List<RocketLaunchesModel> rocketUpcomingLaunches = [];

    for (int i = 0; i < rocketUpcomingLaunchesData.length; i++) {
      RocketLaunchesModel currentRocketLaunchesModel =
          RocketLaunchesModel.fromJson(rocketUpcomingLaunchesData[i]);
      if (currentRocketLaunchesModel.rocket == rocketID) {
        rocketUpcomingLaunches.add(currentRocketLaunchesModel);
      }
    }

    emit(RocketLaunchesLoaded(rocketUpcomingLaunches));
  }
}
