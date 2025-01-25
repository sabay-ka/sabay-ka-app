import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/utils/snackbar_utils.dart';
import 'package:sabay_ka/common/widget/custom_button.dart';
import 'package:sabay_ka/feature/dashboard/dashboard_widget.dart';
import 'package:sabay_ka/main.dart';
import 'package:sabay_ka/models/requests_record.dart';
import 'package:sabay_ka/models/rides_record.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';

class WatchRide extends StatefulWidget {
  const WatchRide(
      {super.key, required this.requestId, required this.rideId, this.price});

  final String requestId;
  final String rideId;
  final double? price;
  final bool isPaid = false;

  @override
  State<WatchRide> createState() => _WatchRideState();
}

class RequestandRideRecord {
  final RequestsRecord request;
  final RidesRecord ride;
  final double price;
  final bool isPaid;

  RequestandRideRecord(this.request, this.ride, this.price, this.isPaid);
}

class _WatchRideState extends State<WatchRide> {
  late RequestsRecord _prevRequest;
  late RidesRecord _prevRide;
  late double _price;
  late bool _prevIsPaid;

  late final StreamController<RequestandRideRecord> _controller =
      StreamController<RequestandRideRecord>(
    onListen: () async {
      // First fetch
      if (!_controller.isClosed) {
        final [request, ride, paymentss] = await Future.wait([
          locator<PocketbaseService>().getRequest(widget.requestId),
          locator<PocketbaseService>().getRide(widget.rideId),
          locator<PocketbaseService>().getUserPayments(),
        ]);
        _prevRequest = request as RequestsRecord;
        _prevRide = ride as RidesRecord;

        final payments = paymentss as List<RecordModel>;
        _prevIsPaid = false;
        for (final payment in payments) {
          if (payment.getStringValue('status') == 'completed') {
            _prevIsPaid = true;
            break;
          }
        }

        if (widget.price != null) {
          _price = widget.price!;
        } else {
          _price = await locator<PocketbaseService>()
              .getRequestPrice(ride.id, request.destLat, request.destLong);
        }

        _controller.add(RequestandRideRecord(
          _prevRequest,
          _prevRide,
          _price,
          _prevIsPaid,
        ));
      }

      // Listen to changes
      locator<PocketbaseService>().subscribeToRequest(widget.requestId,
          (event) async {
        if (!_controller.isClosed) {
          _prevRequest =
              await locator<PocketbaseService>().getRequest(widget.requestId);

          _controller.add(RequestandRideRecord(
              _prevRequest, _prevRide, _price, _prevIsPaid));
        }
      });
      locator<PocketbaseService>().subscribeToRide(widget.rideId,
          (event) async {
        if (!_controller.isClosed) {
          _prevRide = await locator<PocketbaseService>().getRide(widget.rideId);

          _controller.add(RequestandRideRecord(
              _prevRequest, _prevRide, _price, _prevIsPaid));
        }
      });
      locator<PocketbaseService>().subscribeToPayments((event) async {
        if (!_controller.isClosed) {
          final payments = await locator<PocketbaseService>().getUserPayments();
          _prevIsPaid = false;
          for (final payment in payments) {
            if (payment.getStringValue('status') == 'completed') {
              _prevIsPaid = true;
              break;
            }
          }

          _controller.add(RequestandRideRecord(
              _prevRequest, _prevRide, _price, _prevIsPaid));
        }
      });
    },
  );

