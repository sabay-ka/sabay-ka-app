import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/utils/snackbar_utils.dart';
import 'package:sabay_ka/common/widget/custom_button.dart';
import 'package:sabay_ka/feature/dashboard/dashboard_widget.dart';
import 'package:sabay_ka/main.dart';
import 'package:sabay_ka/models/payments_record.dart';
import 'package:sabay_ka/models/requests_record.dart';
import 'package:sabay_ka/models/rides_record.dart';
import 'package:sabay_ka/services/pocketbase_service.dart';

class WatchRide extends StatefulWidget {
  const WatchRide(
      {super.key, required this.requestId, required this.rideId, this.price});

  final String requestId;
  final String rideId;
  final double? price;

  @override
  State<WatchRide> createState() => _WatchRideState();
}

class RequestandRideRecord {
  final RequestsRecord request;
  final RidesRecord ride;
  final double price;

  RequestandRideRecord(this.request, this.ride, this.price);
}

class _WatchRideState extends State<WatchRide> {
  late RequestsRecord _prevRequest;
  late RidesRecord _prevRide;
  late double _price;
  late String _paymentId;

  late final StreamController<RequestandRideRecord> _controller =
      StreamController<RequestandRideRecord>(
    onListen: () async {
      // First fetch
      if (!_controller.isClosed) {
        final [request, ride] = await Future.wait([
          locator<PocketbaseService>().getRequest(widget.requestId),
          locator<PocketbaseService>().getRide(widget.rideId),
        ]);
        _prevRequest = request as RequestsRecord;
        _prevRide = ride as RidesRecord;
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
        ));
      }

      // Listen to changes
      locator<PocketbaseService>().subscribeToRequest(widget.requestId,
          (event) async {
        if (!_controller.isClosed) {
          _prevRequest =
              await locator<PocketbaseService>().getRequest(widget.requestId);

          _controller
              .add(RequestandRideRecord(_prevRequest, _prevRide, _price));
        }
      });
      locator<PocketbaseService>().subscribeToRide(widget.rideId,
          (event) async {
        if (!_controller.isClosed) {
          _prevRide = await locator<PocketbaseService>().getRide(widget.rideId);

          _controller
              .add(RequestandRideRecord(_prevRequest, _prevRide, _price));
        }
      });
    },
  );

  late final StreamController<bool> _isPaidController =
      StreamController(onListen: () async {
    if (!_isPaidController.isClosed) {
      final booking = await locator<PocketbaseService>()
          .getBookingByRequest(widget.requestId);
      _paymentId = booking.payment;
      _isPaidController.add(
          booking.paymentsRecord!.status == PaymentsRecordStatusEnum.completed);
    }

    locator<PocketbaseService>().subscribeToPayment(_paymentId, (event) async {
      if (!_isPaidController.isClosed) {
        final payment =
            await locator<PocketbaseService>().getPayment(_paymentId);
        _isPaidController
            .add(payment.status == PaymentsRecordStatusEnum.completed);
      }
    });
  });

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
    if (!_isPaidController.isClosed) {
      _isPaidController.close();
    }
    locator<PocketbaseService>().unsubscribeToPayment(_paymentId);
    super.dispose();
  }

  Stream<RequestandRideRecord> get _requestRide => _controller.stream;
  Stream<bool> get _isPaid => _isPaidController.stream;

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

                if (request.status == RequestsRecordStatusEnum.completed) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          'Driver: ${ride.driver.firstName} ${ride.driver.lastName}', style: PoppinsTextStyles.headlineMediumRegular),
                      Text('PHP $price', style: PoppinsTextStyles.headlineMediumRegular),
                      StreamBuilder(
                          stream: _isPaid,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('$snapshot.error.toString()');
                            }
                            if (snapshot.hasData) {
                              final isPaid = snapshot.data as bool;
                              if (!isPaid) {
                                return Text(
                                    'You have arrived at your destination. Please pay the driver',
                                    style: PoppinsTextStyles
                                        .headlineMediumRegular);
                              }

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardWidget()),
                                  (route) => false);
                              return Text('Payment has been completed');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
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
                          'Driver: ${ride.driver.firstName} ${ride.driver.lastName}', style: PoppinsTextStyles.headlineMediumRegular),
                      Text('Remaining Seats: ${seats - occupiedSeats}', style: PoppinsTextStyles.headlineSmallRegular),
                      Text('PHP $price', style: PoppinsTextStyles.headlineMediumRegular),
                      Text('Waiting for the driver to accept your request', style: PoppinsTextStyles.bodyMediumRegular),
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
                          'Drive has started. Please wait for the driver to arrive at your destination...',),
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
