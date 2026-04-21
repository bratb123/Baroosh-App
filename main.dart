import 'package:flutter/material.dart';

void main() {
  runApp(const BarooshApp());
}

class BarooshApp extends StatelessWidget {
  const BarooshApp({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle mainFont = TextStyle(
      fontFamily: 'serif',
      letterSpacing: 1.2,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baroosh Luxury',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF02060B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD1D1D1), // لون الفضة
          secondary: Color(0xFF162A44),
          surface: Color(0xFF0F141A),
        ),
        textTheme: const TextTheme(
          displayMedium: mainFont,
          titleLarge: mainFont,
          bodyLarge: mainFont,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// عنصر الجوهرة الفضية الموحد في التطبيق
class JewelryLogo extends StatelessWidget {
  final double size;
  const JewelryLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.diamond_outlined, // تم تغيير القناع إلى جوهرة
      size: size,
      color: const Color(0xFFD1D1D1), // لون فضي
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A192F), Color(0xFF02060B)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
            child: Column(
              children: [
                const JewelryLogo(size: 90), // شعار الجوهرة
                const SizedBox(height: 20),
                const Text(
                  "خواتم بروش",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFD1D1D1),
                  ),
                ),
                const Text(
                  "MARENA LUXURY JEWELRY",
                  style: TextStyle(fontSize: 12, color: Colors.white30),
                ),
                const SizedBox(height: 80),
                const UserInputField(),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD1D1D1),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InventoryScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "تسجيل الدخول",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInputField extends StatelessWidget {
  const UserInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "اسم المستخدم",
            filled: true,
            fillColor: Colors.white.withOpacity(0.02),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.person_outline, size: 20),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "كلمة المرور",
            filled: true,
            fillColor: Colors.white.withOpacity(0.02),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.lock_open_rounded, size: 20),
          ),
        ),
      ],
    );
  }
}

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  final List<String> items = const [
    "عقيق كبدي فاخر",
    "عقيق مصور نادِر",
    "عقيق سماوي قديم",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المجموعة الخاصة", style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF0F141A),
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const JewelryLogo(size: 30), // جوهرة صغيرة في القائمة
              title: Text(items[index]),
              trailing: const Icon(Icons.chevron_right, color: Colors.white24),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetails(title: items[index]),
                  ),
                );

                // إشعار الشراء المطور بلون واضح جداً
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.black),
                          const SizedBox(width: 10),
                          Text(
                            result,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: const Color(
                        0xFF00E676,
                      ), // أخضر فاقع وواضح جداً
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  final String title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF0F141A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: const Center(
                child: JewelryLogo(size: 100),
              ), // جوهرة كبيرة في التفاصيل
            ),
            const SizedBox(height: 40),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "تم فحص هذه القطعة بعناية فائقة لتناسب ذوقكم الرفيع.",
              style: TextStyle(color: Colors.white38),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF162A44),
                  foregroundColor: const Color(0xFFD1D1D1),
                  side: const BorderSide(color: Color(0xFFD1D1D1), width: 0.5),
                ),
                onPressed: () =>
                    Navigator.pop(context, "تم شراء $title بنجاح!"),
                child: const Text("تأكيد الشراء والعودة"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