  Stream<RequestandRideRecord> get _requestRide => _controller.stream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final [waypoints as List<GeoPoint>, request as RequestsRecord] =
          await Future.wait([
        locator<PocketbaseService>().getRideRoute(widget.rideId),
        locator<PocketbaseService>().getRequest(widget.requestId),
      ]);
      controller.drawRoadManually(
          waypoints, RoadOption(roadColor: Colors.blue, roadWidth: 10));
      // Draw the route along the waypoints to the destination
      final myWayPoints = <GeoPoint>[];
      for (final waypoint in waypoints) {
        myWayPoints.add(GeoPoint(
            latitude: waypoint.latitude, longitude: waypoint.longitude));
        if (waypoint.latitude == request.destLat &&
            waypoint.longitude == request.destLong) {
          break;
        }
      }
      controller.drawRoadManually(
          myWayPoints, RoadOption(roadColor: Colors.red, roadWidth: 10));
      controller.addMarker(
          GeoPoint(latitude: request.destLat, longitude: request.destLong),
          markerIcon: MarkerIcon(
              icon: Icon(
            Icons.location_on,
            color: Colors.red,
          )));
    });
  }

  @override
  void dispose() {
    _controller.close();
    locator<PocketbaseService>().unsubscribeToRequest(widget.requestId);
    locator<PocketbaseService>().unsubscribeToRide(widget.rideId);
    super.dispose();
  }

  MapController controller = MapController(
      initMapWithUserPosition: UserTrackingOption(enableTracking: true),
      areaLimit: BoundingBox(
          west: 117.17427453,
          south: 5.58100332277,
          east: 126.537423944,
          north: 18.5052273625));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your ride')),
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(
          child: OSMFlutter(
              controller: controller,
              osmOption: OSMOption(zoomOption: ZoomOption(initZoom: 19))),
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
            stream: _requestRide,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('$snapshot.error.toString()');
              }
              if (snapshot.hasData) {
                final request = snapshot.data!.request;
                final ride = snapshot.data!.ride;
                final price = snapshot.data!.price;
                final isPaid = snapshot.data!.isPaid;

                if (isPaid) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('You have reached your destination',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      CustomRoundedButtom(
                          title: 'Return to Dashboard',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardWidget()),
                                (route) => false);
                          })
                    ],
                  );
                }

                if (request.status == RequestsRecordStatusEnum.rejected) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Driver has rejected your request',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      CustomRoundedButtom(
                          title: 'Return to Dashboard',
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboardWidget()),
                                (route) => false);
                          })
                    ],
                  );
                }

                if (ride.status == RidesRecordStatusEnum.cancelled) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Ride has been cancelled',
                        style: PoppinsTextStyles.headlineMediumRegular,
                      ),
                      CustomRoundedButtom(
                          title: 'Return to Dashboard',
                          onPressed: () {
                            locator<PocketbaseService>()
                                .cancelRequest(request.id)
                                .then((_) {
                              if (!context.mounted) return;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardWidget()),
                                  (route) => false);
                            }).onError((ClientException e, _) {
                              if (!context.mounted) return;
                              SnackBarUtils.showErrorBar(
                                  context: context,
                                  message: e.response.cast()["message"]);
                            });
                          })
                    ],
                  );
                }

                if (request.status == RequestsRecordStatusEnum.pending) {
                  final seats = ride.driver.vehicle['seatNumber'] as int;
                  final occupiedSeats =
                      ride.bookings == null ? 0 : ride.bookings!.length;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'Driver: ${ride.driver.firstName} ${ride.driver.lastName}',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      Text('Remaining Seats: ${seats - occupiedSeats}',
                          style: PoppinsTextStyles.headlineSmallRegular),
                      Text('PHP $price',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      Text('Waiting for the driver to accept your request',
                          style: PoppinsTextStyles.bodyMediumRegular),
                      CustomRoundedButtom(
                          title: 'Cancel',
                          onPressed: () {
                            locator<PocketbaseService>()
                                .cancelRequest(request.id)
                                .then((_) {
                              if (!context.mounted) return;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardWidget()),
                                  (route) => false);
                            }).onError((ClientException e, _) {
                              if (!context.mounted) return;
                              SnackBarUtils.showErrorBar(
                                  context: context,
                                  message: e.response.cast()["message"]);
                            });
                          })
                    ],
                  );
                }

                if (ride.status == RidesRecordStatusEnum.ongoing) {
                  final seats = ride.driver.vehicle['seatNumber'] as int;
                  final occupiedSeats =
                      ride.bookings == null ? 0 : ride.bookings!.length;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'Driver: ${ride.driver.firstName} ${ride.driver.lastName}',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      Text('Remaining Seats: ${seats - occupiedSeats}',
                          style: PoppinsTextStyles.headlineSmallRegular),
                      Text('PHP $price',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      Text(
                        'Drive has started. Please wait for the driver to arrive at your destination...',
                      ),
                    ],
                  );
                }

                if (request.status == RequestsRecordStatusEnum.accepted) {
                  final seats = ride.driver.vehicle['seatNumber'] as int;
                  final occupiedSeats =
                      ride.bookings == null ? 0 : ride.bookings!.length;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'Driver: ${ride.driver.firstName} ${ride.driver.lastName}',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      Text('Remaining Seats: ${seats - occupiedSeats}',
                          style: PoppinsTextStyles.headlineSmallRegular),
                      Text('PHP $price',
                          style: PoppinsTextStyles.headlineMediumRegular),
                      Text(
                        'Driver has accepted your request. Please wait for the driver to start the ride...',
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    Text('Request: ${request.status}'),
                    Text('Ride: ${ride.status}'),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        )),
      ]),
    );
  }
}
