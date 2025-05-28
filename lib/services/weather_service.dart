import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

// this file help us fetch the data
// ten plik - logika pobierania danych pogodowych

class WeatherService {
  // const url (the beggining)
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather?';

  final String apiKey; // = "c041dbe582a0cc0f11b349ac1a6d1eec";

  WeatherService(this.apiKey); // constuctor

  // get weather from json
  Future<Weather> getWeather(String cityName) async {
    // send get request to weather api
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    // await - wait to server response

    // check if everything is OK (200 - OK)
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
      // if its ok return weather
      // response.body - json
    } else {
      throw Exception('Failed to load weather data');
      // if its not OK - throw exception - fail
    }
  }

  // get current city from geolocator function
  Future<String> getCurrentCity() async {
    // get permission from the user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location 
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
      );

    // convert the location into a list of placemark objects
    List<Placemark> placemarks = 
      await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }


}