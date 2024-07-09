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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreenAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
                    labelStyle: TextStyle(color: Colors.black, fontSize: 21),
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
                    labelStyle: TextStyle(color: Colors.black, fontSize: 21),
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

                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Guardar cambios",
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
              style: TextButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _updateUser(context);
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar",
              style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
