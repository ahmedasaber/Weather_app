import 'package:flutter/cupertino.dart';
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

Widget customAlign({required double dirX, required double dirY, required double contHeight, required double contWidth,
       BoxShape? boxShape, required Color color}){
  return Align(
    alignment: AlignmentDirectional(dirX, dirY),
    child: Container(
      height: contHeight,
      width: contWidth,
      decoration: BoxDecoration(
          shape: boxShape ?? BoxShape.rectangle,
          color: color
      ),
    ),
  );
}

Widget blurAlertDialog({String? title, String? content, Text? textButton, required VoidCallback onPress}){
  return CupertinoAlertDialog(
    title: title != null ? Text(title) : null,
    content: content != null ? Text(content) : null,
    actions: [
      CupertinoDialogAction(
        child: textButton ?? Text('Ok'),
        onPressed: onPress,
      ),
    ],
  );
}

Widget customText({required String text, TextAlign? textAlign, TextStyle? textStyle}){
  return Text(
    text,
    textAlign: textAlign,
    style: textStyle ?? TextStyle(fontSize: 12, color: Colors.white),
    overflow: TextOverflow.ellipsis,
);
}