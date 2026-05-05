import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    theme: ThemeData(
      fontFamily: 'Poppins',
      primaryColor: const Color(0xFF4CAF50),
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SiObe',
      home: DashboardPage(), // 🔥 langsung dashboard
    );
  }
}