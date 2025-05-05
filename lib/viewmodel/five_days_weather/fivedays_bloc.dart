import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/model/dailyforecast.dart';
import 'package:weather_app/model/five_days_data.dart';
import 'package:weather_app/repo/weather-repo.dart';

part 'fivedays_event.dart';
part 'fivedays_state.dart';

class FiveDaysBloc extends Bloc<FiveDaysEvent, FiveDaysState> {
  FiveDaysBloc() : super(FiveDaysInitial()) {
    on<FetchFiveDays>((event, emit) async {
      try {
        List<FiveDayData> fiveDaysList = await WeatherRepo().fetchFiveDaysData();
        List<DailyForecast> dailyForecast = groupByDay(fiveDaysList);
        dailyForecast.forEach((e)=>print(e.date));
        emit(FiveDaysLoaded(dailyForecast));
      } on SocketException {
        emit(FiveDaysError("Network Error"));
      } catch (e) {
        print(e.runtimeType);
        print(e is SocketException);
        emit(FiveDaysError(e.toString()));
      }
    });
  }

  List<DailyForecast> groupByDay(List<FiveDayData> forecasts) {
    final Map<String, List> dailyMap = {};

    for (var item in forecasts) {
      final date = item.dt_txt!.split(' ')[0];
      dailyMap.putIfAbsent(date, () => []).add(item);
    }

    return dailyMap.entries.map((entry) {
      final List dayForecasts = entry.value;
      final date = entry.key;

      double minTemp = double.infinity;
      double maxTemp = -double.infinity;
      final weatherFreq = <String, int>{};
      final idFreq = <int, int>{}; // Key is the weather ID (int), value is the frequency

      for (var forecast in dayForecasts) {
        final tempMin = forecast.mainWeather?.temp_min?.toDouble() ?? 0;
        final tempMax = forecast.mainWeather?.temp_max?.toDouble() ?? 0;

        if (tempMin < minTemp) minTemp = tempMin;
        if (tempMax > maxTemp) maxTemp = tempMax;

        final description = forecast.weather?[0].description;
        final id = forecast.weather?[0].id; // Weather ID is an integer

        weatherFreq[description] = (weatherFreq[description] ?? 0) + 1;
        idFreq[id] = (idFreq[id] ?? 0) + 1; // Correctly track frequency of weather IDs
      }

      final commonWeather = weatherFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key;
      final commonId = idFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      return DailyForecast(
        date: date,
        minTemp: minTemp,
        maxTemp: maxTemp,
        weather: commonWeather,
        id: commonId,
      );
    }).toList();
  }
}
