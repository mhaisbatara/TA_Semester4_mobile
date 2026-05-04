import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // 🔥 penting (untuk web detect)
import 'dart:io'; // 🔥 untuk android detect

class ApiService {

  // 🔥 AUTO BASE URL
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:5000"; // ✅ untuk Chrome
    } else if (Platform.isAndroid) {
      return "http://10.0.2.2:5000"; // ✅ emulator Android
    } else {
      return "http://localhost:5000"; // fallback
    }
  }

  // =======================
  // 🔐 LOGIN
  // =======================
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      return {
        "status": response.statusCode,
        "data": jsonDecode(response.body),
      };

    } catch (e) {
      print("LOGIN ERROR: $e"); // 🔥 debug
      return {
        "status": 500,
        "data": {"message": "Tidak bisa konek ke server"},
      };
    }
  }

  // =======================
  // 📝 REGISTER
  // =======================
  static Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      return {
        "status": response.statusCode,
        "data": jsonDecode(response.body),
      };

    } catch (e) {
      print("REGISTER ERROR: $e"); // 🔥 debug
      return {
        "status": 500,
        "data": {"message": "Tidak bisa konek ke server"},
      };
    }
  }
}