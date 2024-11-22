import 'package:flutter/material.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/widget/common_container.dart';
import 'package:sabay_ka/common/widget/common_list_tile.dart';
import 'package:sabay_ka/main.dart';
import 'package:sabay_ka/models/rides_record.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  late Future<List<RidesRecord>> _rides;

  @override
    void initState() {
      super.initState();
      _rides = locator<PocketbaseService>().getPreviousRides();
    }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        appBarTitle: "History",
        body: Column(
          children: [
            FutureBuilder(
              future: _rides,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CustomListTile(
                      title: "${snapshot.data![index].driver.firstName} ${snapshot.data![index].driver.lastName}",
                      subtitle: "${snapshot.data![index].driver.vehicle.model}",
                      trailing: Text(
                        "${snapshot.data![index].created}",
                        style: PoppinsTextStyles.bodyMediumRegular
                            .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      onTap: () {},
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ));
  }
}
