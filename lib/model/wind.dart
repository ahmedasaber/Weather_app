class Wind{
  final double? speed,deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(Map<String, dynamic> jsonData){
    return Wind(
      speed: double.parse(jsonData['speed']),
      deg: double.parse(jsonData['deg'])
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'speed': this.speed,
      'deg': this.deg
    };
  }
}