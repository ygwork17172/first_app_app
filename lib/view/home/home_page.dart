import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Gardez 'const' ici

  // Rendre la liste constante
  static const List<Map<String, dynamic>> weatherData = [
    {"date": "2024-10-01", "temperatureC": 11, "summary": "Balmy"},
    {"date": "2024-10-02", "temperatureC": 40, "summary": "Balmy"},
    {"date": "2024-10-03", "temperatureC": 54, "summary": "Warm"},
    {"date": "2024-10-04", "temperatureC": 19, "summary": "Bracing"},
    {"date": "2024-10-05", "temperatureC": -17, "summary": "Sweltering"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prévisions Météo'),
      ),
      body: ListView.builder(
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          final item = weatherData[index];
          return ListTile(
            title: Text(item["date"]),
            subtitle: Text(
              'Température: ${item["temperatureC"]} °C\nRésumé: ${item["summary"]}',
            ),
          );
        },
      ),
    );
  }
}
