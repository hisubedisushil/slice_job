// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:slice_job/app_setup/hive/hive_setup.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
class Profile with _$Profile {
  @HiveType(typeId: profileTypeId, adapterName: 'ProfileAdapter')
  const factory Profile({
    @HiveField(0) final String? firstName,
    @HiveField(1) final String? lastName,
    @HiveField(2) final String? email,
    @HiveField(3) final String? mobileNumber,
    @HiveField(4) final String? gender,
    @HiveField(5) final String? dob,
    @HiveField(6) final String? qualification,
    @HiveField(7) final String? experience,
    @HiveField(8) final String? nationality,
    @HiveField(9) final String? currCountry,
    @HiveField(10) final String? currCity,
    @HiveField(11) final String? photo,
    @HiveField(12) final String? regDate,
    @HiveField(13) final String? userType,
    @HiveField(14) final String? isPremium,
    @HiveField(15) final String? premiumDtart,
    @HiveField(16) final String? premiumEnd,

  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}
