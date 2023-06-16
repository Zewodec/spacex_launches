part of 'rocket_launches_cubit.dart';

@immutable
abstract class RocketLaunchesState extends Equatable {}

class RocketLaunchesInitial extends RocketLaunchesState {
  @override
  List<Object> get props => [];
}

class RocketLaunchesLoading extends RocketLaunchesState {
  @override
  List<Object> get props => [];
}

class RocketLaunchesLoaded extends RocketLaunchesState {
  @override
  List<Object> get props => [];
}

class RocketLaunchesLoadingError extends RocketLaunchesState {
  RocketLaunchesLoadingError(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object> get props => [];
}
