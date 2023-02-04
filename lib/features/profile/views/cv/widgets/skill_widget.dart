import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/packages/panara_dialogs/panara_dialogs.dart';

final deleteRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class SkillWidget extends ConsumerStatefulWidget {
  const SkillWidget({super.key});

  @override
  ConsumerState<SkillWidget> createState() => SkillWidgetState();
}

class SkillWidgetState extends ConsumerState<SkillWidget> {
  final List<Skill> profileSkills = [];

  @override
  void initState() {
    super.initState();
    profileSkills.addAll(ref.read(profileSkillRef.notifier).state);
  }

  void _deleteSkill(Skill skill) {
    if (skill.id != null) {
      ref.read(deleteRef.notifier).deleteSkill(skill.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      deleteRef,
      (previous, next) {
        if (previous == next) return;
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Deleting Skill!');
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Skill Removed!',
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
      children: [
        SectionBarWidget(
          title: 'Skills',
          onTap: () {
            context.pushNamed(workSkillFormRoute);
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
                                  message: 'Do you want to delete this  item?',
                                  cancelButtonText: 'No',
                                  confirmButtonText: 'Yes',
                                  onTapCancel: () => Navigator.pop(context),
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    _deleteSkill(skill);
                                  },
                                  panaraDialogType: PanaraDialogType.warning,
                                  barrierDismissible: true,
                                );
                              } else {
                                context.pushNamed(
                                  workSkillFormRoute,
                                  extra: skill,
                                );
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
      ],
    );
  }
}
