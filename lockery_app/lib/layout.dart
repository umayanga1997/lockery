import 'package:flutter/material.dart';
import 'package:lockery_app/screen/main_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth <= 480) return const MainScreen();
          return const Center(
            child: Text('This app is runing only in Tablet PC'),
          );
        },
      ),
    );
  }
}
