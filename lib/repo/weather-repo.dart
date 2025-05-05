import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/five_days_data.dart';

class WeatherRepo{
  final String baseUrl = "https://api.openweathermap.org/data/2.5";
  final String apiKey = "5dbc7b346cc0015cb1f8fe845ebedd10";

  Future<Position> get position async => await _determinePosition();

  double? _lat;
  double? _lon;

  String get currentWeatherUrl => "$baseUrl/weather?lat=$_lat&lon=$_lon&appid=$apiKey";

  Future<CurrentWeatherData> fetchCurrentData() async{
    Position position = await this.position;
    _lat = position.latitude;
    _lon = position.longitude;

    var response = await http.get(Uri.parse("$baseUrl/weather?lat=$_lat&lon=$_lon&appid=$apiKey"));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return CurrentWeatherData.fromJson(jsonData);
    }else{
      throw ('${response.reasonPhrase}');
    }
  }

  Future<List<FiveDayData>> fetchFiveDaysData() async{
    Position position = await this.position;
    _lat = position.latitude;
    _lon = position.longitude;
    var response = await http.get(Uri.parse("$baseUrl/forecast?lat=$_lat&lon=$_lon&appid=$apiKey"));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return List.of(jsonData['list']).map((i)=>FiveDayData.fromJson(i)).toList();
    }else{
      throw ('${response.reasonPhrase}');
    }
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