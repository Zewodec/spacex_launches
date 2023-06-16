import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:spacex_launches/features/rocket_launcher_list/data/repositories/rockets_repository.dart';

import '../../data/models/rockets_model.dart';

part 'rockets_state.dart';

class RocketsCubit extends Cubit<RocketsState> {
  RocketsCubit(this.repository) : super(RocketsInitial());

  final RocketsRepository repository;

  void loadRockets() async {
    emit(RocketsLoading());
    final rocketsData = await repository.dioGetAllRockets();

    if (rocketsData[0] is Map<String, String>) {
      final errorObj = rocketsData[0] as Map<String, String>;
      if (errorObj.keys.first == "error") {
        emit(RocketsLoadingError(errorObj["error"]));
      }
    }

    final List<RocketsModel> rockets = [];

    for (int i = 0; i < rocketsData.length; i++) {
      rockets.add(RocketsModel.fromJson(rocketsData[i]));
    }

    emit(RocketsLoaded(rockets));
  }
}
