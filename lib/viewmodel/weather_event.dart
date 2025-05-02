part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable{}
final class FetchWeather extends WeatherEvent{
  final Position position;

  FetchWeather(this.position);

  @override
  List<Object?> get props => [position];
}
