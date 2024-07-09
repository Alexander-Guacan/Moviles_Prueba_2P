import 'package:flutter/material.dart';
import 'package:frontend/services/user.service.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController firstnameController =
      TextEditingController(text: "");
  final TextEditingController lastnameController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Usuario"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.orange[200],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    labelText: "Nombre",
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 21),
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                    labelText: "Apellido",
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 21),
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _showAlert(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Crear Usuario",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createUser(BuildContext context) async {
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    await UserService.createUser(firstname: firstname, lastname: lastname);
  }

  Future<void> _showAlert(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Crear Usuario"),
          content: const Text(
              "¿Está seguro que desea crear un nuevo usuario con la información proporcionada?"),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _createUser(context);
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
              child: const Text(
                "Crear",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
