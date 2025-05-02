import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view/home_screen.dart';
import 'package:weather_app/viewmodel/weather_bloc.dart';

void main() async {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Sora'
      ),
      home: BlocProvider (
        create: (context) => WeatherBloc()..add(FetchWeather()),
        child: HomeScreen(),
      ),
    );
  }
}
