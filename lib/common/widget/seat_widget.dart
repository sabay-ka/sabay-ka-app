import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sabay_ka/common/widget/seat_layout_widget.dart';

class SeatWidget extends StatelessWidget {
  final int rowI;
  final int colI;
  final SeatState seatState;
  final void Function(int rowI, int colI, SeatState currentState) onSeatStateChanged;
  final SeatLayoutStateModel model;

  const SeatWidget({
    super.key,
    required this.rowI,
    required this.colI,
    required this.seatState,
    required this.onSeatStateChanged,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        switch (seatState) {
          case SeatState.selected:
            onSeatStateChanged(rowI, colI, SeatState.unselected);
            break;
          case SeatState.unselected:
            onSeatStateChanged(rowI, colI, SeatState.selected);
            break;
          case SeatState.disabled:
          case SeatState.sold:
          case SeatState.empty:
          default:
            {}
            break;
        }
      },
      child: seatState != SeatState.empty
          ? SvgPicture.asset(
              _getSvgPath(seatState),
              height: model.seatSvgSize,
              width: model.seatSvgSize,
              fit: BoxFit.cover,
            )
          : SizedBox(
              height: model.seatSvgSize,
              width: model.seatSvgSize,
            ),
    );
  }

  String _getSvgPath(SeatState state) {
    switch (state) {
      case SeatState.unselected:
        {
          return model.pathUnSelectedSeat;
        }
      case SeatState.selected:
        {
          return model.pathSelectedSeat;
        }
      case SeatState.disabled:
        {
          return model.pathDisabledSeat;
        }
      case SeatState.sold:
        {
          return model.pathSoldSeat;
        }
      case SeatState.empty:
      default:
        {
          return model.pathDisabledSeat;
        }
    }
  }
}

class SeatModel extends Equatable {
  final SeatState seatState;
  final int rowI;
  final int colI;
  final int seatSvgSize;
  final String pathSelectedSeat;
  final String pathUnSelectedSeat;
  final String pathSoldSeat;
  final String pathDisabledSeat;

  const SeatModel({
    required this.seatState,
    required this.rowI,
    required this.colI,
    this.seatSvgSize = 50,
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
  });

  @override
  List<Object?> get props => [
        seatState,
        rowI,
        colI,
        seatSvgSize,
        pathSelectedSeat,
        pathDisabledSeat,
        pathSoldSeat,
        pathUnSelectedSeat,
      ];
}

/// current state of a seat
enum SeatState {
  /// current user selected this seat
  selected,

  /// current user has not selected this seat yet,
  /// but it is available to be booked
  unselected,

  /// this seat is already sold to other user
  sold,

  /// this seat is disabled to be booked for some reason
  disabled,

  /// empty area e.g. aisle, staircase etc
  empty,
}
