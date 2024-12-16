import 'package:flutter/material.dart';
import 'package:flutter_hello_word_app/view/home/produits.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../res/app_url/app_url.dart';

class AuthController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String apiUrl = AppUrl.authApi;
  // void login(BuildContext context) {
  //   final username = usernameController.text;
  //   final password = passwordController.text;
  //   print("Bonjour, monde !");
  //   if (username == "a" && password == "a") {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const ProduitsPage()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Invalid username or password')),
  //     );
  //   }
  // }

  Future<void> login(BuildContext context) async {
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Naviguer vers la page des produits
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProduitsPage()),
        );
      } else {
        // Afficher un message d'erreur si le login échoue
        final errorResponse = jsonDecode(response.body);
        String message =
            errorResponse['message'] ?? 'Invalid username or password';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      // Gestion des erreurs réseau ou autres exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'passwordHash': password}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to register');
    }
  }
}
