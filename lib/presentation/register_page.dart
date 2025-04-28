import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(home: RegisterPage(), debugShowCheckedModeBanner: false),
  );
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(), // kosong dulu
        ),
      ),
    );
  }
}
