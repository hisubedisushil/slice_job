import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/base_response.dart';
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/core/models/profile/applied_job_response.dart';
import 'package:slice_job/core/models/profile/profile_response.dart';
import 'package:slice_job/features/profile/repository/profile_repository.dart';

final profileExperienceRef = StateProvider<List<Experience>>((ref) {
  return [];
});

final profileEducationRef = StateProvider<List<Education>>((ref) {
  return [];
});

final profileSkillRef = StateProvider<List<Skill>>((ref) {
  return [];
});

final profileLanguageRef = StateProvider<List<Language>>((ref) {
  return [];
});

final profileTrainingRef = StateProvider<List<Training>>((ref) {
  return [];
});

final profileCertificateRef = StateProvider<List<Certificate>>((ref) {
  return [];
});

class ProfileProvider extends StateNotifier<BaseState> {
  ProfileProvider({
    required this.ref,
  })  : _repository = ref.read(profileRepositoryRef),
        super(
          const BaseState.initial(),
        );

  final Ref ref;

  final ProfileRepository _repository;

  Future<void> getProfile() async {
    state = const BaseState.loading();
    final result = await _repository.getUserProfile();
    if (result is BaseResponse<Profile>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String dob,
    required String mobileNumber,
    required String country,
    required String city,
    required String gender,
    required String nationality,
    required String qualification,
    required String experience,
  }) async {
    state = const BaseState.loading();
    final updateProfileData = {
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'nationality': nationality,
      'gender': gender,
      'curr_country': country,
      'curr_city': city,
      'qualification': qualification,
      'experience': experience,
      'mobile_number': mobileNumber,
    };
    final result = await _repository.updateProfile(updateProfileData);
    if (result is BaseResponse<bool>) {
      state = BaseState.success(data: result.message);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> uploadProfileImage(String profileImage) async {
    state = const BaseState.loading();
    final result = await _repository.uploadProfileImage(profileImage);
    if (result is BaseResponse<String>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String password,
  }) async {
    state = const BaseState.loading();

    final result = await _repository.changePassword(
      oldPassword: oldPassword,
      password: password,
    );
    if (result is BaseResponse<bool>) {
      state = BaseState.success(data: result.message);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getAppliedJobs() async {
    state = const BaseState.loading();
    final result = await _repository.getAppliedJobs();
    if (result is BaseResponse<List<AppliedJobs>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> downloadCV() async {
    state = const BaseState.loading();
    final result = await _repository.downloadCV();
    if (result is BaseResponse<String>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getProfileExperience({bool showLoading = true}) async {
    if (showLoading) {
      state = const BaseState.loading();
    }
    final result = await _repository.getProfileExperience();
    if (result is BaseResponse<List<Experience>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getProfileEducation({bool showLoading = true}) async {
    if (showLoading) {
      state = const BaseState.loading();
    }
    final result = await _repository.getProfileEducation();
    if (result is BaseResponse<List<Education>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getProfileSkill({bool showLoading = true}) async {
    if (showLoading) {
      state = const BaseState.loading();
    }
    final result = await _repository.getProfileSkill();
    if (result is BaseResponse<List<Skill>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getProfileLanguage({bool showLoading = true}) async {
    if (showLoading) {
      state = const BaseState.loading();
    }
    final result = await _repository.getProfileLanguage();
    if (result is BaseResponse<List<Language>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getProfileTraining({bool showLoading = true}) async {
    if (showLoading) {
      state = const BaseState.loading();
    }
    final result = await _repository.getProfileTraining();
    if (result is BaseResponse<List<Training>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> getProfileCertificate({bool showLoading = true}) async {
    if (showLoading) {
      state = const BaseState.loading();
    }
    final result = await _repository.getProfileCertificate();
    if (result is BaseResponse<List<Certificate>>) {
      state = BaseState.success(data: result.data);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }

  Future<void> removeAccount(String password) async {
    state = const BaseState.loading();
    final result = await _repository.removeAccount(password);
    if (result is BaseResponse<bool>) {
      state = BaseState.success(data: result.message);
    } else {
      state = BaseState.error(result.data as Failure);
    }
  }
}
