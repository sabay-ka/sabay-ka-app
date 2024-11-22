// GENERATED CODE - DO NOT MODIFY BY HAND
// *****************************************************
// POCKETBASE_UTILS
// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:collection/collection.dart' as _i3;
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart' as _i2;
import 'package:sabay_ka/models/bookings_record.dart';
import 'drivers_record.dart';

import 'base_record.dart' as _i1;
import 'empty_values.dart' as _i4;

enum RidesRecordFieldsEnum {
  id,
  created,
  updated,
  collectionId,
  collectionName,
  parkingLat,
  parkingLng,
  status,
  driver,
  bookings
}

enum RidesRecordStatusEnum {
  @JsonValue('waiting')
  waiting,
  @JsonValue('ongoing')
  ongoing,
  @JsonValue('cancelled')
  cancelled
}

@JsonSerializable()
final class RidesRecord extends _i1.BaseRecord {
  RidesRecord({
    required super.id,
    required super.created,
    required super.updated,
    required super.collectionId,
    required super.collectionName,
    required this.parkingLat,
    required this.parkingLng,
    required this.status,
    required this.driver,
    this.bookings,
  });

  factory RidesRecord.fromJson(Map<String, dynamic> json) {
    return RidesRecord(
      id: json['id'],
      created: json['created'] == null
          ? _i4.EmptyDateTime()
          : DateTime.tryParse(json['created'] as String) ?? _i4.EmptyDateTime(),
      updated: json['updated'] == null
          ? _i4.EmptyDateTime()
          : DateTime.tryParse(json['updated'] as String) ?? _i4.EmptyDateTime(),
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      parkingLat: (json['parkingLat'] as num).toDouble(),
      parkingLng: (json['parkingLng'] as num).toDouble(),
      status: RidesRecordStatusEnum.values.firstWhere(
          (e) => e.toString() == 'RidesRecordStatusEnum.${json['status']}'),
      driver: DriversRecord.fromJson(
          json['expand']['driver'] as Map<String, dynamic>),
      bookings: json['expand']['bookings'] == null
          ? null
          : (json['expand']['bookings'] as List<Map<String, dynamic>>).map((e) {
              return BookingsRecord.fromJson(e);
            }).toList(),
    );
  }
  factory RidesRecord.fromRecordModel(_i2.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      RidesRecordFieldsEnum.id.name: recordModel.id,
      RidesRecordFieldsEnum.created.name: recordModel.created,
      RidesRecordFieldsEnum.updated.name: recordModel.updated,
      RidesRecordFieldsEnum.collectionId.name: recordModel.collectionId,
      RidesRecordFieldsEnum.collectionName.name: recordModel.collectionName,
    };
    return RidesRecord.fromJson(extendedJsonMap);
  }

  final double parkingLat;

  final double parkingLng;

  final RidesRecordStatusEnum status;

  final DriversRecord driver;

  final List<BookingsRecord>? bookings;

  static const $collectionId = '2cwnig4w0yzy9y5';

  static const $collectionName = 'rides';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'collectionId': collectionId,
      'collectionName': collectionName,
      'parkingLat': parkingLat,
      'parkingLng': parkingLng,
      'status': status,
      'driver': driver.id,
      'expand': {
        'driver': driver.toJson(),
        'bookings': bookings?.map((e) => e.toJson()).toList(),
      },
    };
  }

  RidesRecord copyWith({
    double? parkingLat,
    double? parkingLng,
    RidesRecordStatusEnum? status,
    DriversRecord? driver,
    List<BookingsRecord>? bookings,
  }) {
    return RidesRecord(
      id: id,
      created: created,
      updated: updated,
      collectionId: collectionId,
      collectionName: collectionName,
      parkingLat: parkingLat ?? this.parkingLat,
      parkingLng: parkingLng ?? this.parkingLng,
      status: status ?? this.status,
      driver: driver ?? this.driver,
      bookings: bookings ?? this.bookings,
    );
  }

  Map<String, dynamic> takeDiff(RidesRecord other) {
    final thisInJsonMap = toJson();
    final otherInJsonMap = other.toJson();
    final Map<String, dynamic> result = {};
    final _i3.DeepCollectionEquality deepCollectionEquality =
        _i3.DeepCollectionEquality();
    for (final mapEntry in thisInJsonMap.entries) {
      final thisValue = mapEntry.value;
      final otherValue = otherInJsonMap[mapEntry.key];
      if (!deepCollectionEquality.equals(
        thisValue,
        otherValue,
      )) {
        result.addAll({mapEntry.key: otherValue});
      }
    }
    return result;
  }

  @override
  List<Object?> get props => [
        ...super.props,
        parkingLat,
        parkingLng,
        status,
        driver,
        bookings,
      ];

  static Map<String, dynamic> forCreateRequest({
    required double parkingLat,
    required double parkingLng,
    required RidesRecordStatusEnum status,
    required DriversRecord driver,
    List<BookingsRecord>? bookings,
  }) {
    final jsonMap = RidesRecord(
      id: '',
      created: _i4.EmptyDateTime(),
      updated: _i4.EmptyDateTime(),
      collectionId: $collectionId,
      collectionName: $collectionName,
      parkingLat: parkingLat,
      parkingLng: parkingLng,
      status: status,
      driver: driver,
      bookings: bookings,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      RidesRecordFieldsEnum.parkingLat.name:
          jsonMap[RidesRecordFieldsEnum.parkingLat.name]
    });
    result.addAll({
      RidesRecordFieldsEnum.parkingLng.name:
          jsonMap[RidesRecordFieldsEnum.parkingLng.name]
    });
    result.addAll({
      RidesRecordFieldsEnum.status.name:
          jsonMap[RidesRecordFieldsEnum.status.name]
    });
    result.addAll({
      RidesRecordFieldsEnum.driver.name:
          jsonMap[RidesRecordFieldsEnum.driver.name]
    });
    if (bookings != null) {
      result.addAll({
        RidesRecordFieldsEnum.bookings.name:
            jsonMap[RidesRecordFieldsEnum.bookings.name]
      });
    }
    return result;
  }
}
