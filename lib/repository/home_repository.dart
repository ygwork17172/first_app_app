import 'package:sprintf/sprintf.dart';
import 'package:flutter_hello_word_app/data/network_api_services.dart';
import 'package:flutter_hello_word_app/model/weather_forecast.dart';
import 'package:flutter_hello_word_app/res/app_url/app_url.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<WeatherForecast> weatherForecastApi(int? actorId) async {
    var url =
        actorId == null ? AppUrl.weatherApi : sprintf(AppUrl.weatherApi, [1]);
    dynamic response = await _apiService.getApi(url);
    return WeatherForecast.fromJson(response);
  }

  Future<WeatherForecast> getListApi(int page) async {
    dynamic response =
        await _apiService.getApi(sprintf(AppUrl.weatherApi, [page]));
    return WeatherForecast.fromJson(response);
  }

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
        // Gestion des erreurs avec des messages plus clairs
        throw Exception(
            'Erreur ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Gestion des exceptions
      throw Exception('Échec de la connexion : $e');
    }
  }
}
