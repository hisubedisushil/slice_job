import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/features/profile/views/cv/work_education_form_screen.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/packages/panara_dialogs/panara_dialogs.dart';

final deleteEducationRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

final educationRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

class EducationWidget extends ConsumerStatefulWidget {
  const EducationWidget({super.key});

  @override
  ConsumerState<EducationWidget> createState() => _EducationWidgetState();
}

class _EducationWidgetState extends ConsumerState<EducationWidget> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(educationRef.notifier).getProfileEducation();
    });
  }

  void _deleteEducation(Education edu) {
    if (edu.id != null) {
      ref.read(deleteEducationRef.notifier).deleteEducation(edu.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      deleteEducationRef,
      (previous, next) {
        if (previous == next) return;
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Deleting Education!');
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            ref
                .read(educationRef.notifier)
                .getProfileEducation(showLoading: false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Education Removed!',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SectionBarWidget(
          title: 'Education (Upload highest degree at last)',
          onTap: () async {
            final result = await context.pushNamedAsync(
              (p0) {
                return const WorkEducationFormScreen();
              },
            );
            if (result ?? false) {
              ref.read(educationRef.notifier).getProfileEducation();
            }
          },
        ),
        verticalSpacer(15.h),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch<BaseState>(educationRef).maybeWhen(
              loading: () {
                return SizedBox(
                  width: 32.r,
                  child: const CircularProgressIndicator(),
                );
              },
              success: (data, extraData) {
                final profileEducations = data;
                return profileEducations.isNotEmpty
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        await PanaraConfirmDialog
                                            .showAnimatedGrow(
                                          context,
                                          title: 'Confirmation',
                                          message:
                                              'Do you want to delete this  item?',
                                          cancelButtonText: 'No',
                                          confirmButtonText: 'Yes',
                                          onTapCancel: () =>
                                              Navigator.pop(context),
                                          onTapConfirm: () {
                                            Navigator.pop(context);
                                            _deleteEducation(education);
                                          },
                                          panaraDialogType:
                                              PanaraDialogType.warning,
                                          barrierDismissible: true,
                                        );
                                      } else {
                                        final result =
                                            await context.pushNamedAsync((p0) {
                                          return WorkEducationFormScreen(
                                              education: education);
                                        });
                                        if (result ?? false) {
                                          ref
                                              .read(educationRef.notifier)
                                              .getProfileEducation(showLoading: false);
                                        }
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
                      );
              },
              orElse: () {
                return const SizedBox();
              },
            );
          },
        ),
      ],
    );
  }
}
