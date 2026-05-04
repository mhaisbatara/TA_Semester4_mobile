import 'package:flutter/material.dart';
import 'login_page.dart';
import 'bmi_page.dart';

class DashboardPublicPage extends StatefulWidget {
  const DashboardPublicPage({super.key});

  @override
  State<DashboardPublicPage> createState() => _DashboardPublicPageState();
}

class _DashboardPublicPageState extends State<DashboardPublicPage> {
  int currentIndex = 0;

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
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 CARD BARU (VERTIKAL SESUAI DESAIN)
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
          // ICON
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50)),
          ),

          const SizedBox(height: 15),

          // TITLE
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),

          const SizedBox(height: 8),

          // DESC
          Text(desc,
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),

          const SizedBox(height: 15),

          // BUTTON
          TextButton(
            onPressed: onTap,
            child: const Text("Akses Fitur →",
                style: TextStyle(color: Color(0xFF4CAF50))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      // 🔥 BOTTOM NAVBAR LENGKAP
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF4CAF50),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => currentIndex = index);

          if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const BmiPage()));
          } else if (index != 0) {
            showLoginWarning();
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_weight), label: "Cek BMI"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Riwayat"),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: "SiObe"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔥 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              color: const Color(0xFF4CAF50),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("ObesityCheck",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Cek Risiko Obesitas Anda",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Pantau kesehatan tubuh Anda dengan BMI yang akurat dan cepat.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 20),

                  // 🔥 GAMBAR
                  Image.asset("assets/img/gambar_awal.jpeg", height: 140),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BUTTON BMI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BmiPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Mulai Cek BMI"),
              ),
            ),

            const SizedBox(height: 25),

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
                    onTap: showLoginWarning,
                  ),

                  layananCard(
                    icon: Icons.history,
                    title: "Riwayat BMI",
                    desc:
                        "Pantau progres perjalanan kesehatan anda dengan grafik riwayat yang mudah dimengerti",
                    onTap: showLoginWarning,
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
                children: const [

                  Text("ObesityCheck",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                  SizedBox(height: 10),

                  Text(
                      "Solusi digital terpercaya untuk memantau kesehatan tubuh dan risiko obesitas masyarakat Indonesia."),

                  SizedBox(height: 20),

                  Text("Akses Cepat",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  SizedBox(height: 10),

                  Text("Beranda"),
                  Text("Tentang Kami"),
                  Text("Kontak"),
                  Text("Kebijakan Privasi"),

                  SizedBox(height: 20),

                  Text("Hubungi Kami",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  SizedBox(height: 10),

                  Text("support@obesitycheck.id"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}