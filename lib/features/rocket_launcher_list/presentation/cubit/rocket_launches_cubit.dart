import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'rocket_launches_state.dart';

class RocketLaunchesCubit extends Cubit<RocketLaunchesState> {
  RocketLaunchesCubit() : super(RocketLaunchesInitial());
}
