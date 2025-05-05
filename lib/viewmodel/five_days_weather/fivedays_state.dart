part of 'fivedays_bloc.dart';

@immutable
sealed class FiveDaysState extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class FiveDaysInitial extends FiveDaysState {
}
final class FiveDaysLoaded extends FiveDaysState {
  final List<DailyForecast> dailyForecast;

  FiveDaysLoaded(this.dailyForecast);

  @override
  List<Object?> get props => [dailyForecast];
}
final class FiveDaysError extends FiveDaysState {
  final String errorMessage;

  FiveDaysError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
