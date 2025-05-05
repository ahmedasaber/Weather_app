part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable{}
final class FetchWeather extends WeatherEvent{

  @override
  List<Object?> get props => [];
}
