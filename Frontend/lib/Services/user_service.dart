import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserService {
  static Future<Map<String, dynamic>> registerUser(String email, String password) async {
    final url = '${Constants.baseUrl}${Constants.registerEndpoint}';
    final response = await http.post(Uri.parse(url), body: {'email': email, 'password': password});
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }
}
