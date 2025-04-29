class MainWeather{
  final double? temp, feels_like, temp_min, temp_max, pressure, humidity, sea_level, grnd_level;

  MainWeather({required this.temp, required this.feels_like, required this.temp_min, required this.temp_max,
    required this.pressure, required this.humidity, required this.sea_level, required this.grnd_level});

  factory MainWeather.formJson(Map<String, dynamic> jsonData){
    return MainWeather(
      temp: double.parse(jsonData['temp']),
      feels_like: double.parse(jsonData['feels_like']),
      temp_min: double.parse(jsonData['temp_min']),
      temp_max: double.parse(jsonData['temp_max']),
      pressure: double.parse(jsonData['pressure']),
      humidity: double.parse(jsonData['humidity']),
      sea_level: double.parse(jsonData['sea_level']),
      grnd_level: double.parse(jsonData['grnd_level'])
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'temp': this.temp,
      'feels_like': this.feels_like,
      'temp_min': this.temp_min,
      'temp_max': this.temp_max,
      'pressure': this.pressure,
      'humidity': this.humidity,
      'sea_level': this.sea_level,
      'grnd_level': this.grnd_level
    };
  }

}
