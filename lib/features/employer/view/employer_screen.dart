import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/features/employer/provider/employer_provider.dart';
import 'package:slice_job/features/employer/view/widgets/employer_job_list_item.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/image_util.dart';
import 'package:slice_job/helpers/util/util.dart';

final employerRef =
    StateNotifierProvider.autoDispose<EmployerProvider, BaseState>((ref) {
  return EmployerProvider(ref: ref);
});

class EmployerScreen extends ConsumerStatefulWidget {
  const EmployerScreen({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  ConsumerState<EmployerScreen> createState() => _EmployerScreenState();
}

class _EmployerScreenState extends ConsumerState<EmployerScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(employerRef.notifier).getEmployerByID(widget.company.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.company.name ?? '',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
              Text(
                widget.company.address ?? '',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpacer(20.h),
              SliceImage(
                widget.company.logo,
                width: ScreenUtil().screenWidth,
                fit: BoxFit.fitHeight,
                height: 150.h,
                enforceHeight: true,
                alignment: Alignment.topCenter,
              ),
              verticalSpacer(20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Jobs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ).pX(20.w),
              ),
              verticalSpacer(10.h),
              ref.watch<BaseState>(employerRef).maybeMap(
                orElse: () {
                  return Container();
                },
                error: (value) {
                  final error = value.data as Failure;
                  return Text(
                    error.reason,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ).pX(20.w);
                },
                loading: (value) {
                  return ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const EmployerJobListShimmerItem().pXY(20.h, 5.h);
                    },
                  );
                },
                success: (value) {
                  final data = value.data as List<Job>;
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return EmployerJobListItem(
                        job: data[index],
                      ).pXY(20.h, 5.h);
                    },
                  );
                },
              ),
              verticalSpacer(10.h),
            ],
          ),
        ),
      ),
    );
  }
}
