// enum ErrorType {
//   NETWORK_ERROR,
//   AUTH_FAIL,
//   OBJECT_NOT_FOUND,
//   PERMISSION_DENIED,
//   INVALID_DATA,
//   SYSTEM_ERROR,
//   UNSUPPORT_TYPE,
//   WRONG_CURRENT_PASSWORD,
//   UNKNOWN
// }

// class NetServiceError implements Exception {
//   final ErrorType? type;
//   final String? message;
//   NetServiceError({this.type, this.message});
//   String toString() => "$message";
// }

// class BusinessError extends Error {
//   final String? message;
//   final int? code;
//   BusinessError({this.message, this.code});
//   String toString() => "$message";
// }

// class NetworkError extends Error {
//   final String ?message;
//   final int? code;
//   NetworkError({this.message, this.code});
//   String toString() => "$message";
// }
