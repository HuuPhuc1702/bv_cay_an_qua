// import 'package:bv_cay_an_qua/apis/core/errors.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'base_response.g.dart';

// // this is model for only my account
// @JsonSerializable(nullable: false)
// class BaseResponse {
//   bool success;
//   String message;
//   int code;
//   dynamic data;

//   BaseResponse(this.success, this.message, this.code, this.data);

//   factory BaseResponse.fromJson(Map<String, dynamic> json) {
//     final account = _$BaseResponseFromJson(json);
//     return account;
//   }
//   Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

//   ErrorType get errorType {
//     switch (code) {
//       case 401:
//         return ErrorType.OBJECT_NOT_FOUND;
//       case 402:
//         return ErrorType.PERMISSION_DENIED;
//       case 403:
//         return ErrorType.INVALID_DATA;
//       case 500:
//         return ErrorType.SYSTEM_ERROR;
//       default:
//         return ErrorType.UNKNOWN;
//     }
//   }
// }
