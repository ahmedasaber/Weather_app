import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/view/home_screen.dart';
import 'package:weather_app/view/search_screen.dart';
import 'package:weather_app/viewmodel/current_weather/weather_bloc.dart';
import 'package:weather_app/viewmodel/five_days_weather/fivedays_bloc.dart';

void main() async {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc> (create: (context) => WeatherBloc()..add(FetchWeather())),
        BlocProvider<FiveDaysBloc> (create: (context) => FiveDaysBloc()..add(FetchFiveDays())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => HomeScreen(),
          '/search':(context) => SearchWithCity(),
        },
        theme: ThemeData(
            fontFamily: 'Sora'
        ),
        home: HomeScreen()
      ),
    );
  }
}
