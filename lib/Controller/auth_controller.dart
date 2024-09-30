import 'package:flutter/material.dart';
import 'package:flutter_hello_word_app/view/home/home_page.dart';

class AuthController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    final username = usernameController.text;
    final password = passwordController.text;

    // Logique d'authentification (remplacez par votre logique réelle)
    if (username == "a" && password == "123") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }
}
