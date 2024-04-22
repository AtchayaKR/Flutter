import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class AuthenticationService {
  static const String _baseUrl = 'http://localhost:3000'; 
  Future<bool> register(String email, String password) async {
    final url = Uri.parse('$_baseUrl/registration');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return true; // Registration successful
    } else {
      throw Exception('Failed to register');
    }
  }
}
