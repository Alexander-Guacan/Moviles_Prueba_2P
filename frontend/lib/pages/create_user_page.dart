import 'package:flutter/material.dart';
import 'package:frontend/services/user.service.dart';

class CreateUserPage extends StatelessWidget {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear usuario"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextField(
                controller: firstnameController,
                decoration: const InputDecoration(label: Text("Nombre")),
              ),
              TextField(
                controller: lastnameController,
                decoration: const InputDecoration(label: Text("Apellido")),
              ),
              ElevatedButton(
                  onPressed: () => _createUser(context),
                  child: const Text("Crear Usuario"))
            ],
          ),
        ),
      ),
    );
  }

  void _createUser(BuildContext context) async {
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;

    UserService.createUser(firstname: firstname, lastname: lastname);
    Navigator.pop(context);
  }
}
