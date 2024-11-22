// GENERATED CODE - DO NOT MODIFY BY HAND
// *****************************************************
// POCKETBASE_UTILS
// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:collection/collection.dart' as _i3;
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart' as _i2;

import 'base_record.dart' as _i1;
import 'empty_values.dart' as _i4;


enum RequestsRecordFieldsEnum {
  id,
  created,
  updated,
  collectionId,
  collectionName,
  ride,
  passenger,
  destLat,
  destLong,
  rowIdx,
  columnIdx,
  status
}

enum RequestsRecordStatusEnum {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('rejected')
  rejected,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled
}

@JsonSerializable()
final class RequestsRecord extends _i1.BaseRecord {
  RequestsRecord({
    required super.id,
    required super.created,
    required super.updated,
    required super.collectionId,
    required super.collectionName,
    required this.ride,
    required this.passenger,
    required this.destLat,
    required this.destLong,
    required this.rowIdx,
    required this.columnIdx,
    required this.status,
  });

  factory RequestsRecord.fromJson(Map<String, dynamic> json) {
    return RequestsRecord(
      id: json['id'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      ride: json['ride'],
      passenger: json['passenger'],
      destLat: (json['destLat'] as num).toDouble(),
      destLong: (json['destLong'] as num).toDouble(),
      rowIdx: (json['rowIdx'] as num).toDouble(),
      columnIdx: (json['columnIdx'] as num).toDouble(),
      status: RequestsRecordStatusEnum.values
          .firstWhere((e) => e.toString() == 'RequestsRecordStatusEnum.${json['status']}'), 
    );
  } 


  factory RequestsRecord.fromRecordModel(_i2.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      RequestsRecordFieldsEnum.id.name: recordModel.id,
      RequestsRecordFieldsEnum.created.name: recordModel.created,
      RequestsRecordFieldsEnum.updated.name: recordModel.updated,
      RequestsRecordFieldsEnum.collectionId.name: recordModel.collectionId,
      RequestsRecordFieldsEnum.collectionName.name: recordModel.collectionName,
    };
    return RequestsRecord.fromJson(extendedJsonMap);
  }

  final String ride;

  final String passenger;

  final double destLat;

  final double destLong;

  final double rowIdx;

  final double columnIdx;

  final RequestsRecordStatusEnum status;

  static const $collectionId = 'jx7actt4u4sjv31';

  static const $collectionName = 'requests';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'collectionId': collectionId,
      'collectionName': collectionName,
      'ride': ride,
      'passenger': passenger,
      'destLat': destLat,
      'destLong': destLong,
      'rowIdx': rowIdx,
      'columnIdx': columnIdx,
      'status': status
    };
  }

  RequestsRecord copyWith({
    String? ride,
    String? passenger,
    double? destLat,
    double? destLong,
    double? rowIdx,
    double? columnIdx,
    RequestsRecordStatusEnum? status,
  }) {
    return RequestsRecord(
      id: id,
      created: created,
      updated: updated,
      collectionId: collectionId,
      collectionName: collectionName,
      ride: ride ?? this.ride,
      passenger: passenger ?? this.passenger,
      destLat: destLat ?? this.destLat,
      destLong: destLong ?? this.destLong,
      rowIdx: rowIdx ?? this.rowIdx,
      columnIdx: columnIdx ?? this.columnIdx,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> takeDiff(RequestsRecord other) {
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
        ride,
        passenger,
        destLat,
        destLong,
        rowIdx,
        columnIdx,
        status,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String ride,
    required String passenger,
    required double destLat,
    required double destLong,
    required double rowIdx,
    required double columnIdx,
    required RequestsRecordStatusEnum status,
  }) {
    final jsonMap = RequestsRecord(
      id: '',
      created: _i4.EmptyDateTime(),
      updated: _i4.EmptyDateTime(),
      collectionId: $collectionId,
      collectionName: $collectionName,
      ride: ride,
      passenger: passenger,
      destLat: destLat,
      destLong: destLong,
      rowIdx: rowIdx,
      columnIdx: columnIdx,
      status: status,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      RequestsRecordFieldsEnum.ride.name:
          jsonMap[RequestsRecordFieldsEnum.ride.name]
    });
    result.addAll({
      RequestsRecordFieldsEnum.passenger.name:
          jsonMap[RequestsRecordFieldsEnum.passenger.name]
    });
    result.addAll({
      RequestsRecordFieldsEnum.destLat.name:
          jsonMap[RequestsRecordFieldsEnum.destLat.name]
    });
    result.addAll({
      RequestsRecordFieldsEnum.destLong.name:
          jsonMap[RequestsRecordFieldsEnum.destLong.name]
    });
    result.addAll({
      RequestsRecordFieldsEnum.rowIdx.name:
          jsonMap[RequestsRecordFieldsEnum.rowIdx.name]
    });
    result.addAll({
      RequestsRecordFieldsEnum.columnIdx.name:
          jsonMap[RequestsRecordFieldsEnum.columnIdx.name]
    });
    result.addAll({
      RequestsRecordFieldsEnum.status.name:
          jsonMap[RequestsRecordFieldsEnum.status.name]
    });
    return result;
  }
}
