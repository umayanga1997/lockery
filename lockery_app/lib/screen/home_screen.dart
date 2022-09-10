import 'package:flutter/material.dart';
import 'package:lockery_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  final bool? isMyLockers;
  const HomeScreen({Key? key, this.isMyLockers = false}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // adddata();
  }

  // Future adddata() async {
  //   try {
  //     var firebase = FirebaseFirestore.instance;
  //     var collection = firebase.collection('lockers');
  //     for (LockerModel element in lockers) {
  //       collection.doc(element.lockerId).set({...element.toJson()});
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const LocationsWidget(),
          LockersWidget(isMyLockers: widget.isMyLockers),
        ],
      ),
    );
  }
}
