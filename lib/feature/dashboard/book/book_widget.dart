import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:form_validator/form_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nominatim_flutter/model/request/request.dart';
import 'package:nominatim_flutter/nominatim_flutter.dart';
import 'package:sabay_ka/app/app_drawer.dart';
import 'package:sabay_ka/app/text_style.dart';
import 'package:sabay_ka/common/theme.dart';
import 'package:sabay_ka/common/widget/common_container.dart';
import 'package:sabay_ka/common/widget/custom_button.dart';
import 'package:sabay_ka/common/widget/custom_text_field.dart';
import 'package:sabay_ka/feature/dashboard/book/available_ride_widget.dart';
import 'package:sabay_ka/feature/dashboard/book/select_address_widget.dart';
import 'package:sabay_ka/feature/dashboard/homeScreen/widget/home_page_topbar.dart';

class BookWidget extends StatefulWidget {
  const BookWidget({super.key});

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  final _searchController = TextEditingController();
  // Start with User's current location
  GeoPoint? _destination;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _locateUser();
    super.initState();
  }

  Future<void> _locateUser() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    final location = await Geolocator.getCurrentPosition();
    setState(() {
      _destination = GeoPoint(
        latitude: location.latitude,
        longitude: location.longitude,
      );
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.lightColor,
      drawer: CustomDrawer(),
      key: _scaffoldKey,
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageTopBar(
                onTap: () {
                  if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                    _scaffoldKey.currentState!.openDrawer();
                  } else {
                    _scaffoldKey.currentState!.openEndDrawer();
                  }
                },
              ),
              Text('Destination'),
              Form(
                key: _formKey,
                child: ReusableTextField(
                  controller: _searchController,
                  validator: ValidationBuilder().required().build(),
                  onTap: () async {
                    if (_destination == null) {
                      return;
                    }

                    var p = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SelectAddressWidget(initPosition: _destination!),
                        ));

                    if (p != null) {
                      final reverseRequest = ReverseRequest(
                        lat: p.latitude,
                        lon: p.longitude,
                        addressDetails: true,
                        nameDetails: true,
                      );
                      final reverseResult = await NominatimFlutter.instance
                          .reverse(reverseRequest: reverseRequest);
                      setState(() {
                        _destination = p;
                        _searchController.text =
                            reverseResult.displayName ?? '';
                        _searchController.selection =
                            TextSelection.fromPosition(TextPosition(offset: 0));
                      });
                    }
                  },
                ),
              ),
              CustomRoundedButtom(
                  color: Colors.transparent,
                  borderColor: CustomTheme.appColor,
                  title: "Request Booking",
                  textColor: CustomTheme.appColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AvailableRideWidget(destination: _destination!),
                        ),
                      );
                    }
                  }),
            ],
          )),
    );
  }
}
