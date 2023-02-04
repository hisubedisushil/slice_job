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
import 'package:slice_job/features/profile/views/cv/work_training_form_screen.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/packages/panara_dialogs/panara_dialogs.dart';

final deleteRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

final trainingRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

class TrainingWidget extends ConsumerStatefulWidget {
  const TrainingWidget({super.key});

  @override
  ConsumerState<TrainingWidget> createState() => TrainingWidgetState();
}

class TrainingWidgetState extends ConsumerState<TrainingWidget> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(trainingRef.notifier).getProfileTraining();
    });
  }

  void _delete(Training training) {
    if (training.id != null) {
      ref.read(deleteRef.notifier).deleteTraining(training.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      deleteRef,
      (previous, next) {
        if (previous == next) return;
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Deleting Training!');
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            ref
                .read(trainingRef.notifier)
                .getProfileTraining(showLoading: false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Training Removed!',
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
          title: 'Training',
          onTap: () async {
            final result = await context.pushNamedAsync(
              (p0) {
                return const WorkTrainingFormScreen();
              },
            );
            if (result ?? false) {
              ref.read(trainingRef.notifier).getProfileTraining();
            }
          },
        ),
        verticalSpacer(15.h),
        Consumer(builder: (context, ref, child) {
          return ref.watch<BaseState>(trainingRef).maybeWhen(
            loading: () {
              return SizedBox(
                width: 32.r,
                child: const CircularProgressIndicator(),
              );
            },
            success: (data, extraData) {
              final profileTrainings = data;
              return profileTrainings.isNotEmpty
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
                                          _delete(training);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      final result =
                                          await context.pushNamedAsync((p0) {
                                        return WorkTrainingFormScreen(
                                            training: training);
                                      });
                                      if (result ?? false) {
                                        ref
                                            .read(trainingRef.notifier)
                                            .getProfileTraining(showLoading: false);
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
                    );
            },
            orElse: () {
              return const SizedBox();
            },
          );
        }),
      ],
    );
  }
}
