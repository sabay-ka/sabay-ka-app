import 'package:collection/collection.dart';
import 'package:sabay_ka/common/widget/seat_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SeatLayoutWidget extends StatefulWidget {
  const SeatLayoutWidget({
    super.key,
    required this.stateModel,
    required this.onSeatStateChanged,
  });

  final SeatLayoutStateModel stateModel;
  final void Function(int rowI, int colI, SeatState currentState)
      onSeatStateChanged;

  @override
  State<SeatLayoutWidget> createState() => _SeatLayoutWidgetState();
}

class _SeatLayoutWidgetState extends State<SeatLayoutWidget> {
  late List<List<SeatState>> stateModel;

  @override
    void initState() {
      stateModel = List<int>.generate(widget.stateModel.rows, (rowI) => rowI)
        .map<List<SeatState>>(
          (rowI) => List<int>.generate(widget.stateModel.cols, (colI) => colI)
              .map<SeatState>(
                (colI) => widget.stateModel.currentSeatsState[rowI][colI],
              )
              .toList(),
        )
        .toList();

      super.initState();
    }

  void _onSeatStateChanged(int rowI, int colI, SeatState newState) {
    setState(() {
      stateModel[rowI][colI] = newState;
      // Unselect all other seats if a seat is selected
      for (var i = 0; i < stateModel.length; i++) {
        for (var j = 0; j < stateModel[i].length; j++) {
          if (stateModel[i][j] == SeatState.selected && (i != rowI || j != colI)) {
            stateModel[i][j] = SeatState.unselected;
          }
        }
      }
    });

    widget.onSeatStateChanged(rowI, colI, newState);
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 5,
      minScale: 0.8,
      boundaryMargin: const EdgeInsets.all(8),
      constrained: true,
      child: Column(
        children: [
          ...stateModel.mapIndexed((i, row) => Row(
            children: [...row.mapIndexed((j, seatState) => 
              SeatWidget(
                rowI: i,
                colI: j,
                seatState: seatState,
                onSeatStateChanged: _onSeatStateChanged,
                model: widget.stateModel,
              )
            )],
          )), 
        ],
      ),
    );
  }
}


class SeatLayoutStateModel extends Equatable {
  final int rows;
  final int cols;
  final List<List<SeatState>> currentSeatsState;
  final double seatSvgSize;
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathDisabledSeat;

  const SeatLayoutStateModel({
    required this.rows,
    required this.cols,
    required this.currentSeatsState,
    this.seatSvgSize = 50,
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
  });

  @override
  List<Object?> get props => [
        rows,
        cols,
        seatSvgSize,
        currentSeatsState,
        pathUnSelectedSeat,
        pathSelectedSeat,
        pathSoldSeat,
        pathDisabledSeat,
      ];
}
