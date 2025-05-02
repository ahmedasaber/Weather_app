part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable{
  @override

  List<Object?> get props => [];
}

final class WeatherLoading extends WeatherState {}
final class WeatherLoaded extends WeatherState {
  final CurrentWeatherData currentWeatherData;

  WeatherLoaded(this.currentWeatherData);

  @override
  List<Object?> get props => [currentWeatherData];
}
final class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
