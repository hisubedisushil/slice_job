import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/features/profile/views/cv/widgets/basic_information_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/contact_information_widget.dart';
import 'package:slice_job/features/profile/views/cv/widgets/target_job_widget.dart';
import 'package:slice_job/features/profile/views/profile_authenticated_view.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/packages/panara_dialogs/panara_dialogs.dart';

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
  final List<Experience> profileExperiences = [];
  final List<Education> profileEducations = [];
  final List<Skill> profileSkills = [];
  final List<Language> profileLanguages = [];
  final List<Training> profileTrainings = [];
  final List<Certificate> profileCertificates = [];
  String? _cvFile;

  @override
  void initState() {
    super.initState();
    profileExperiences.addAll(ref.read(profileExperienceRef.notifier).state);
    profileEducations.addAll(ref.read(profileEducationRef.notifier).state);
    profileSkills.addAll(ref.read(profileSkillRef.notifier).state);
    profileLanguages.addAll(ref.read(profileLanguageRef.notifier).state);
    profileTrainings.addAll(ref.read(profileTrainingRef.notifier).state);
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
            SectionBarWidget(
              title: 'Work Experience',
              onTap: () {
                context.pushNamed(workExperienceFormRoute);
              },
            ),
            verticalSpacer(15.h),
            profileExperiences.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (cxt, index) {
                      final work = profileExperiences[index];
                      return Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          dense: true,
                          isThreeLine: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  work.jobTitle ?? '',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (cxt) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("Delete"),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onSelected: (value) async {
                                  if (value == 2) {
                                    await PanaraConfirmDialog.showAnimatedGrow(
                                      context,
                                      title: 'Confirmation',
                                      message:
                                          'Do you want to delete this  item?',
                                      cancelButtonText: 'No',
                                      confirmButtonText: 'Yes',
                                      onTapCancel: () => Navigator.pop(context),
                                      onTapConfirm: () {
                                        Navigator.pop(context);
                                        // _deleteWork(work: work);
                                      },
                                      panaraDialogType:
                                          PanaraDialogType.warning,
                                      barrierDismissible: true,
                                    );
                                  } else {
                                    context.pushNamed(workExperienceFormRoute);
                                  }
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                work.location ?? '',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${work.fromMonth} ${work.fromYear} '
                                'to '
                                '${work.toMonth} ${work.toYear}',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\u2713  ${work.workDescription}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: profileExperiences.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                : const Text(
                    'Your work experiences will show up here.\nAdd your work experiences.',
                    textAlign: TextAlign.center,
                  ),
            verticalSpacer(15.h),
            SectionBarWidget(
              title: 'Education (Upload highest degree at last)',
              onTap: () {
                context.pushNamed(workEducationFormRoute);
              },
            ),
            verticalSpacer(15.h),
            profileEducations.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (cxt, index) {
                      final education = profileEducations[index];
                      return Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          dense: true,
                          isThreeLine: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  education.degree ?? '',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (cxt) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("Delete"),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onSelected: (value) async {
                                  if (value == 2) {
                                    await PanaraConfirmDialog.showAnimatedGrow(
                                      context,
                                      title: 'Confirmation',
                                      message:
                                          'Do you want to delete this  item?',
                                      cancelButtonText: 'No',
                                      confirmButtonText: 'Yes',
                                      onTapCancel: () => Navigator.pop(context),
                                      onTapConfirm: () {
                                        Navigator.pop(context);
                                        // _deleteEducation(education: education);
                                      },
                                      panaraDialogType:
                                          PanaraDialogType.warning,
                                      barrierDismissible: true,
                                    );
                                  } else {
                                    context.pushNamed(workEducationFormRoute);
                                  }
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                education.field ?? '',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${education.city ?? ' '}, '
                                '${education.country ?? ' '}',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${education.startMonth} ${education.startYear} '
                                'to '
                                '${education.endMonth} ${education.endYear}',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: profileEducations.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                : const Text(
                    'Your education will show up here.\nAdd your education qualifications.',
                    textAlign: TextAlign.center,
                  ),
            verticalSpacer(15.h),
            SectionBarWidget(
              title: 'Skills',
              onTap: () {
                context.pushNamed(workEducationFormRoute);
              },
            ),
            verticalSpacer(15.h),
            profileSkills.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (cxt, index) {
                      final skill = profileSkills[index];
                      return Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          dense: true,
                          isThreeLine: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  skill.skill ?? '',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (cxt) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("Delete"),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onSelected: (value) async {
                                  if (value == 2) {
                                    await PanaraConfirmDialog.showAnimatedGrow(
                                      context,
                                      title: 'Confirmation',
                                      message:
                                          'Do you want to delete this  item?',
                                      cancelButtonText: 'No',
                                      confirmButtonText: 'Yes',
                                      onTapCancel: () => Navigator.pop(context),
                                      onTapConfirm: () {
                                        Navigator.pop(context);
                                        // _deleteSkill(skill: skill);
                                      },
                                      panaraDialogType:
                                          PanaraDialogType.warning,
                                      barrierDismissible: true,
                                    );
                                  } else {
                                    context.pushNamed(workSkillFormRoute);
                                  }
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                skill.level ?? '',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: profileSkills.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                : const Text(
                    'Your skills will show up here.\nAdd your skills.',
                    textAlign: TextAlign.center,
                  ),
            verticalSpacer(15.h),
            SectionBarWidget(
              title: 'Language',
              onTap: () {
                context.pushNamed(workLanguageFormRoute);
              },
            ),
            verticalSpacer(15.h),
            profileLanguages.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (cxt, index) {
                      final language = profileLanguages[index];
                      return Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          dense: true,
                          isThreeLine: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  language.language ?? '',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (cxt) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("Delete"),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onSelected: (value) async {
                                  if (value == 2) {
                                    await PanaraConfirmDialog.showAnimatedGrow(
                                      context,
                                      title: 'Confirmation',
                                      message:
                                          'Do you want to delete this  item?',
                                      cancelButtonText: 'No',
                                      confirmButtonText: 'Yes',
                                      onTapCancel: () => Navigator.pop(context),
                                      onTapConfirm: () {
                                        Navigator.pop(context);
                                        // _deleteLanguage(language: language);
                                      },
                                      panaraDialogType:
                                          PanaraDialogType.warning,
                                      barrierDismissible: true,
                                    );
                                  } else {
                                    context.pushNamed(workLanguageFormRoute);
                                  }
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                language.level ?? '',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: profileLanguages.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                : const Text(
                    'Your languages will show up here.\nAdd languages you know.',
                    textAlign: TextAlign.center,
                  ),
            verticalSpacer(15.h),
            SectionBarWidget(
              title: 'Training',
              onTap: () {
                context.pushNamed(workTrainingFormRoute);
              },
            ),
            verticalSpacer(15.h),
            profileTrainings.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (cxt, index) {
                      final training = profileTrainings[index];
                      return Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          dense: true,
                          isThreeLine: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  training.title ?? '',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (cxt) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("Delete"),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onSelected: (value) async {
                                  if (value == 2) {
                                    await PanaraConfirmDialog.showAnimatedGrow(
                                      context,
                                      title: 'Confirmation',
                                      message:
                                          'Do you want to delete this  item?',
                                      cancelButtonText: 'No',
                                      confirmButtonText: 'Yes',
                                      onTapCancel: () => Navigator.pop(context),
                                      onTapConfirm: () {
                                        Navigator.pop(context);
                                        // _deleteTraining(training: training);
                                      },
                                      panaraDialogType:
                                          PanaraDialogType.warning,
                                      barrierDismissible: true,
                                    );
                                  } else {
                                    context.pushNamed(workTrainingFormRoute);
                                  }
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${training.startMonth} ${training.startYear} '
                                'to '
                                '${training.endMonth} ${training.endYear}',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: profileTrainings.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                : const Text(
                    'Your trainings will show up here.\nAdd trainings you have taken.',
                    textAlign: TextAlign.center,
                  ),
            verticalSpacer(15.h),
            SectionBarWidget(
              title: 'Certificates',
              onTap: () {
                context.pushNamed(workCertificateFormRoute);
              },
            ),
            verticalSpacer(15.h),
            profileCertificates.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (cxt, index) {
                      final certificate = profileCertificates[index];
                      return Material(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          dense: true,
                          isThreeLine: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  certificate.title ?? '',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (cxt) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text("Delete"),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onSelected: (value) async {
                                  if (value == 2) {
                                    await PanaraConfirmDialog.showAnimatedGrow(
                                      context,
                                      title: 'Confirmation',
                                      message:
                                          'Do you want to delete this  item?',
                                      cancelButtonText: 'No',
                                      confirmButtonText: 'Yes',
                                      onTapCancel: () => Navigator.pop(context),
                                      onTapConfirm: () {
                                        Navigator.pop(context);
                                        // _deleteCertificate(
                                        //     certificate: certificate);
                                      },
                                      panaraDialogType:
                                          PanaraDialogType.warning,
                                      barrierDismissible: true,
                                    );
                                  } else {
                                    context.pushNamed(workCertificateFormRoute);
                                  }
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${certificate.issueMonth} ${certificate.issueYear} '
                                'to '
                                '${certificate.expireMonth} ${certificate.expireYear}',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\u2713  ${certificate.description}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    itemCount: profileCertificates.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                : const Text(
                    'Your certificates will show up here.\nAdd your certificates.',
                    textAlign: TextAlign.center,
                  ),
            verticalSpacer(15.h),
            SectionBarWidget(
              title: 'Original CV',
              onTap: () {
                // context.pushNamed(workTrainingFormRoute);
              },
            ),
            verticalSpacer(15.h),
            if (_cvFile != null)
              Material(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  dense: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          _cvFile ?? '',
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // PopupMenuButton(
                      //   itemBuilder: (cxt) => [
                      //     const PopupMenuItem(
                      //       child: Text("Delete"),
                      //       value: 2,
                      //     ),
                      //   ],
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //   ),
                      //   onSelected: (value) {
                      //     if (value == 2) {
                      //       _deleteCertificate(certificate: certificate);
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
