import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/repo/weather-repo.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading()) {
    on<FetchWeather>((event, emit) async{
      emit(WeatherLoading());
      try {
        CurrentWeatherData currentWeatherData = await WeatherRepo().fetchCurrentData();
        emit(WeatherLoaded(currentWeatherData));
      } on SocketException {
        emit(WeatherError("Network Error"));
      } catch (e) {
        print(e.runtimeType);
        print(e is SocketException);
        emit(WeatherError(e.toString()));
      }
    });
  }
}
