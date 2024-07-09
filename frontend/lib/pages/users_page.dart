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
    UserService.getUsers().then((usersFromDb) =>
        setState(() {
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
      body: Stack(
        children: [
          Container(
            color: Colors.teal[100],
          ),
          ListView.builder(
            padding: const EdgeInsets.all(9),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 9),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.tealAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(users[index].avatar),
                          radius: 30,
                        ),
                        title: Text(
                          "${users[index].firstname} ${users[index].lastname}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditUserPage(userId: users[index].id),
                                    ),
                                  ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_forever),
                              onPressed: () => _showAlert(context, index),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAlert(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Eliminar contacto",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "¿Está seguro que desea eliminar a ${users[index]
                    .firstname} ${users[index].lastname}?",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(users[index].avatar),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${users[index].firstname} ${users[index].lastname}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red[800],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => _removeContact(context, index),
              child: const Text(
                "Eliminar",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(fontSize: 16),
              ),
            ),
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