class MainWeather{
  final double? temp, feels_like, temp_min, temp_max;
  final int? pressure, humidity, sea_level, grnd_level;

  MainWeather({required this.temp, required this.feels_like, required this.temp_min, required this.temp_max,
    required this.pressure, required this.humidity, required this.sea_level, required this.grnd_level});

  factory MainWeather.formJson(Map<String, dynamic> jsonData){
    return MainWeather(
      temp: jsonData['temp'],
      feels_like: jsonData['feels_like'],
      temp_min: jsonData['temp_min'],
      temp_max: jsonData['temp_max'],
      pressure: jsonData['pressure'],
      humidity: jsonData['humidity'],
      sea_level: jsonData['sea_level'],
      grnd_level: jsonData['grnd_level']
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
