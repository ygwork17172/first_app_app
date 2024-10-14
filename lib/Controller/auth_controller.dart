import 'package:flutter/material.dart';
import 'package:flutter_hello_word_app/view/home/produits.dart';

class AuthController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    final username = usernameController.text;
    final password = passwordController.text;
    print("Bonjour, monde !");
    if (username == "a" && password == "a") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ProduitsPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }
}
