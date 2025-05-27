class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition; // cloudy or sunny or whatever                

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  // function to read information from json
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'], 
      temperature: json['main']['temp'].toDouble, 
      mainCondition: json['weather'][0]['main'],
      );
  }
}