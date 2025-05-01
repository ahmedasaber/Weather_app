import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/component/reusable-component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 1.2 * kToolbarHeight,25, 20), // left right top bottom
        child: SizedBox(
          height: MediaQuery.of(context).size.height, // Returns the total height of the device screen, including areas behind the status bar
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300 ,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF673AB7)
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFAB40)
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0,tileMode: TileMode.clamp),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📍 state.weather.areaName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Good Morning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Image.asset('assets/images/1.png'),
                    Center(
                      child: Text(
                        '21°C',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'THUNDERSTORM'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        DateFormat('EEEE dd • h:mm a').format(DateTime.fromMillisecondsSinceEpoch(1746124360 * 1000, isUtc: false)),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dailyWeatherStats(stateName: 'Sunrise', imagePath: 'assets/images/11.png', date: 1746069121),
                        dailyWeatherStats(stateName: 'Sunset', imagePath: 'assets/images/12.png', date: 1746117119),
                      ],
                    ),
                    Divider(thickness: 0.1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dailyWeatherStats(stateName: 'Temp Max', imagePath: 'assets/images/13.png', temp: 297.57),
                        dailyWeatherStats(stateName: 'Temp Min', imagePath: 'assets/images/14.png', temp: 293.94),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}