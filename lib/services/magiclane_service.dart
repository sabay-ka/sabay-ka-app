import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:http/http.dart' as http;

abstract class MagicLaneService extends ChangeNotifier {
  Future<List<GeoPoint>> getRoute({ required GeoPoint startPoint, required List<GeoPoint> waypoints }); 
}

class MagicLaneServiceImpl extends MagicLaneService {
  MagicLaneServiceImpl._create() {
    // Initialize the service
  }

  @override
  Future<List<GeoPoint>> getRoute({required GeoPoint startPoint, required List<GeoPoint> waypoints}) async {
    final res = await http.post(
      Uri.parse('https://routes.magiclaneapis.com/v1'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': FlutterConfig.get('MAGICLANE_API_KEY'),
      },
      body: jsonEncode({
        'waypoints': waypoints.map((waypoint) => [waypoint.latitude, waypoint.longitude]).toList(),
        'avoid': ['traffic']
      })
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final points = data['points']['coordinates'] as List<List<double>>;
      return points.map((point) => GeoPoint(latitude: point[0], longitude: point[1])).toList();
    }

    return [];
  }
}
