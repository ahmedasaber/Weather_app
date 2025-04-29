class Clouds{
  final int? all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> jsonData){
    return Clouds(all: int.parse(jsonData['all']));
  }
  Map<String, dynamic> toJson(){
    return {
      'all':this.all
    };
  }
}