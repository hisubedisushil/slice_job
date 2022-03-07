import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../controllers/dio_controller.dart';
import '../models/profile_model.dart';
import '../models/profile_response_model.dart';

class ProfileService {
  static ProfileService service = ProfileService();

  Future<ProfileModel?> getProfile({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('profile');
      log(
        prettyJson(response.data),
        name: 'Get Profile Response',
      );
      if (response.statusCode == 200) {
        ProfileResponseModel model = profileResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data;
      } else {
        return null;
      }
    } on Exception catch (e, s) {
      log('Get Profile Error!', stackTrace: s, error: e);
      return null;
    }
  }
}
