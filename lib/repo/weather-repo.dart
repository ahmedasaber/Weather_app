import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/current_weather.dart';

class WeatherRepo{
  final String baseUrl = "https://api.openweathermap.org/data/2.5";
  final String apiKey = "5dbc7b346cc0015cb1f8fe845ebedd10";

  final double lat;
  final double lon;

  WeatherRepo({required this.lon,required this.lat});

  String get currentWeatherUrl => "$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey";

  Future<CurrentWeatherData> fetchCurrentData() async{
    var response = await http.get(Uri.parse(currentWeatherUrl));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return CurrentWeatherData.fromJson(jsonData);
    }else{
      throw ('${response.reasonPhrase}');
    }
  }


}