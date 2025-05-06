import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/component/reusable-component.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/viewmodel/current_weather/weather_bloc.dart';
import 'package:weather_app/viewmodel/five_days_weather/fivedays_bloc.dart';

class SearchWithCity extends StatefulWidget{
  @override
  State<SearchWithCity> createState() => _SearchWithCityState();
}

class _SearchWithCityState extends State<SearchWithCity> {

  bool hasSearched = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          forceMaterialTransparency: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarColor: Colors.transparent
          ),
          title: Text("Weather", style: TextStyle(color: Colors.white),),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
              context.read<WeatherBloc>().add(FetchWeather());
              context.read<FiveDaysBloc>().add(FetchFiveDays());
            }, icon: Icon(CupertinoIcons.back)
          ),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 1.7 * kToolbarHeight,25, 20), // left right top bottom
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
                    color: const Color(0xFFFFAB40)
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0,sigmaY: 100.0,tileMode: TileMode.clamp),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        cursorColor: Colors.white38,
                        style: TextStyle(color: Colors.white),
                        onSubmitted: (value){
                          if(value.length > 3){
                            context.read<WeatherBloc>().add(FetchWeatherWithCity(value.trim()));
                            context.read<FiveDaysBloc>().add(FetchFiveDaysWithCity(value.trim()));
                            setState(() {
                              hasSearched = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, color: Colors.white38),
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Search for a city',
                          hintStyle: const TextStyle(color: Colors.white38),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
                          ),
                          filled: true,
                          fillColor:  Colors.deepPurple.shade900
                        ),
                      ),
                      SizedBox(height: 10,),
                      if(hasSearched)
                        BlocBuilder<WeatherBloc, WeatherState>(
                        builder: (context, state) {
                          switch (state) {
                            case WeatherLoaded():
                              CurrentWeatherData weather = state.currentWeatherData;
                              return SizedBox(
                                //height: MediaQuery.of(context).size.height,
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
                                      int id when id >= 200 && id < 300 => Center(child: Image.asset('assets/images/1.png')),
                                      int id when id >= 300 && id < 500 => Center(child: Image.asset('assets/images/2.png')),
                                      int id when id >= 500 && id < 600 => Center(child: Image.asset('assets/images/3.png')),
                                      int id when id >= 600 && id < 700 => Center(child: Image.asset('assets/images/4.png')),
                                      int id when id >= 700 && id < 800 => Center(child: Image.asset('assets/images/5.png')),
                                      int id when id == 800 => Center(child: Center(child: Image.asset('assets/images/6.png'))),
                                      int id when id >= 800 && id < 804 => Center(child: Image.asset('assets/images/7.png')),
                                      _ => Center(child: Image.asset('assets/images/7.png')), // fallback for other values
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
                                    const Divider(thickness: 0.1,color: Colors.grey),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        dailyWeatherStats(stateName: 'Temp Max', imagePath: 'assets/images/13.png', temp: weather.mainWeather?.temp_max),
                                        dailyWeatherStats(stateName: 'Temp Min', imagePath: 'assets/images/14.png', temp: weather.mainWeather?.temp_min),
                                      ],
                                    ),
                                    const SizedBox(height: 50),
                                    const Text('5-Days Forecast', style: TextStyle(color: Colors.white),),
                                    const SizedBox(height: 20),
                                    BlocBuilder<FiveDaysBloc, FiveDaysState>(
                                      builder: (context, state){
                                        switch(state){
                                          case FiveDaysLoaded():
                                            return Container(
                                              padding: EdgeInsets.all(16),
                                              decoration:BoxDecoration(
                                                color: Colors.white.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child:  Column(
                                                children: state.dailyForecast.map((e) =>
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex:3,
                                                            child: customText(
                                                                text: '${DateFormat.E().format(DateTime.parse(e.date))}'
                                                            )
                                                        ),
                                                        Expanded(
                                                            flex:5,
                                                            child: Row(
                                                              children: [
                                                                switch (e.id) {
                                                                  int id when id >= 200 && id < 300 => Image.asset('assets/images/1.png', scale: 20,),
                                                                  int id when id >= 300 && id < 500 => Image.asset('assets/images/2.png', scale: 20,),
                                                                  int id when id >= 500 && id < 600 => Image.asset('assets/images/3.png', scale: 20,),
                                                                  int id when id >= 600 && id < 700 => Image.asset('assets/images/4.png', scale: 20,),
                                                                  int id when id >= 700 && id < 800 => Image.asset('assets/images/5.png', scale: 20,),
                                                                  int id when id == 800 => Image.asset('assets/images/6.png', scale: 20,),
                                                                  int id when id >= 800 && id < 804 => Image.asset('assets/images/7.png', scale: 20,),
                                                                  _ => Image.asset('assets/images/7.png', scale: 20,), // fallback for other values
                                                                },
                                                                const SizedBox(width: 5,),
                                                                Expanded(
                                                                  child: customText(
                                                                      text: '${e.weather}',
                                                                      textAlign: TextAlign.left
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                        ),
                                                        Expanded(
                                                            flex:3,
                                                            child: customText(
                                                                text: '${(e.maxTemp - 273.15).round()}° / ${(e.minTemp - 273.15).round()}°',
                                                                textAlign: TextAlign.end
                                                            )
                                                        ),
                                                        const SizedBox(height: 50),
                                                      ],
                                                    ),
                                                ).toList(),
                                              ),
                                            );
                                          case FiveDaysError():
                                            return Center(
                                              child: Text(state.errorMessage),
                                            );
                                          case FiveDaysInitial():
                                            return const SizedBox.shrink();
                                        }
                                      }
                                    ),
                                  ],
                                ),
                              );
                            case WeatherLoading():
                              return Center(
                                  child: CircularProgressIndicator(color: Colors.white,)
                              );
                            case WeatherError():
                              return blurAlertDialog(
                                content: state.errorMessage,
                                textButton: const Text('Retry'),
                                onPress: (){
                                  context.read<WeatherBloc>().add(FetchWeatherWithCity(_searchController.text));
                                  context.read<FiveDaysBloc>().add(FetchFiveDaysWithCity(_searchController.text));
                                },
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}