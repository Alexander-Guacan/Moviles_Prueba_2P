import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/users"),
              child: const Text("Lista de usuarios"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/create_user"),
              child: const Text("Crear usuario"),
            ),
          ],
        ),
      ),
    );
  }
}
