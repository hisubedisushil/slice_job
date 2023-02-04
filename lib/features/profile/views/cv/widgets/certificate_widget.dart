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
import 'package:slice_job/features/profile/views/cv/work_certificate_form_screen.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:slice_job/packages/panara_dialogs/panara_dialogs.dart';

final deleteRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

final certificateRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

class CertificateWidget extends ConsumerStatefulWidget {
  const CertificateWidget({super.key});

  @override
  ConsumerState<CertificateWidget> createState() => CertificateWidgetState();
}

class CertificateWidgetState extends ConsumerState<CertificateWidget> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(certificateRef.notifier).getProfileCertificate();
    });
  }

  void _delete(Certificate certificate) {
    if (certificate.id != null) {
      ref.read(deleteRef.notifier).deleteCertificate(certificate.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      deleteRef,
      (previous, next) {
        if (previous == next) return;
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Deleting Certificate!');
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            ref
                .read(certificateRef.notifier)
                .getProfileCertificate(showLoading: false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Certificate Removed!',
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
          title: 'Certificates',
          onTap: () async {
            final result = await context.pushNamedAsync(
              (p0) {
                return const WorkCertificateFormScreen();
              },
            );
            if (result ?? false) {
              ref.read(certificateRef.notifier).getProfileCertificate();
            }
          },
        ),
        verticalSpacer(15.h),
        Consumer(builder: (context, ref, child) {
          return ref.watch<BaseState>(certificateRef).maybeWhen(
            loading: () {
              return SizedBox(
                width: 32.r,
                child: const CircularProgressIndicator(),
              );
            },
            success: (data, extraData) {
              final profileCertificates = data;
              return profileCertificates.isNotEmpty
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
                                          _delete(certificate);
                                        },
                                        panaraDialogType:
                                            PanaraDialogType.warning,
                                        barrierDismissible: true,
                                      );
                                    } else {
                                      final result =
                                          await context.pushNamedAsync((p0) {
                                        return WorkCertificateFormScreen(
                                            certificate: certificate);
                                      });
                                      if (result ?? false) {
                                        ref
                                            .read(certificateRef.notifier)
                                            .getProfileCertificate(
                                                showLoading: false);
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
