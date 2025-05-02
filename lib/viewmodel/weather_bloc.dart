import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/repo/weather-repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading()) {
    on<FetchWeather>((event, emit) async{
      Future.delayed(Duration(seconds: 3));
      try {
        WeatherRepo weatherRepo = WeatherRepo(lat: event.position.latitude, lon: event.position.longitude);
        CurrentWeatherData currentWeatherData = await weatherRepo.fetchCurrentData();
        emit(WeatherLoaded(currentWeatherData));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
