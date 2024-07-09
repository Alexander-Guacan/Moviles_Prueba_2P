import 'package:flutter/material.dart';
import 'package:frontend/models/user.model.dart';
import 'package:frontend/services/user.service.dart';

class EditUserPage extends StatefulWidget {
  final String userId;
  const EditUserPage({super.key, required this.userId});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final TextEditingController firstnameController =
      TextEditingController(text: "");
  final TextEditingController lastnameController =
      TextEditingController(text: "");
  UserModel? user;

  @override
  void initState() {
    super.initState();
    UserService.getUserById(id: widget.userId).then(
      (userFromDb) => setState(() {
        user = userFromDb;
        firstnameController.text = userFromDb.firstname;
        lastnameController.text = userFromDb.lastname;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Usuario"),
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
                  onPressed: () => _showAlert(context),
                  child: const Text("Guardar cambios"))
            ],
          ),
        ),
      ),
    );
  }

  void _updateUser(BuildContext context) async {
    String id = widget.userId;
    String firstname = firstnameController.text;
    String lastname = lastnameController.text;
    UserService.updateUser(id: id, firstname: firstname, lastname: lastname);
  }

  Future<void> _showAlert(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Modificar contacto"),
          content: Text(
              "¿Está seguro que desea cambiar la información de ${user?.firstname} ${user?.lastname}?"),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green[800]),
              ),
              onPressed: () {
                _updateUser(context);
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            )
          ],
        );
      },
    );
  }
}
