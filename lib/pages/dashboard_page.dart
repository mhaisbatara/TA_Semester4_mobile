import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
   const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: Text(
          'Selamat datang di Dashboard 🚀',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}