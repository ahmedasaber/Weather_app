import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/component/reusable-component.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/viewmodel/weather_bloc.dart';

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
              customAlign(
                dirX: 3,
                dirY: -0.3,
                contHeight: 400,
                contWidth: 280,
                boxShape: BoxShape.circle,
                color: Colors.deepPurple
              ),
              customAlign(
                dirX: -3,
                dirY: -0.3,
                contHeight: 400,
                contWidth: 280,
                boxShape: BoxShape.circle,
                color: Colors.deepPurple
              ),
              customAlign(
                  dirX: 0,
                  dirY: -1.2,
                  contHeight: 280,
                  contWidth: 600,
                  color: Color(0xFFFFAB40)
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0,tileMode: TileMode.clamp),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  switch (state) {
                    case WeatherLoaded():
                      CurrentWeatherData weather = state.currentWeatherData;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${weather.name}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300
                              ),
                            ),
                            SizedBox(height: 8,),
                            switch (weather.weather?[0].id) {
                              int id when id >= 200 && id < 300 => Image.asset('assets/images/1.png'),
                              int id when id >= 300 && id < 500 => Image.asset('assets/images/2.png'),
                              int id when id >= 500 && id < 600 => Image.asset('assets/images/3.png'),
                              int id when id >= 600 && id < 700 => Image.asset('assets/images/4.png'),
                              int id when id >= 700 && id < 800 => Image.asset('assets/images/5.png'),
                              int id when id == 800 => Image.asset('assets/images/6.png'),
                              int id when id >= 800 && id < 804 => Image.asset('assets/images/7.png'),
                              _ => Image.asset('assets/images/7.png'), // fallback for other values
                            },
                            Center(
                              child: Text(
                                '${((weather.mainWeather?.temp ?? 0) - 273.15).round()} °C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                weather.weather![0].description.toString().toUpperCase(),
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
                                DateFormat('EEEE dd ∙ h:mm a').format(DateTime.fromMillisecondsSinceEpoch(weather.dt! * 1000, isUtc: false)),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dailyWeatherStats(stateName: 'Sunrise', imagePath: 'assets/images/11.png', date: weather.sys?.sunrise),
                                dailyWeatherStats(stateName: 'Sunset', imagePath: 'assets/images/12.png', date: weather.sys?.sunset),
                              ],
                            ),
                            Divider(thickness: 0.1,color: Colors.grey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dailyWeatherStats(stateName: 'Temp Max', imagePath: 'assets/images/13.png', temp: weather.mainWeather?.temp_max),
                                dailyWeatherStats(stateName: 'Temp Min', imagePath: 'assets/images/14.png', temp: weather.mainWeather?.temp_min),
                              ],
                            ),
                          ],
                        ),
                      );
                    case WeatherLoading():
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white,)
                      );
                    case WeatherError():
                      return Dialog(child: Text(state.errorMessage),);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}