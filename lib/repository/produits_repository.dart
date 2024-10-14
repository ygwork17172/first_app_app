import 'package:sprintf/sprintf.dart';
import 'package:flutter_hello_word_app/data/network_api_services.dart';
import 'package:flutter_hello_word_app/res/app_url/app_url.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/produits.dart';

class ProduitsRepository {
  final _apiService = NetworkApiServices();

  Future<Produit> produitsApi(int? actorId) async {
    var url =
        actorId == null ? AppUrl.produitsApi : sprintf(AppUrl.produitsApi, [1]);
    dynamic response = await _apiService.getApi(url);
    return Produit.fromJson(response);
  }

  Future<Produit> getListApi(int page) async {
    dynamic response =
        await _apiService.getApi(sprintf(AppUrl.produitsApi, [page]));
    return Produit.fromJson(response);
  }

  Future<List<Produit>> fetchProduits() async {
    print("Bonjour, monde2 !");
    try {
      final response = await http.get(Uri.parse(AppUrl.produitsApi));
      print(response);
      // Vérifiez le code de statut HTTP
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Produit.fromJson(data)).toList();
      } else {
        // Gestion des erreurs avec des messages plus clairs
        throw Exception(
            'Erreursssss ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Gestion des exceptions
      throw Exception('Échec de la connexion00000 : $e');
    }
  }
}
