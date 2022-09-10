import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lockery_app/controllers/controllers.dart';
import 'package:lockery_app/helpers/helpers.dart';
import 'package:lockery_app/models/locker.dart';
import 'package:lockery_app/services/services.dart';
import 'package:lockery_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LockersWidget extends StatelessWidget {
  final bool? isMyLockers;
  const LockersWidget({Key? key, this.isMyLockers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double msSize = size.height / 1.5;
    return StreamBuilder<QuerySnapshot>(
        stream: lockersCollection.snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: msSize,
              child: const Center(
                child: Progressor(
                  height: 30,
                  width: 30,
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return SizedBox(
              height: msSize,
              child: const Center(
                child: Text('Something went wrong!'),
              ),
            );
          }

          List<LockerModel>? lockers = [];

          // Filter by booking status
          if (isMyLockers!) {
            for (var e in snapshot.data!.docs) {
              if (isCurrentUserLocker(
                  LockerModel.fromJson(e.data()).bookedDataEncode)) {
                lockers.add(LockerModel.fromJson(e.data()));
              }
            }
          } else {
            lockers = snapshot.data!.docs
                .map((e) => LockerModel.fromJson(e.data()))
                .toList();
          }

          // Filter by location
          String location =
              context.watch<LocationSelectController>().currentValue.name!;

          if (location != "All") {
            lockers.retainWhere((element) => location
                .toLowerCase()
                .contains(element.lockerLocation!.name!.toLowerCase()));
          }

          return lockers.isEmpty
              ? SizedBox(
                  height: msSize,
                  child: const Center(
                    child: Text('Lockers was not found!'),
                  ),
                )
              : GridView.builder(
                  itemCount: lockers.length,
                  padding: const EdgeInsets.only(bottom: 80),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return LockerCard(
                      lockerModel: lockers![index],
                    );
                  },
                );
        });
  }
}