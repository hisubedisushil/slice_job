import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required final bool status,
    required final String message,
    required final T data,
  }) = BaseResponse;

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ApiResponsePaginated<T> with _$ApiResponsePaginated<T> {
  const factory ApiResponsePaginated({
    required final bool status,
    required final String message,
    required final String total,
    required final String page,
    required final T data,
  }) = BaseResponsePaginated;

  factory ApiResponsePaginated.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ApiResponsePaginatedFromJson(json, fromJsonT);
}

@Freezed(genericArgumentFactories: true)
class ResponseData<T> with _$ResponseData<T> {
  const factory ResponseData.list({
    required final List<T> data,
  }) = ResponseDataList;
  const factory ResponseData.map({
    required final T data,
  }) = ResponseDataMap;

  factory ResponseData.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ResponseDataFromJson(json, fromJsonT);
}
