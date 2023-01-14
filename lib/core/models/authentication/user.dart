// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @HiveType(typeId: userTypeId, adapterName: 'UserAdapter')
  const factory User({
    @HiveField(0) final String? firstName,
    @HiveField(1) final String? lastName,
    @HiveField(2) final String? email,
    @HiveField(3) final String? regDate,
    @HiveField(4) final String? regIp,
    @HiveField(5) final String? emailConfirm,
    @HiveField(6) final String? userType,
    @HiveField(7) final String? typeApproved,
    @HiveField(8) final String? phoneNumber,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
