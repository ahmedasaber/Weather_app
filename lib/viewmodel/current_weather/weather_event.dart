part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable{}
final class FetchWeather extends WeatherEvent{

  @override
  List<Object?> get props => [];
}
final class FetchWeatherWithCity extends WeatherEvent{
  final String city;
  FetchWeatherWithCity(this.city);

  @override
  List<Object?> get props => [city];
}
