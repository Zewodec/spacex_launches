part of 'rockets_cubit.dart';

@immutable
abstract class RocketsState extends Equatable {}

class RocketsInitial extends RocketsState {
  @override
  List<Object> get props => [];
}

class RocketsLoading extends RocketsState {
  @override
  List<Object> get props => [];
}

class RocketsLoaded extends RocketsState {
  RocketsLoaded(this.rockets);

  final List<RocketsModel> rockets;

  @override
  List<Object> get props => [rockets];
}

class RocketsLoadingError extends RocketsState {
  RocketsLoadingError(this.errorMessage);

  final String? errorMessage;

  @override
  List<Object> get props => [];
}
