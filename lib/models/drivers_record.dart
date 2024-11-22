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

import 'auth_record.dart' as _i1;
import 'empty_values.dart' as _i4;


enum DriversRecordFieldsEnum {
  id,
  created,
  updated,
  collectionId,
  collectionName,
  username,
  email,
  emailVisibility,
  verified,

  /// THIS FIELD IS ONLY FOR CREATING AN AUTH TYPE RECORD
  password,

  /// THIS FIELD IS ONLY FOR CREATING AN AUTH TYPE RECORD
  passwordConfirm,
  firstName,
  lastName,
  phoneNumber,
  plateNumber,
  avatar,
  vehicle,
  vehicleImages
}

@JsonSerializable()
final class DriversRecord extends _i1.AuthRecord {
  DriversRecord({
    required super.id,
    required super.created,
    required super.updated,
    required super.collectionId,
    required super.collectionName,
    required super.username,
    required super.email,
    required super.emailVisibility,
    required super.verified,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.plateNumber,
    this.avatar,
    this.vehicle,
    this.vehicleImages,
  });

  factory DriversRecord.fromJson(Map<String, dynamic> json) {
    return DriversRecord(
      id: json['id'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      username: json['username'],
      email: json['email'],
      emailVisibility: json['emailVisibility'],
      verified: json['verified'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      plateNumber: json['plateNumber'],
      avatar: json['avatar'],
      vehicle: json['vehicle'],
      vehicleImages: json['vehicleImages']?.cast<String>(),
    );
  }

  factory DriversRecord.fromRecordModel(_i2.RecordModel recordModel) {
    final extendedJsonMap = {
      ...recordModel.data,
      DriversRecordFieldsEnum.id.name: recordModel.id,
      DriversRecordFieldsEnum.created.name: recordModel.created,
      DriversRecordFieldsEnum.updated.name: recordModel.updated,
      DriversRecordFieldsEnum.collectionId.name: recordModel.collectionId,
      DriversRecordFieldsEnum.collectionName.name: recordModel.collectionName,
    };
    return DriversRecord.fromJson(extendedJsonMap);
  }

  final String firstName;

  final String lastName;

  final String phoneNumber;

  final String plateNumber;

  final String? avatar;

  final dynamic vehicle;

  final List<String>? vehicleImages;

  static const $collectionId = '029vho1f6z15y88';

  static const $collectionName = 'drivers';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'collectionId': collectionId,
      'collectionName': collectionName,
      'username': username,
      'email': email,
      'emailVisibility': emailVisibility,
      'verified': verified,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'plateNumber': plateNumber,
      'avatar': avatar,
      'vehicle': vehicle,
      'vehicleImages': vehicleImages,
    };
  }

  DriversRecord copyWith({
    String? username,
    String? email,
    bool? emailVisibility,
    bool? verified,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? plateNumber,
    String? avatar,
    dynamic vehicle,
    List<String>? vehicleImages,
  }) {
    return DriversRecord(
      id: id,
      created: created,
      updated: updated,
      collectionId: collectionId,
      collectionName: collectionName,
      username: username ?? this.username,
      email: email ?? this.email,
      emailVisibility: emailVisibility ?? this.emailVisibility,
      verified: verified ?? this.verified,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      plateNumber: plateNumber ?? this.plateNumber,
      avatar: avatar ?? this.avatar,
      vehicle: vehicle ?? this.vehicle,
      vehicleImages: vehicleImages ?? this.vehicleImages,
    );
  }

  Map<String, dynamic> takeDiff(DriversRecord other) {
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
        plateNumber,
        avatar,
        vehicle,
        vehicleImages,
      ];

  static Map<String, dynamic> forCreateRequest({
    required String username,
    required String email,
    required bool emailVisibility,
    required bool verified,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String plateNumber,
    String? avatar,
    dynamic vehicle,
    List<String>? vehicleImages,
  }) {
    final jsonMap = DriversRecord(
      id: '',
      created: _i4.EmptyDateTime(),
      updated: _i4.EmptyDateTime(),
      collectionId: $collectionId,
      collectionName: $collectionName,
      username: username,
      email: email,
      emailVisibility: emailVisibility,
      verified: verified,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      plateNumber: plateNumber,
      avatar: avatar,
      vehicle: vehicle,
      vehicleImages: vehicleImages,
    ).toJson();
    final Map<String, dynamic> result = {};
    result.addAll({
      DriversRecordFieldsEnum.username.name:
          jsonMap[DriversRecordFieldsEnum.username.name]
    });
    result.addAll({
      DriversRecordFieldsEnum.email.name:
          jsonMap[DriversRecordFieldsEnum.email.name]
    });
    result.addAll({
      DriversRecordFieldsEnum.emailVisibility.name:
          jsonMap[DriversRecordFieldsEnum.emailVisibility.name]
    });
    result.addAll({
      DriversRecordFieldsEnum.verified.name:
          jsonMap[DriversRecordFieldsEnum.verified.name]
    });
    result.addAll({
      DriversRecordFieldsEnum.firstName.name:
          jsonMap[DriversRecordFieldsEnum.firstName.name]
    });
    result.addAll({
      DriversRecordFieldsEnum.lastName.name:
          jsonMap[DriversRecordFieldsEnum.lastName.name]
    });
    result.addAll({
      DriversRecordFieldsEnum.phoneNumber.name:
          jsonMap[DriversRecordFieldsEnum.phoneNumber.name]
    });
    result.addAll({
      DriversRecordFieldsEnum.plateNumber.name:
          jsonMap[DriversRecordFieldsEnum.plateNumber.name]
    });
    if (avatar != null) {
      result.addAll({
        DriversRecordFieldsEnum.avatar.name:
            jsonMap[DriversRecordFieldsEnum.avatar.name]
      });
    }
    if (vehicle != null) {
      result.addAll({
        DriversRecordFieldsEnum.vehicle.name:
            jsonMap[DriversRecordFieldsEnum.vehicle.name]
      });
    }
    if (vehicleImages != null) {
      result.addAll({
        DriversRecordFieldsEnum.vehicleImages.name:
            jsonMap[DriversRecordFieldsEnum.vehicleImages.name]
      });
    }
    return result;
  }
}
