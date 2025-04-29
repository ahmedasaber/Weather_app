class FiveDayData{
  String? dateTime;
  int? temp;

  FiveDayData({required this.dateTime, required this.temp});

  factory FiveDayData.fromJson(Map<String, dynamic> jsonData){
    return FiveDayData(
      dateTime: jsonData['dateTime'],
      temp: jsonData['temp']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'dateTime': this.dateTime,
      'temp': this.temp
    };
  }
}