import 'package:flutter/material.dart';
import 'package:lockery_app/screens/home_screen.dart';
import 'package:lockery_app/screens/scanner_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int tabIndex = 0;
  List<Widget> screens = const [
    HomeScreen(),
    HomeScreen(
      isMyLockers: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lockery'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScannerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.qr_code),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: screens.elementAt(tabIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (value) {
          setState(() {
            tabIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'My Lockers')
        ],
      ),
    );
  }
}
