import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Page",
        ),
      ),
      body: const Column(
        children: [
          Text(
            "Login Page",
            style: TextStyle(
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
