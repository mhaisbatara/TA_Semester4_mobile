import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'bmi_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentIndex = 0;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    bool status = await AuthService.isLoggedIn();
    setState(() {
      isLogin = status;
    });
  }

  void handleFeature(VoidCallback action) {
    if (isLogin) {
      action();
    } else {
      showLoginWarning();
    }
  }

  void showLoginWarning() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Akses Terbatas",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
              "Jika ingin menggunakan fitur ini diharapkan untuk login terlebih dahulu",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
                checkLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Login",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 CARD
  Widget layananCard({
    required IconData icon,
    required String title,
    required String desc,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF2E7D32)),
          ),
          const SizedBox(height: 15),
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc,
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 15),
          TextButton(
            onPressed: onTap,
            child: const Text(
              "Akses Fitur →",
              style: TextStyle(color: Color(0xFF2E7D32)),
            ),
          )
        ],
      ),
    );
  }

  // 🔥 HEADER SESUAI DESAIN
  Widget headerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
      child: Column(
        children: [
          // TOP BAR
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.local_hospital, color: Color(0xFF2E7D32)),
                  SizedBox(width: 8),
                  Text(
                    "ObesityCheck",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              Icon(Icons.menu),
            ],
          ),

          const SizedBox(height: 20),

          // LABEL
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "KESEHATAN PRIORITAS UTAMA",
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // TITLE
          const Text(
            "Cek Risiko Obesitas Anda",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Pantau kesehatan tubuh Anda dengan perhitungan BMI yang akurat dan cepat.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          // BUTTON
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const BmiPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Mulai Cek BMI",
                style: TextStyle(color: Colors.white)),
          ),

          const SizedBox(height: 10),

          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Pelajari Lebih Lanjut"),
          ),

          const SizedBox(height: 20),

          // GAMBAR (FIX ERROR)
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/img/gambar_awal.png",
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const Icon(Icons.image_not_supported, size: 100);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      // 🔥 BOTTOM NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF2E7D32),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => currentIndex = index);

          if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const BmiPage()));
          } else if (index != 0) {
            handleFeature(() {});
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monitor_weight), label: "Cek BMI"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: "SiObe"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            headerSection(),

            const SizedBox(height: 20),

            const Text("Layanan Utama Kami",
                style: TextStyle(fontWeight: FontWeight.w600)),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  layananCard(
                    icon: Icons.monitor_weight,
                    title: "Cek BMI",
                    desc:
                        "Hitung index massa tubuh anda secara presisi berdasarkan berat, tinggi, dan usia",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BmiPage()));
                    },
                  ),
                  layananCard(
                    icon: Icons.favorite,
                    title: "Tips Kesehatan",
                    desc:
                        "Kumpulan artikel pola hidup sehat, nutrisi seimbang, dan rutinitas olahraga harian",
                    onTap: () => handleFeature(() {}),
                  ),
                  layananCard(
                    icon: Icons.history,
                    title: "Riwayat BMI",
                    desc:
                        "Pantau progres perjalanan kesehatan anda dengan grafik riwayat yang mudah dimengerti",
                    onTap: () => handleFeature(() {}),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 FOOTER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.favorite,
                            color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "ObesityCheck",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Solusi digital terpercaya untuk memantau kesehatan tubuh dan risiko obesitas masyarakat Indonesia.",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  const Text("Akses Cepat",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  const Text("Beranda"),
                  const Text("Tentang Kami"),
                  const Text("Kontak"),
                  const Text("Kebijakan Privasi"),

                  const SizedBox(height: 20),

                  const Text("Hubungi Kami",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  const Text("support@obesitycheck.id"),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.language, size: 18),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.email, size: 18),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}