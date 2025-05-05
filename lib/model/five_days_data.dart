import 'package:weather_app/model/main_weather.dart';
import 'package:weather_app/model/weather.dart';

class FiveDayData{
  int? dt;
  List<Weather>? weather;
  MainWeather? mainWeather;
  String? dt_txt;

  FiveDayData({required this.dt, required this.weather, required this.mainWeather, required this.dt_txt});

  factory FiveDayData.fromJson(Map<String, dynamic> jsonData){
    return FiveDayData(
      dt: jsonData['dt'],
      weather: List.of(jsonData['weather']).map((i)=>Weather.fromJson(i)).toList(),
      mainWeather: MainWeather.formJson(jsonData['main']),
      dt_txt: jsonData['dt_txt'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'dt': this.dt,
      'weather': this.weather?.map((e)=> e.toJson()).toList(),
      'main': this.mainWeather
    };
  }
}