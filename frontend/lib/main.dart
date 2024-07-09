import 'package:flutter/material.dart';
import 'package:frontend/pages/create_user_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/users_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/users": (context) => const UsersPage(),
        "/create_user": (context) => CreateUserPage(),
      },
    );
  }
}
