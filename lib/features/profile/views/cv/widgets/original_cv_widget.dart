import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/features/profile/provider/cv_provider.dart';
import 'package:slice_job/features/profile/widgets/section_bar_widget.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

final uploadCVRef =
    StateNotifierProvider.autoDispose<CVProvider, BaseState>((ref) {
  return CVProvider(ref: ref);
});

class OriginalCVWidget extends ConsumerStatefulWidget {
  const OriginalCVWidget({super.key});

  @override
  ConsumerState<OriginalCVWidget> createState() => OriginalCVWidgetState();
}

class OriginalCVWidgetState extends ConsumerState<OriginalCVWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _uploadCV() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (file != null) {
      ref.read(uploadCVRef.notifier).uploadOriginalCV(file.files.single.path!);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      uploadCVRef,
      (previous, next) {
        if (next is BaseLoading) {
          context.showUpdatingCVInfoDialog('Uploading Original CV!');
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            final data = next.data as String;
            // may be get original cv request
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  data,
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
          title: 'Original CV',
          onTap: _uploadCV,
        ),
        verticalSpacer(15.h),
        
        // if (_cvFile != null)
        //   Material(
        //     color: AppColors.white,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     child: ListTile(
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //       ),
        //       dense: true,
        //       title: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Flexible(
        //             child: Text(
        //               _cvFile ?? '',
        //               style: TextStyle(
        //                 color: AppColors.black,
        //                 fontSize: 18.0,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //           ),
        //           // PopupMenuButton(
        //           //   itemBuilder: (cxt) => [
        //           //     const PopupMenuItem(
        //           //       child: Text("Delete"),
        //           //       value: 2,
        //           //     ),
        //           //   ],
        //           //   shape: RoundedRectangleBorder(
        //           //     borderRadius: BorderRadius.circular(10.0),
        //           //   ),
        //           //   onSelected: (value) {
        //           //     if (value == 2) {
        //           //       _deleteCertificate(certificate: certificate);
        //           //     }
        //           //   },
        //           // ),
        //         ],
        //       ),
        //     ),
        //   )
      ],
    );
  }
}
