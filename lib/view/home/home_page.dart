import 'package:flutter/material.dart';
import 'package:flutter_hello_word_app/model/weather_forecast.dart';
import 'package:flutter_hello_word_app/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<WeatherForecast>> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = ApiService().fetchWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prévisions Météo'),
      ),
      body: FutureBuilder<List<WeatherForecast>>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final weatherData = snapshot.data!;
            return ListView.builder(
              itemCount: weatherData.length,
              itemBuilder: (context, index) {
                final item = weatherData[index];
                return ListTile(
                  title: Text(item.date.toString()),
                  subtitle: Text(
                    'Température: ${item.temperatureC} °C\nRésumé: ${item.summary}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
