import 'dart:io';
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
      emit(WeatherLoading());
      try {
        Position position = await _determinePosition();
        WeatherRepo weatherRepo = WeatherRepo(lat: position.latitude, lon: position.longitude);
        CurrentWeatherData currentWeatherData = await weatherRepo.fetchCurrentData();
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

  /// Determine the current position of the device.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
