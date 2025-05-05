class DailyForecast {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String weather;
  final int id;

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.weather,
    required this.id,
  });
}