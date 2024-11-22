import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sabay_ka/models/rides_record.dart';
import 'package:sabay_ka/common/widget/seat_layout_widget.dart';
import 'package:sabay_ka/common/widget/seat_widget.dart';

class SelectSeat extends StatefulWidget {
  const SelectSeat({super.key, required this.destination, required this.ride});

  final GeoPoint destination;
  final RidesRecord ride;

  @override
  State<SelectSeat> createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  SeatNumber? selectedSeat;

  late final int cols;
  late final int rows;
  late final List<List<SeatState>> currentSeatsState;

  @override
  void initState() {
    cols = widget.ride.driver.vehicle['cols'];
    rows = widget.ride.driver.vehicle['rows'];
    currentSeatsState = [];
    for (int i = 0; i < rows; i++) {
      final List<SeatState> row = [];
      for (int j = 0; j < cols; j++) {
        if (widget.ride.bookings == null) {
          row.add(SeatState.values[widget.ride.driver.vehicle['seats'][i][j]]);
          continue;
        }

        if (widget.ride.bookings!
            .any((booking) => booking.rowIdx == i && booking.columnIdx == j)) {
          row.add(SeatState.sold);
          continue;
        }

        row.add(SeatState.values[widget.ride.driver.vehicle['seats'][i][j]]);
      }
      currentSeatsState.add(row);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Get the width of seat based on screen width and number of columns
    double seatWidth = width / cols;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Choose seat'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SeatLayoutWidget(
                onSeatStateChanged: (rowI, colI, SeatState state) {
                  if (state == SeatState.selected) {
                    setState(() {
                      selectedSeat = SeatNumber(rowI: rowI, colI: colI);
                    });
                  } else {
                    setState(() {
                      selectedSeat = null;
                    });
                  }
                },
                stateModel: SeatLayoutStateModel(
                  seatSvgSize: seatWidth,
                  pathSelectedSeat: 'assets/images/selected-armchair.svg',
                  pathDisabledSeat: 'assets/images/disabled-armchair.svg',
                  pathUnSelectedSeat: 'assets/images/unselected-armchair.svg',
                  pathSoldSeat: 'assets/images/sold-armchair.svg',
                  cols: cols,
                  rows: rows,
                  currentSeatsState: currentSeatsState,
                ),
              ),
            ],
          )),
      floatingActionButton: ElevatedButton(
        child: Text('Confirm'),
        onPressed: () async {
          if (selectedSeat == null) {
            return;
          }

          Navigator.pop(context, selectedSeat);
        },
      ),
    );
  }
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == other.colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
