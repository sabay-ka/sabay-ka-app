// Copyright (C) 2019-2024, Magic Lane B.V.
// All rights reserved.
//
// This software is confidential and proprietary information of Magic Lane
// ("Confidential Information"). You shall not disclose such Confidential
// Information and shall use it only in accordance with the terms of the
// license agreement you entered into with Magic Lane.

/// Error codes.
///
/// {@category Core}
enum GemError {
  /// Success
  success,

  /// General error.
  general,

  /// Activation required to perform the request.
  activation,

  /// Operation canceled.
  cancel,

  /// Feature not supported.
  notSupported,

  /// Item already exists.
  exist,

  /// I/O error.
  io,

  /// Access denied.
  accessDenied,

  /// Read-only drive.
  readonlyDrive,

  /// Not enough disk space available.
  noDiskSpace,

  /// Item in use.
  inUse,

  /// Required item not found.
  notFound,

  /// Index out of range.
  outOfRange,

  /// Content was updated.
  invalidated,

  /// Not enough memory to complete the request.
  noMemory,

  /// Invalid input provided.
  invalidInput,

  /// Reduced results returned.
  reducedResult,

  /// Additional data required.
  required,

  /// No route possible.
  noRoute,

  /// One or more way points not accessible.
  waypointAccess,

  /// Requested route is too long.
  routeTooLong,

  /// Operation internally aborted.
  internalAbort,

  /// Connection failed.
  connection,

  /// Network connection failed.
  networkFailed,

  /// No connection available.
  noConnection,

  /// Connection required to perform the request.
  connectionRequired,

  /// Data sending failed.
  sendFailed,

  /// Data receiving failed.
  recvFailed,

  /// Operation could not start.
  couldNotStart,

  /// Network operation timeout.
  networkTimeout,

  /// Network couldn't resolve host
  networkCouldntResolveHost,

  /// Network couldn't resolve proxy
  networkCouldntResolveProxy,

  /// Network couldn't resume download
  networkCouldntResume,

  /// Not logged in.
  notLoggedIn,

  /// Operation suspended/paused.
  suspended,

  /// Content is up-to-date.
  upToDate,

  /// Internal engine resource is missing
  resourceMissing,

  /// Internal operation aborted due to timer timeout
  operationTimeout,

  /// Requested operation cannot be performed. Internal limit reached.
  busy,

  /// Content is expired.
  expired,

  /// The engine needs to be initialized before calling this
  engineNotInitialized,

  /// Operation couldn't be completed but was scheduled for later.
  scheduled,

  /// Network SSL connect error
  sslConnectFail,

  /// Device has low battery
  lowBattery,

  /// Device is overheated
  overheated,

  /// Missing SDK capability
  missingCapability,

  /// Recorded log is too short
  recordedLogTooShort,
}

/// @nodoc
///
/// {@category Core}
extension GemErrorExtension on GemError {
  int get code {
    switch (this) {
      case GemError.success:
        return 0;
      case GemError.general:
        return -1;
      case GemError.activation:
        return -2;
      case GemError.cancel:
        return -3;
      case GemError.notSupported:
        return -4;
      case GemError.exist:
        return -5;
      case GemError.io:
        return -6;
      case GemError.accessDenied:
        return -7;
      case GemError.readonlyDrive:
        return -8;
      case GemError.noDiskSpace:
        return -9;
      case GemError.inUse:
        return -10;
      case GemError.notFound:
        return -11;
      case GemError.outOfRange:
        return -12;
      case GemError.invalidated:
        return -13;
      case GemError.noMemory:
        return -14;
      case GemError.invalidInput:
        return -15;
      case GemError.reducedResult:
        return -16;
      case GemError.required:
        return -17;
      case GemError.noRoute:
        return -18;
      case GemError.waypointAccess:
        return -19;
      case GemError.routeTooLong:
        return -20;
      case GemError.internalAbort:
        return -21;
      case GemError.connection:
        return -22;
      case GemError.networkFailed:
        return -23;
      case GemError.noConnection:
        return -24;
      case GemError.connectionRequired:
        return -25;
      case GemError.sendFailed:
        return -26;
      case GemError.recvFailed:
        return -27;
      case GemError.couldNotStart:
        return -28;
      case GemError.networkTimeout:
        return -29;
      case GemError.networkCouldntResolveHost:
        return -30;
      case GemError.networkCouldntResolveProxy:
        return -31;
      case GemError.networkCouldntResume:
        return -32;
      case GemError.notLoggedIn:
        return -33;
      case GemError.suspended:
        return -34;
      case GemError.upToDate:
        return -35;
      case GemError.resourceMissing:
        return -36;
      case GemError.operationTimeout:
        return -37;
      case GemError.busy:
        return -38;
      case GemError.expired:
        return -39;
      case GemError.engineNotInitialized:
        return -40;
      case GemError.scheduled:
        return -41;
      case GemError.sslConnectFail:
        return -42;
      case GemError.lowBattery:
        return -43;
      case GemError.overheated:
        return -44;
      case GemError.missingCapability:
        return -45;
      case GemError.recordedLogTooShort:
        return -46;
    }
  }

  static GemError fromCode(int code) {
    switch (code) {
      case 0:
        return GemError.success;
      case -1:
        return GemError.general;
      case -2:
        return GemError.activation;
      case -3:
        return GemError.cancel;
      case -4:
        return GemError.notSupported;
      case -5:
        return GemError.exist;
      case -6:
        return GemError.io;
      case -7:
        return GemError.accessDenied;
      case -8:
        return GemError.readonlyDrive;
      case -9:
        return GemError.noDiskSpace;
      case -10:
        return GemError.inUse;
      case -11:
        return GemError.notFound;
      case -12:
        return GemError.outOfRange;
      case -13:
        return GemError.invalidated;
      case -14:
        return GemError.noMemory;
      case -15:
        return GemError.invalidInput;
      case -16:
        return GemError.reducedResult;
      case -17:
        return GemError.required;
      case -18:
        return GemError.noRoute;
      case -19:
        return GemError.waypointAccess;
      case -20:
        return GemError.routeTooLong;
      case -21:
        return GemError.internalAbort;
      case -22:
        return GemError.connection;
      case -23:
        return GemError.networkFailed;
      case -24:
        return GemError.noConnection;
      case -25:
        return GemError.connectionRequired;
      case -26:
        return GemError.sendFailed;
      case -27:
        return GemError.recvFailed;
      case -28:
        return GemError.couldNotStart;
      case -29:
        return GemError.networkTimeout;
      case -30:
        return GemError.networkCouldntResolveHost;
      case -31:
        return GemError.networkCouldntResolveProxy;
      case -32:
        return GemError.networkCouldntResume;
      case -33:
        return GemError.notLoggedIn;
      case -34:
        return GemError.suspended;
      case -35:
        return GemError.upToDate;
      case -36:
        return GemError.resourceMissing;
      case -37:
        return GemError.operationTimeout;
      case -38:
        return GemError.busy;
      case -39:
        return GemError.expired;
      case -40:
        return GemError.engineNotInitialized;
      case -41:
        return GemError.scheduled;
      case -42:
        return GemError.sslConnectFail;
      case -43:
        return GemError.lowBattery;
      case -44:
        return GemError.overheated;
      case -45:
        return GemError.missingCapability;
      case -46:
        return GemError.recordedLogTooShort;
      default:
        throw ArgumentError('Invalid GemError code: $code');
    }
  }
}
