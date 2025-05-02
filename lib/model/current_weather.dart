import 'package:weather_app/model/clouds.dart';
import 'package:weather_app/model/coord.dart';
import 'package:weather_app/model/main_weather.dart';
import 'package:weather_app/model/sys.dart';
import 'package:weather_app/model/weather.dart';

class CurrentWeatherData {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  MainWeather? mainWeather;
  int? visibility;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timeZone;
  int? id;
  String? name;
  int? cod;

  CurrentWeatherData({required this.coord,
    required this.weather,
    required this.base,
    required this.mainWeather,
    required this.visibility,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timeZone,
    required this.id,
    required this.name,
    required this.cod
  });

  factory CurrentWeatherData.fromJson(Map<String, dynamic> jsonData){
    return CurrentWeatherData(
      coord: Coord.fomJson(jsonData['coord']),
      weather: List.of(jsonData['weather']).map((i)=>Weather.fromJson(i)).toList(),
      base: jsonData['base'],
      mainWeather: MainWeather.formJson(jsonData['main']),
      visibility: jsonData['visibility'],
      clouds: Clouds.fromJson(jsonData['clouds']),
      dt: jsonData['dt'],
      sys: Sys.fromJson(jsonData['sys']),
      timeZone: jsonData['timezone'],
      id: jsonData['id'],
      name: jsonData['name'],
      cod: jsonData['cod']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'coord': this.coord,
      'weather': this.weather?.map((e)=> e.toJson()).toList(),
      'base': this.base,
      'main': this.mainWeather,
      'visibility': this.visibility,
      'clouds': this.clouds,
      'dt': this.dt,
      'sys': this.sys,
      'timeZone': this.timeZone,
      'id': this.id,
      'name': this.name,
      'cod': this.cod
    };
  }

}
