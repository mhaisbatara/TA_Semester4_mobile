import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  void handleLogin() async {
    setState(() {
      isLoading = true;
    });

    final result = await ApiService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (result['status'] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login berhasil")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['data']['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Icon(Icons.favorite, color: Colors.green, size: 50),

                const SizedBox(height: 10),
                const Text(
                  "SiObe",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Masuk ke Dashboard",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                // EMAIL
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // BUTTON LOGIN
                ElevatedButton(
                  onPressed: isLoading ? null : handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Masuk"),
                ),

                const SizedBox(height: 10),

                // REGISTER BUTTON
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RegisterPage(),
                      ),
                    );
                  },
                  child: const Text("Belum punya akun? Daftar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}