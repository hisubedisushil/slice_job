import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../constants/app_apis.dart';
import '../controllers/dio_controller.dart';
import '../models/appled_job_model.dart';
import '../models/applied_jobs_response_model.dart';
import '../models/certificate_list_response_model.dart';
import '../models/certificate_model.dart';
import '../models/education_list_response_model.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';
import '../models/language_list_response_model.dart';
import '../models/language_model.dart';
import '../models/profile_model.dart';
import '../models/profile_response_model.dart';
import '../models/skill_list_response_model.dart';
import '../models/skill_model.dart';
import '../models/training_list_response_model.dart';
import '../models/training_model.dart';
import '../models/work_experience_list_response_model.dart';
import 'preference_service.dart';

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

  Future<bool> updateProfile({
    required DioController dio,
    required String firstName,
    required String lastName,
    required String dob,
    required String nationality,
    required String gender,
    required String currentCity,
    required String qualification,
    required String experience,
    required String mobile,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'profile-update',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'dob': dob,
          'nationality': nationality,
          'gender': gender,
          'curr_country': currentCity,
          'curr_city': qualification,
          'qualification': qualification,
          'experience': experience,
          'mobile_number': mobile,
        },
      );

      log(prettyJson(response.data), name: 'Update Profile Response');

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return false;
        }
        return true;
      } else {
        return false;
      }
    } on Exception catch (e, s) {
      log('Update Profile Error!', stackTrace: s, error: e);
      return false;
    }
  }

  Future<String> changePassword({
    required DioController dio,
    required String oldPassword,
    required String password,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'change-password',
        data: {
          'old_password': oldPassword,
          'password': password,
        },
      );

      log(prettyJson(response.data), name: 'Change Password Response');

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log('Change Password Error!', stackTrace: s, error: e);
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<List<AppliedJobModel>> getAppliedJobs({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('applied-jobs');
      log(prettyJson(response.data), name: 'Get Applied Jobs Response');
      if (response.statusCode == 200) {
        AppliedJobsResponseModel model = appliedJobsResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('Get Applied Jobs Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<String> updateCVBasicInformation({
    required DioController dio,
    required String firstName,
    required String lastName,
    required String birthDay,
    required String birthMonth,
    required String birthYear,
    required String gender,
    required String nationality,
    required String maritalStatus,
    required String currentCountry,
    required String currentCity,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-basic-post',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'birth_day': birthDay,
          'birth_month': birthMonth,
          'birth_year': birthYear,
          'gender': gender,
          'nationality': nationality,
          'marital_status': maritalStatus,
          'current_country': currentCountry,
          'current_city': currentCity,
        },
      );

      log(prettyJson(response.data), name: 'updateCVBasicInformation Response');

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log('updateCVBasicInformation Error!', stackTrace: s, error: e);
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> updateCVContactInformation({
    required DioController dio,
    required String email,
    required String contactNumber,
    required String website,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-contact-post',
        data: {
          'email': email,
          'contact_number': contactNumber,
          'website': website,
        },
      );

      log(
        prettyJson(response.data),
        name: 'updateCVContactInformation Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log('updateCVContactInformation Error!', stackTrace: s, error: e);
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> updateCVTargetJob({
    required DioController dio,
    required String jobRoleId,
    required String jobTitle,
    required String level,
    required String type,
    required String salary,
    required String currency,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-targetjob-post',
        data: {
          'job_role': jobRoleId,
          'job_title': jobTitle,
          'career_level': level,
          'job_type': type,
          'target_salary': salary,
          'target_salary_currency': currency,
        },
      );

      log(
        prettyJson(response.data),
        name: 'updateCVTargetJob Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log('updateCVTargetJob Error!', stackTrace: s, error: e);
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  /// Experience
  Future<List<ExperienceModel>> getExperiences({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('cv-work-experience-list');
      log(
        prettyJson(response.data),
        name: 'getExperiences Response',
      );
      if (response.statusCode == 200) {
        WorkExperienceListResponseModel model =
            workExperienceListResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('getExperiences Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<String> addExperience({
    required DioController dio,
    String? id,
    required String jobTitle,
    required String company,
    required String location,
    required String fromMonth,
    required String fromYear,
    required String toMonth,
    required String toYear,
    required String description,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        id == null ? 'cv-work-experience-post' : 'cv-work-experience-update',
        data: {
          'id': id,
          'job_title': jobTitle,
          'company': company,
          'location': location,
          'from_month': fromMonth,
          'from_year': fromYear,
          'to_month': toMonth,
          'to_year': toYear,
          'work_description': description,
        },
      );

      log(
        prettyJson(response.data),
        name: '${id == null ? 'add' : 'update'} Experience Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        '${id == null ? 'add' : 'update'} Experience Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> deleteExperience({
    required DioController dio,
    required String id,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-work-experience-delete',
        data: {'id': id},
      );

      log(
        prettyJson(response.data),
        name: 'deleteExperience Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        'deleteExperience Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  /// Education
  Future<List<EducationModel>> getEducations({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('cv-education-list');
      log(
        prettyJson(response.data),
        name: 'getEducations Response',
      );
      if (response.statusCode == 200) {
        EducationListResponseModel model = educationListResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('getEducations Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<String> addEducation({
    required DioController dio,
    String? id,
    required String degree,
    required String field,
    required String institution,
    required String country,
    required String city,
    required String startMonth,
    required String startYear,
    required String endMonth,
    required String endYear,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        id == null ? 'cv-education-post' : 'cv-education-update',
        data: {
          'id': id,
          'degree': degree,
          'field': field,
          'institution': institution,
          'country': country,
          'city': city,
          'start_month': startMonth,
          'start_year': startYear,
          'end_month': endMonth,
          'end_year': endYear,
        },
      );

      log(
        prettyJson(response.data),
        name: '${id == null ? 'add' : 'update'} Education Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        '${id == null ? 'add' : 'update'} Education Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> deleteEducation({
    required DioController dio,
    required String id,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-education-delete',
        data: {'id': id},
      );

      log(
        prettyJson(response.data),
        name: 'deleteEducation Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        'deleteEducation Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  /// Skill
  Future<List<SkillModel>> getSkills({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('cv-skill-list');
      log(
        prettyJson(response.data),
        name: 'getSkills Response',
      );
      if (response.statusCode == 200) {
        SkillListResponseModel model = skillListResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('getSkills Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<String> addSkill({
    required DioController dio,
    String? id,
    required String skill,
    required String level,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        id == null ? 'cv-skill-post' : 'cv-skill-update',
        data: {
          'id': id,
          'skill': skill,
          'level': level,
        },
      );

      log(
        prettyJson(response.data),
        name: '${id == null ? 'add' : 'update'} Skill Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        '${id == null ? 'add' : 'update'} Skill Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> deleteSkill({
    required DioController dio,
    required String id,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-skill-delete',
        data: {'id': id},
      );

      log(
        prettyJson(response.data),
        name: 'deleteSkill Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        'deleteSkill Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  /// Language
  Future<List<LanguageModel>> getLanguages({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('cv-language-list');
      log(
        prettyJson(response.data),
        name: 'getLanguages Response',
      );
      if (response.statusCode == 200) {
        LanguageListResponseModel model = languageListResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('getLanguages Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<String> addLanguage({
    required DioController dio,
    String? id,
    required String language,
    required String level,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        id == null ? 'cv-language-post' : 'cv-language-update',
        data: {
          'id': id,
          'language': language,
          'level': level,
        },
      );

      log(
        prettyJson(response.data),
        name: '${id == null ? 'add' : 'update'} Language Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        '${id == null ? 'add' : 'update'} Language Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> deleteLanguage({
    required DioController dio,
    required String id,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-language-delete',
        data: {'id': id},
      );

      log(
        prettyJson(response.data),
        name: 'deleteLanguage Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        'deleteLanguage Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  /// Training
  Future<List<TrainingModel>> getTrainings({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('cv-training-list');
      log(
        prettyJson(response.data),
        name: 'getTrainings Response',
      );
      if (response.statusCode == 200) {
        TrainingListResponseModel model = trainingListResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('getTrainings Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<String> addTraining({
    required DioController dio,
    String? id,
    required String title,
    required String startMonth,
    required String startYear,
    required String endMonth,
    required String endYear,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        id == null ? 'cv-training-post' : 'cv-training-update',
        data: {
          'id': id,
          'title': title,
          'start_month': startMonth,
          'start_year': startYear,
          'end_month': endMonth,
          'end_year': endYear,
        },
      );

      log(
        prettyJson(response.data),
        name: '${id == null ? 'add' : 'update'} Training Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        '${id == null ? 'add' : 'update'} Training Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> deleteTraining({
    required DioController dio,
    required String id,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-training-delete',
        data: {'id': id},
      );

      log(
        prettyJson(response.data),
        name: 'deleteTraining Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        'deleteTraining Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  /// Certificate
  Future<List<CertificateModel>> getCertificates({
    required DioController dio,
  }) async {
    try {
      Response response = await dio.dioClient.get('cv-certificate-list');
      log(
        prettyJson(response.data),
        name: 'getCertificates Response',
      );
      if (response.statusCode == 200) {
        CertificateListResponseModel model =
            certificateListResponseModelFromJson(
          jsonEncode(response.data),
        );
        return model.data ?? [];
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('getCertificates Error!', stackTrace: s, error: e);
      return [];
    }
  }

  Future<String> addCertificate({
    required DioController dio,
    String? id,
    required String title,
    required String description,
    required String issueMonth,
    required String issueYear,
    required String expireMonth,
    required String expireYear,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        id == null ? 'cv-certificate-post' : 'cv-certificate-update',
        data: {
          'id': id,
          'title': title,
          'description': description,
          'issue_month': issueMonth,
          'issue_year': issueYear,
          'expire_month': expireMonth,
          'expire_year': expireYear,
        },
      );

      log(
        prettyJson(response.data),
        name: '${id == null ? 'add' : 'update'} Certificate Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        '${id == null ? 'add' : 'update'} Certificate Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> deleteCertificate({
    required DioController dio,
    required String id,
  }) async {
    try {
      Response response = await dio.dioClient.post(
        'cv-certificate-delete',
        data: {'id': id},
      );

      log(
        prettyJson(response.data),
        name: 'deleteCertificate Response',
      );

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log(
        'deleteCertificate Error!',
        stackTrace: s,
        error: e,
      );
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }

  Future<String> uploadCV({
    required DioController dio,
    required String cv,
  }) async {
    try {
      String token = await PreferenceService.service.token;
      log(token);

      FormData fd = FormData.fromMap({
        'cv': await MultipartFile.fromFile(cv),
      });

      Response response = await Dio().post(
        '${AppApis.baseUrlV1}cv-original-cv',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
            'Accept': '*/*',
          },
        ),
        data: fd,
      );

      log(prettyJson(response.data), name: 'uploadCV Response');

      if (response.statusCode == 200) {
        if (!(response.data['status'] as bool)) {
          return response.data['message'] as String;
        }
        return '';
      } else {
        if (response.data['message'] != null) {
          return response.data['message'] as String;
        }
        return 'Oops! Something went wrong. Please try again.';
      }
    } on Exception catch (e, s) {
      log('uploadCV Error!', stackTrace: s, error: e);
      if (e is DioError) {
        if ((e.response?.statusCode ?? 0) == 404) {
          if (e.response?.data['message'] != null) {
            return e.response?.data['message'] as String;
          }
        }
      }
      return 'Oops! Something went wrong. Please try again.';
    }
  }
}
