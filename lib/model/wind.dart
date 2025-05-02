class Wind{
  final double? speed;
  final int? deg;

  Wind({required this.speed, required this.deg});

  factory Wind.fromJson(Map<String, dynamic> jsonData){
    return Wind(
      speed: jsonData['speed'],
      deg: jsonData['deg']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'speed': this.speed,
      'deg': this.deg
    };
  }
}