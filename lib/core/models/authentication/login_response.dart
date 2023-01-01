// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class AuthData with _$AuthData {
  @HiveType(typeId: authDataTypeId, adapterName: 'AuthDataAdapter')
  const factory AuthData({
    @HiveField(0) required final String token,
    @HiveField(1) required final String email,
    @HiveField(2) final int? expiresAt,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}
