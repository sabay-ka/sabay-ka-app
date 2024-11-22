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
import 'package:sabay_ka/models/payments_record.dart';

import 'base_record.dart' as _i1;
import 'empty_values.dart' as _i4;


enum BookingsRecordFieldsEnum {
  id,
  created,
  updated,
  collectionId,
  collectionName,
  passenger,
  payment,
  destLat,
  destLang,
  columnIdx,
  rowIdx,
  paymentRecord
}

@JsonSerializable()
final class BookingsRecord extends _i1.BaseRecord {
  BookingsRecord({
    required super.id,
    required super.created,
    required super.updated,
    required super.collectionId,
    required super.collectionName,
    required this.passenger,
    required this.payment,
    required this.destLat,
    required this.destLang,
    required this.columnIdx,
    required this.rowIdx,
    this.paymentsRecord
  });

  factory BookingsRecord.fromJson(Map<String, dynamic> json, [ Map<String, dynamic>? paymentJson = null ]) {
    PaymentsRecord? payment;
    if (paymentJson != null) {
      payment = PaymentsRecord.fromJson(paymentJson);
    }
    return BookingsRecord(
      id: json['id'],
      created: json['created'] == null
          ? _i4.EmptyDateTime()
          : DateTime.tryParse(json['created'] as String) ?? _i4.EmptyDateTime(), 
      updated: json['updated'] == null
          ? _i4.EmptyDateTime()
          : DateTime.tryParse(json['updated'] as String) ?? _i4.EmptyDateTime(),
      collectionId: json['collectionId'] as String? ?? '',
      collectionName: json['collectionName'] as String? ?? '',
      passenger: json['passenger'] as String,
      payment: json['payment'] as String,
      destLat: (json['destLat'] as num).toDouble(),
      destLang: (json['destLng'] as num).toDouble(),
      columnIdx: (json['columnIdx'] as num).toDouble(),
      rowIdx: (json['rowIdx'] as num).toDouble(),
      paymentsRecord: payment
    );
  }

  factory BookingsRecord.fromRecordModel(_i2.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      BookingsRecordFieldsEnum.id.name: recordModel.id,
      BookingsRecordFieldsEnum.created.name: recordModel.created,
      BookingsRecordFieldsEnum.updated.name: recordModel.updated,
      BookingsRecordFieldsEnum.collectionId.name: recordModel.collectionId,
      BookingsRecordFieldsEnum.collectionName.name: recordModel.collectionName,
    };
    return BookingsRecord.fromJson(extendedJsonMap);
  }

  final String passenger;

  final String payment;

  final double destLat;

  final double destLang;

  final double columnIdx;

  final double rowIdx;

  final PaymentsRecord? paymentsRecord;

  static const $collectionId = '8vx8f44gbe71fqc';

  static const $collectionName = 'bookings';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'collectionId': collectionId,
      'collectionName': collectionName,
      'passenger': passenger,
      'payment': payment,
      'destLat': destLat,
      'destLang': destLang,
      'columnIdx': columnIdx,
      'rowIdx': rowIdx,
    };
  }

  BookingsRecord copyWith({
    String? passenger,
    String? payment,
    double? destLat,
    double? destLang,
    double? columnIdx,
    double? rowIdx,
    PaymentsRecord? paymentRecord
  }) {
    return BookingsRecord(
      id: id,
      created: created,
      updated: updated,
      collectionId: collectionId,
      collectionName: collectionName,
      passenger: passenger ?? this.passenger,
      payment: payment ?? this.payment,
      destLat: destLat ?? this.destLat,
      destLang: destLang ?? this.destLang,
      columnIdx: columnIdx ?? this.columnIdx,
      rowIdx: rowIdx ?? this.rowIdx,
      paymentsRecord: paymentRecord ?? this.paymentsRecord
    );
  }

  Map<String, dynamic> takeDiff(BookingsRecord other) {
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
        passenger,
        payment,
        destLat,
        destLang,
        columnIdx,
        rowIdx,
        paymentsRecord
      ];

  static Map<String, dynamic> forCreateRequest({
    required String passenger,
    required String payment,
    required double destLat,
    required double destLang,
    required double columnIdx,
    required double rowIdx,
  }) {
    final jsonMap = BookingsRecord(
      id: '',
      created: _i4.EmptyDateTime(),
      updated: _i4.EmptyDateTime(),
      collectionId: $collectionId,
      collectionName: $collectionName,
      passenger: passenger,
      payment: payment,
      destLat: destLat,
      destLang: destLang,
      columnIdx: columnIdx,
      rowIdx: rowIdx,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      BookingsRecordFieldsEnum.passenger.name:
          jsonMap[BookingsRecordFieldsEnum.passenger.name]
    });
    result.addAll({
      BookingsRecordFieldsEnum.payment.name:
          jsonMap[BookingsRecordFieldsEnum.payment.name]
    });
    result.addAll({
      BookingsRecordFieldsEnum.destLat.name:
          jsonMap[BookingsRecordFieldsEnum.destLat.name]
    });
    result.addAll({
      BookingsRecordFieldsEnum.destLang.name:
          jsonMap[BookingsRecordFieldsEnum.destLang.name]
    });
    result.addAll({
      BookingsRecordFieldsEnum.columnIdx.name:
          jsonMap[BookingsRecordFieldsEnum.columnIdx.name]
    });
    result.addAll({
      BookingsRecordFieldsEnum.rowIdx.name:
          jsonMap[BookingsRecordFieldsEnum.rowIdx.name]
    });
    return result;
  }
}
