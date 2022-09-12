import 'package:flutter/material.dart';
import 'package:lockery_app/helpers/data.dart';
import 'package:lockery_app/models/models.dart';
import 'package:lockery_app/services/firebase.dart';
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
    // addrackdata();
  }

  // Future adddata() async {
  //   try {
  //     for (LockerModel element in lockers) {
  //       lockersCollection.doc(element.lockerId).update({...element.toJson()});
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future addrackdata() async {
  //   try {
  //     for (RackModel element in racks) {
  //       racksCollection.doc(element.id).set({...element.toJson()});
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
          const Rackers(),
          LockersWidget(isMyLockers: widget.isMyLockers),
        ],
      ),
    );
  }
}
