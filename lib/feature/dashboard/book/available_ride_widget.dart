import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sabay_ka/common/utils/snackbar_utils.dart';
import 'package:sabay_ka/common/widget/custom_button.dart';
import 'package:sabay_ka/feature/dashboard/book/available_ride_design.dart';
import 'package:sabay_ka/feature/rideFlow/select_seat.dart';
import 'package:sabay_ka/feature/rideFlow/watch_ride.dart';
import 'package:sabay_ka/main.dart';
import 'package:sabay_ka/models/reviews_record.dart';
import 'package:sabay_ka/models/rides_record.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';

class AvailableRideWidget extends StatefulWidget {
  const AvailableRideWidget(
      {super.key,
      required this.destination,
      required this.isFromTomasClaudio,
      required this.note});

  final GeoPoint destination;
  final bool isFromTomasClaudio;
  final String note;

  @override
  State<AvailableRideWidget> createState() => _AvailableRideWidgetState();
}

class RideWithReviews {
  final RidesRecord ride;
  final double? rating;
  final List<GeoPoint> waypoints;
  final double price;

  RideWithReviews(this.ride, this.rating, this.waypoints, this.price);
}

class _AvailableRideWidgetState extends State<AvailableRideWidget> {
  RideWithReviews? _selectedRide;
  RideWithReviews? _prevSelectedRide;

  late final StreamController<List<RideWithReviews>> _streamController =
      StreamController<List<RideWithReviews>>(
    onListen: () async {
      void fetch() async {
        final rides = await locator<PocketbaseService>()
            .getRides(widget.isFromTomasClaudio);
        final ridesWithReviews = await Future.wait(rides.map((ride) async {
          final res = await Future.wait([
            locator<PocketbaseService>().getReviewsByDriver(ride.driver.id),
            locator<PocketbaseService>().getRideRoute(ride.id),
            locator<PocketbaseService>().getRequestPrice(ride.id,
                widget.destination.latitude, widget.destination.longitude)
          ]);
          // This sucks, but it's the only way to get the type right
          final reviews = res[0] as List<ReviewsRecord>;
          final waypoints = res[1] as List<GeoPoint>;
          final price = res[2] as double;

          final rating = reviews.isNotEmpty
              ? reviews.map((e) => e.rating).reduce((a, b) => a + b) /
                  reviews.length
              : null;
          if (rating == null) {
            return RideWithReviews(ride, null, waypoints, price);
          }
          return RideWithReviews(ride, rating.toDouble(), waypoints, price);
        }).toList());
        _streamController.add(ridesWithReviews);
      }

      // First fetch
      if (!_streamController.isClosed) {
        fetch();
      }

      // Listen to changes
      locator<PocketbaseService>().subscribeToRides((event) async {
        if (!_streamController.isClosed) {
          fetch();
        }
      });
    },
  );

  Stream<List<RideWithReviews>> get _rides => _streamController.stream;
  MapController controller = MapController(
      initMapWithUserPosition: UserTrackingOption(unFollowUser: true),
      areaLimit: BoundingBox(
          west: 117.17427453,
          south: 5.58100332277,
          east: 126.537423944,
          north: 18.5052273625));

  @override
  void initState() {
    super.initState();
    controller.addMarker(
        GeoPoint(
            latitude: widget.destination.latitude,
            longitude: widget.destination.longitude),
        markerIcon: MarkerIcon(
            icon: Icon(
          Icons.location_on,
          color: Colors.red,
        )));
  }

  @override
  void dispose() {
    locator<PocketbaseService>().unsubscribeToRides();
    if (!_streamController.isClosed) {
      _streamController.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rides'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: OSMFlutter(
                  controller: controller,
                  osmOption: OSMOption(zoomOption: ZoomOption(initZoom: 19)))),
          Expanded(
            child: StreamBuilder(
              stream: _rides,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (_selectedRide != null &&
                      !snapshot.data!
                          .map((ride) => ride.ride.id)
                          .contains(_selectedRide!.ride.id)) {
                    controller.clearAllRoads();
                    setState(() {
                      _selectedRide = null;
                    });
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => AvailableRideBoxDesign(
                            rideWithReviews: snapshot.data![index],
                            destination: widget.destination,
                            selectedRide: _selectedRide,
                            onRadioChanged: (value) {
                              if (value != null) {
                                controller.clearAllRoads();
                                if (_prevSelectedRide != null) {
                                  controller.removeMarker(GeoPoint(
                                      latitude:
                                          _prevSelectedRide!.ride.parkingLat,
                                      longitude:
                                          _prevSelectedRide!.ride.parkingLng));
                                  if (_prevSelectedRide!.ride.bookings !=
                                      null) {
                                    final destinations = _prevSelectedRide!
                                        .ride.bookings!
                                        .map((booking) => GeoPoint(
                                            latitude: booking.destLat,
                                            longitude: booking.destLang))
                                        .toList();
                                    controller.removeMarkers(destinations);
                                  }
                                }

                                if (value.waypoints.isNotEmpty) {
                                  controller.drawRoadManually(
                                      value.waypoints,
                                      RoadOption(
                                          roadColor: Colors.blue,
                                          roadWidth: 10));
                                }

                                controller.addMarker(
                                    GeoPoint(
                                        latitude: value.ride.parkingLat,
                                        longitude: value.ride.parkingLng),
                                    markerIcon: MarkerIcon(
                                        icon: Icon(
                                      Icons.location_on,
                                      color: Colors.green,
                                    )));
                                if (value.ride.bookings != null) {
                                  for (final waypoint in value.ride.bookings!
                                      .map((booking) => GeoPoint(
                                          latitude: booking.destLat,
                                          longitude: booking.destLang))) {
                                    controller.addMarker(waypoint,
                                        markerIcon: MarkerIcon(
                                            icon: Icon(
                                          Icons.location_on,
                                          color: Colors.blue,
                                        )));
                                  }
                                }

                                setState(() {
                                  _selectedRide = value;
                                  _prevSelectedRide = value;
                                });
                              }
                            },
                          ));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          CustomRoundedButtom(
              title: 'Confirm',
              onPressed: () async {
                try {
                  final request = await locator<PocketbaseService>()
                      .createRequest(
                          rideId: _selectedRide!.ride.id,
                          destLat: widget.destination.latitude,
                          destLong: widget.destination.longitude,
                          rowIdx: 0,
                          columnIdx: 0,
                          isFromTomasClaudio: widget.isFromTomasClaudio,
                          note: widget.note);

                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WatchRide(
                                requestId: request.id,
                                rideId: _selectedRide!.ride.id,
                                price: _selectedRide!.price)),
                        (route) => false);
                  }
                } on ClientException catch (e) {
                  if (context.mounted) {
                    SnackBarUtils.showErrorBar(
                        context: context,
                        message: e.response.cast()["message"]);
                  }
                }
              })
        ],
      ),
    );
  }
}
