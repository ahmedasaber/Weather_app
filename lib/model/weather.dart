class Weather{
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({required this.id, required this.main, required this.description, required this.icon});

  factory Weather.fromJson(Map<String, dynamic> jsonData){
    return Weather(
      id: jsonData['id'],
      main: jsonData['main'],
      description: jsonData['description'],
      icon: jsonData['icon']
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': this.id,
      'main': this.main,
      'description': this.description,
      'icon': this.icon
    };
  }
}