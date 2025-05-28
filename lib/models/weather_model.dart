class Weather {
  // pola przechowujace dane o pogodzie 
  final String cityName;
  final double temperature;
  final String mainCondition; // cloudy or sunny or whatever     
    // final - po przypisaniu nie mozna juz zmienic           

  // KONSTRUKTOR
  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });
    // required - trzeba te pola podac przy tworzeiu obiektu


  // METODY
  // function to read information from json
  // funkcja przyjmuje mape json i zwraca nowy obiekt klasy Weather
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'], 
      temperature: json['main']['temp'].toDouble, 
      mainCondition: json['weather'][0]['main'],
      );
  }
}