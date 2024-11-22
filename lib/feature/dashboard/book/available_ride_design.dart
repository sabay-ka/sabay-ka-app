import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/constant/assets.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/feature/dashboard/book/available_ride_widget.dart';

class AvailableRideBoxDesign extends StatelessWidget {
  const AvailableRideBoxDesign({
    super.key, 
    required this.rideWithReviews, 
    required this.destination,
    required this.selectedRide,
    required this.onRadioChanged,
  });

  final RideWithReviews rideWithReviews;
  final GeoPoint? destination;
  final RideWithReviews? selectedRide;
  final void Function(RideWithReviews?) onRadioChanged;

  @override
  Widget build(BuildContext context) {
    final ride = rideWithReviews.ride;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: CustomTheme.appColor),
          color: CustomTheme.appColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Radio<RideWithReviews>(value: rideWithReviews, groupValue: selectedRide, onChanged: onRadioChanged),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "PHP ${rideWithReviews.price}",
                  style: PoppinsTextStyles.subheadLargeRegular.copyWith(
                      color: CustomTheme.darkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "${ride.driver.firstName} ${ride.driver.lastName}",
                  style: PoppinsTextStyles.subheadLargeRegular.copyWith(
                      color: CustomTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "${ride.driver.vehicle['seatNumber'] - ( ride.bookings?.length ?? 0 )} seats",
                  style: PoppinsTextStyles.bodySmallRegular
                      .copyWith(color: CustomTheme.darkColor.withOpacity(0.5)),
                ),
                Text(
                  "Average Rating: ${rideWithReviews.rating != null ? rideWithReviews.rating!.toStringAsFixed(1) : "No reviews yet"}",
                  style: PoppinsTextStyles.bodySmallRegular
                      .copyWith(color: CustomTheme.darkColor.withOpacity(0.5)),
                )
              ]),
              Image.asset(
                  Assets.bmwCario,
              )
            ],
          ),
        ],
      ),
    );
  }
}
