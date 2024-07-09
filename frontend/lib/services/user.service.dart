import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/user.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserService {
  static Future<List<UserModel>> getUsers() async {
    String usersEndpoint = dotenv.env["API_URL"]!;
    var response = await http.get(Uri.parse(usersEndpoint));

    List<dynamic> usersResponse =
        convert.jsonDecode(response.body) as List<dynamic>;

    List<UserModel> users = [];

    for (var user in usersResponse) {
      UserModel newUser = UserModel(
        id: user["_id"],
        firstname: user["firstname"],
        lastname: user["lastname"],
        avatar: user["avatar"],
      );

      users.add(newUser);
    }

    return users;
  }

  static Future<UserModel> getUserById({required String id}) async {
    String usersEndpoint = dotenv.env["API_URL"]!;
    var response = await http.get(Uri.parse("$usersEndpoint/$id"));

    Map<String, dynamic> userResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    UserModel user = UserModel(
      id: id,
      firstname: userResponse["firstname"],
      lastname: userResponse["lastname"],
      avatar: userResponse["avatar"],
    );

    return user;
  }

  static Future<void> deleteUser(String id) async {
    String usersEndpoint = dotenv.env["API_URL"]!;
    http.delete(Uri.parse("$usersEndpoint/$id"));
  }

  static Future<UserModel> createUser(
      {required String firstname, required String lastname}) async {
    String usersEndpoint = dotenv.env["API_URL"]!;
    var response = await http.post(
      Uri.parse(usersEndpoint),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode({
        "firstname": firstname,
        "lastname": lastname,
      }),
    );

    Map<String, dynamic> userCreated =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    UserModel userModel = UserModel(
      id: userCreated["_id"],
      firstname: userCreated["firstname"],
      lastname: userCreated["lastname"],
      avatar: userCreated["avatar"],
    );

    return userModel;
  }

  static Future<void> updateUser(
      {required String id,
      required String firstname,
      required String lastname}) async {
    String usersEndpoint = dotenv.env["API_URL"]!;
    http.put(
      Uri.parse("$usersEndpoint/$id"),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode({
        "firstname": firstname,
        "lastname": lastname,
      }),
    );
  }
}
