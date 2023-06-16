import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:spacex_launches/features/rocket_launcher_list/data/models/launchpdas_model.dart';
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
    final List<String> landpadsForRocketsLaunches = [];

    for (int i = 0; i < rocketUpcomingLaunchesData.length; i++) {
      rocketUpcomingLaunches
          .add(RocketLaunchesModel.fromJson(rocketUpcomingLaunchesData[i]));
      landpadsForRocketsLaunches.add(
          await getLaunchpadNameByID(rocketUpcomingLaunchesData[i].launchpad));
    }

    emit(RocketLaunchesLoaded(
        rocketUpcomingLaunches, landpadsForRocketsLaunches));
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
    final List<String> landpadsForRocketsLaunches = [];

    for (int i = 0; i < rocketUpcomingLaunchesData.length; i++) {
      RocketLaunchesModel currentRocketLaunchesModel =
          RocketLaunchesModel.fromJson(rocketUpcomingLaunchesData[i]);

      if (currentRocketLaunchesModel.rocket == rocketID) {
        rocketUpcomingLaunches.add(currentRocketLaunchesModel);
        landpadsForRocketsLaunches.add(
            await getLaunchpadNameByID(currentRocketLaunchesModel.launchpad));
      }
    }

    emit(RocketLaunchesLoaded(
        rocketUpcomingLaunches, landpadsForRocketsLaunches));
  }

  Future<String> getLaunchpadNameByID(String launchpad) async {
    final launchpadNameData =
        await repository.dioGetLaunchpadNameByID(launchpad);
    LaunchpadsModel launchpadsModel =
        LaunchpadsModel.fromJson(launchpadNameData);
    return launchpadsModel.fullName;
  }
}
