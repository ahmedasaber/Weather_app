class Coord{
  final double? lon;
  final double? lat;

  Coord({required this.lon, required this.lat});

  factory Coord.fomJson(Map<String, dynamic> jsonData){
    return Coord(
      lon: double.parse(jsonData['lon']),
      lat: double.parse(jsonData['lat']),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'lon': this.lon,
      'lat': this.lat,
    };
  }
}