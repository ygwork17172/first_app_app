import 'dart:convert';
import 'package:flutter_hello_word_app/model/weather_forecast.dart';
import 'package:http/http.dart' as http;

import '../model/produits.dart';
import '../res/app_url/app_url.dart';

class ApiService {
  Future<List<WeatherForecast>> fetchWeatherForecast() async {
    try {
      // Remplacez par l'URL de votre API réelle sans CORS Anywhere une fois que CORS est configuré.
      final response = await http.get(Uri.parse(AppUrl.weatherApi));

      // Vérifiez le code de statut HTTP
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => WeatherForecast.fromJson(data))
            .toList();
      } else {
        throw Exception(
            'Erreur ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Échec de la connexion : $e');
    }
  }

  Future<List<Produit>> fetchProduitsForecast() async {
    print("Bonjour, monde 3 !");
    try {
      final response = await http.get(Uri.parse(AppUrl.produitsApi));
      print("Bonjour, monde 00 !");
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Produit.fromJson(data)).toList();
      } else {
        throw Exception(
            'Erreur ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Échec de la connexion : $e');
    }
  }
}
