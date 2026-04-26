import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ Emulator Android pakai ini
  static const String baseUrl = "http://10.0.2.2:5000";

  // 🔐 LOGIN
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
      return {
        "status": 500,
        "data": {"message": "Tidak bisa konek ke server"},
      };
    }
  }

  // 📝 REGISTER
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
      return {
        "status": 500,
        "data": {"message": "Tidak bisa konek ke server"},
      };
    }
  }
}