class WeatherForecast {
  final DateTime date;
  final int temperatureC;
  final int temperatureF;
  final String? summary;

  WeatherForecast({
    required this.date,
    required this.temperatureC,
    required this.temperatureF,
    this.summary,
  });

  // Calculer TemperatureF
  int get calculatedTemperatureF => 32 + (temperatureC ~/ 0.5556).toInt();

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    // Convertir la date depuis une chaîne
    DateTime date = DateTime.parse(json['date']);

    return WeatherForecast(
      date: date,
      temperatureC: json['temperatureC'],
      temperatureF: json['temperatureF'],
      summary: json['summary'],
    );
  }
}
