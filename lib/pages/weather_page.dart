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
  String cityName = '';
  Weather? weather;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  void getWeather() async{
    WeatherService weatherService = WeatherService('c041dbe582a0cc0f11b349ac1a6d1eec');
    cityName = await weatherService.getCurrentCity();
    weather = await weatherService.getWeather(cityName);
    setState(() {});
  }

  //  budowanie wygladu apki
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pogoda w ${cityName ?? ""}'),
      ),
      body: Center(
        child: weather == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${weather!.temperature.toStringAsFixed(1)} °C',
                    style: TextStyle(fontSize: 48),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    weather!.mainCondition,
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
      ),
    );
  }
}