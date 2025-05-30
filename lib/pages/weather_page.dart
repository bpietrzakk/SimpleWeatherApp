import 'package:flutter/material.dart';
import 'package:simple_weather_app/models/weather_model.dart';
import 'package:simple_weather_app/services/weather_service.dart';

// file to "draw" weather page in our app 
// TO DO MYSELF

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

// LOGIKA I ZMIENNE TEGO EKRANU
class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService("c041dbe582a0cc0f11b349ac1a6d1eec");
  Weather? _weather;

  // fetch weather
  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  //  budowanie wygladu apki
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "city..."),

            Text('${_weather?.temperature.round()}*C'),

            ElevatedButton(
              onPressed: () async {
                await _fetchWeather();
              }, 
              child: Text('get your location'),
            ),
          ],
        ),
      ),
    );
  }
}