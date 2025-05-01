import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget dailyWeatherStats({required String stateName,required String imagePath, int? date, double? temp}){
  return Row(
    children: [
      Image.asset(imagePath,scale: 9),
      SizedBox(width: 5,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            stateName,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300
            ),
          ),
          const SizedBox(height: 3),
          Text(
            date!=null
                ? DateFormat('h:mm a').format(DateTime.fromMillisecondsSinceEpoch(date * 1000, isUtc: false))
                : '${(temp! - 273.15).round()} °C',
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700
            ),
          ),
        ],
      )
    ],
  );
}