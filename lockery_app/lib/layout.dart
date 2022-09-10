import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lockery_app/screen/main_screen.dart';
import 'package:lockery_app/screen/signin_screen.dart';
import 'package:lockery_app/services/firebase.dart';
import 'package:lockery_app/widgets/progressor.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Progressor(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                } else if (snapshot.hasData && constraints.maxWidth <= 480) {
                  return const MainScreen();
                } else if (snapshot.hasData && constraints.maxWidth >= 480) {
                  return const Center(
                    child: Text('This app is runing only in Tablet PC'),
                  );
                } else {
                  return const SignInScreen();
                }
              },
            );
          }),
    );
  }
}
