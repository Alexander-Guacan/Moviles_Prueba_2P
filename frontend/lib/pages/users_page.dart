import 'package:flutter/material.dart';
import 'package:frontend/models/user.model.dart';
import 'package:frontend/pages/edit_user_page.dart';
import 'package:frontend/services/user.service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<UserModel> users = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    
    UserService.getUsers().then((usersFromDb) => setState(() {
          users = usersFromDb;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuarios"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Image.network(users[index].avatar),
                    title: Text(
                        "${users[index].firstname} ${users[index].lastname}"),
                  ),
                ),
                IconButton(
                  onPressed: () => _showAlert(context, index),
                  icon: const Icon(Icons.delete_forever),
                ),
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditUserPage(userId: users[index].id))),
                  icon: const Icon(Icons.edit),
                ),
              ],
            );
          }),
    );
  }

  Future<void> _showAlert(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar contacto"),
          content: Text(
              "¿Está seguro que desea eliminar a ${users[index].firstname} ${users[index].lastname}?"),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red[800]),
              ),
              onPressed: () => _removeContact(context, index),
              child: const Text(
                "Eliminar",
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

  void _removeContact(BuildContext context, int index) async {
    await UserService.deleteUser(users[index].id);

    setState(() {
      users.removeAt(index);
      Navigator.pop(context);
    });
  }
}
