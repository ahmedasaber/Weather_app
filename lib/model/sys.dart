class Sys{
  final int? type, id, sunrise, sunset;
  final String? country;

  Sys({required this.type, required this.id, required this.sunrise, required this.sunset, required this.country});

  factory Sys.fromJson(Map<String, dynamic> jsonData){
    return Sys(
      type: jsonData['type'],
      id: jsonData['id'],
      sunrise: jsonData['sunrise'],
      sunset: jsonData['sunset'],
      country: jsonData['country']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': this.type,
      'id': this.id,
      'sunrise': this.sunrise,
      'sunset': this.sunset,
      'country': this.country
    };
  }
}