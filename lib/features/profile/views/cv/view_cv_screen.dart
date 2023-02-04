import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/features/profile/views/cv/widgets/basic_information_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/certificate_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/contact_information_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/education_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/language_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/original_cv_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/skill_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/target_job_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/training_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/work_experience_widget.dart';
import 'package:slice_job/features/profile/views/profile_authenticated_view.dart';
import 'package:slice_job/helpers/util/util.dart';

final updateContactInfoRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});
final updateTargetJobRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});
final downloadCVRefP =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

class ViewCVScreen extends ConsumerStatefulWidget {
  const ViewCVScreen({super.key});

  @override
  ConsumerState<ViewCVScreen> createState() => _ViewCVScreenState();
}

class _ViewCVScreenState extends ConsumerState<ViewCVScreen> {
  final List<Certificate> profileCertificates = [];
  String? _cvFile;

  @override
  void initState() {
    super.initState();
    profileCertificates.addAll(ref.read(profileCertificateRef.notifier).state);
  }

  void _downloadCV() {
    FocusScope.of(context).requestFocus(FocusNode());
    ref.read(downloadCVRefP.notifier).downloadCV();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      downloadCVRefP,
      (previous, next) {
        if (previous == next) return;
        if (next is BaseLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return const DownloadingCVDialog();
            },
          );
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            final data = next.data as String;
            showDialog(
              context: context,
              builder: (context) {
                return CVDownloadedDialog(data: data);
              },
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'CV Downloaded Successfully!',
                ),
              ),
            );
          }
          if (next is BaseError) {
            final err = next.data as Failure;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  err.reason,
                ),
              ),
            );
          }
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV'),
        actions: [
          IconButton(
            onPressed: _downloadCV,
            icon: const Icon(Ionicons.download_outline),
            tooltip: 'Download CV',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 15.h,
          bottom: 50.h,
        ),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const BasicInformationWidget(),
            verticalSpacer(20.h),
            const ContactInformationWidget(),
            verticalSpacer(20.h),
            const TargetJobWidget(),
            verticalSpacer(20.h),
            const WorkExperienceWidget(),
            verticalSpacer(15.h),
            const EducationWidget(),
            verticalSpacer(15.h),
            const SkillWidget(),
            verticalSpacer(15.h),
            const LanguageWidget(),
            verticalSpacer(15.h),
            const TrainingWidget(),
            verticalSpacer(15.h),
            const CertificateWidget(),
            verticalSpacer(15.h),
            const OriginalCVWidget(),
            verticalSpacer(15.h),
          ],
        ),
      ),
    );
  }
}
