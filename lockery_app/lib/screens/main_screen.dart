import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lockery_app/helpers/colors.dart';
import 'package:lockery_app/screens/home_screen.dart';
import 'package:lockery_app/screens/scanner_screen.dart';
import 'package:lockery_app/services/services.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

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
  void initState() {
    super.initState();
    fcmInit();
  }

  fcmInit() async {
    await fcmToken();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      RemoteNotification notification = message!.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != (null) && android != (null) && !kIsWeb) {
        // Action
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      RemoteNotification notification = message!.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != (null) && android != (null) && !kIsWeb) {
        // Action
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      RemoteNotification notification = message!.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != (null) && android != (null) && !kIsWeb) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            channelKey: 'booked_notification',
            color: whiteColor,
            payload: Map<String, String>.from(message.data),
          ),
        );
      }
    });
  }

  fcmToken() async {
    try {
      var token = await FirebaseMessaging.instance.getToken();
      var userId = FirebaseAuth.instance.currentUser!.uid;
      userCollection.doc(userId).update({'fcm_token': token});
    } catch (e) {
      errorMessage(message: e.toString());
    }
  }

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
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
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
