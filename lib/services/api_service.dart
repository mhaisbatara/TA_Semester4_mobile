import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:io';

class ApiService {

  // 🔥 GANTI INI DENGAN IP LAPTOP KAMU
  static const String localIP = "192.168.0.138";

  // 🔥 AUTO BASE URL (WEB + EMULATOR + HP)
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:5000"; // 🌐 Chrome
    } else if (Platform.isAndroid) {
      // 🔥 kalau emulator pakai 10.0.2.2
      // 🔥 kalau HP asli pakai IP laptop
      return "http://$localIP:5000";
    } else {
      return "http://$localIP:5000";
    }
  }

  // =======================
  // 🔐 LOGIN
  // =======================
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/login");

      print("LOGIN URL: $url"); // 🔥 debug

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      return {
        "status": response.statusCode,
        "data": jsonDecode(response.body),
      };

    } catch (e) {
      print("LOGIN ERROR: $e");

      return {
        "status": 500,
        "data": {"message": "Tidak bisa konek ke server"},
      };
    }
  }

  // =======================
// 🤖 CHAT AI
// =======================
static Future<Map<String, dynamic>> chat(String message) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message}),
    );

    print("CHAT STATUS: ${response.statusCode}");
    print("CHAT BODY: ${response.body}");

    return {
      "status": response.statusCode,
      "data": jsonDecode(response.body),
    };

  } catch (e) {
    print("CHAT ERROR: $e");

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
      final url = Uri.parse("$baseUrl/register");

      print("REGISTER URL: $url"); // 🔥 debug

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      return {
        "status": response.statusCode,
        "data": jsonDecode(response.body),
      };

    } catch (e) {
      print("REGISTER ERROR: $e");

      return {
        "status": 500,
        "data": {"message": "Tidak bisa konek ke server"},
      };
    }
  }
}