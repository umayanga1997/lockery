import 'package:flutter/cupertino.dart';
import 'package:lockery_app/controllers/controllers.dart';
import 'package:lockery_app/helpers/helpers.dart';
import 'package:lockery_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LocationsWidget extends StatelessWidget {
  const LocationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Locations'),
          SizedBox(
            height: 60,
            child: Center(
              child: ListView.builder(
                itemCount: locations.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: LocationChipButton(
                    data: locations[index],
                    isSelected: context
                            .watch<LocationSelectController>()
                            .currentValue
                            .id! ==
                        index,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
