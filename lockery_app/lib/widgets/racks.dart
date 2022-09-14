import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockery_app/controllers/controllers.dart';
import 'package:lockery_app/controllers/rack_select_controller.dart';
import 'package:lockery_app/models/models.dart';
import 'package:lockery_app/services/firebase.dart';
import 'package:lockery_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Rackers extends StatefulWidget {
  const Rackers({Key? key}) : super(key: key);

  @override
  State<Rackers> createState() => _RackersState();
}

class _RackersState extends State<Rackers> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15.0,
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: racksCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Progressor(
              isCircular: false,
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }

          List<RackModel> racks = snapshot.data!.docs
              .map((e) => RackModel.fromJson(e.data()))
              .toList();

          // Filter by location
          String location =
              context.watch<LocationSelectController>().currentValue.name!;

          if (location != "All") {
            racks.retainWhere((element) => location
                .toLowerCase()
                .contains(element.rackLocation!.name!.toLowerCase()));
          }

          return racks.isEmpty
              ? const Center(
                  child: Text('Racks ware not found!'),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Racks'),
                    SizedBox(
                      height: 60.0,
                      child: ListView.builder(
                        itemCount: racks.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: RackChipButton(
                              data: racks[index],
                              isSelected: racks[index].id ==
                                  context.watch<RackSelectController>().rackID,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
