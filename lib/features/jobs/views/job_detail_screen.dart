import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:slice_job/app.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job.dart';
import 'package:slice_job/core/models/job_detail.dart';
import 'package:slice_job/features/jobs/provider/job_provider.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/util/util.dart';

final jobDetailRef =
    StateNotifierProvider.autoDispose<JobProvider, BaseState>((ref) {
  return JobProvider(ref: ref);
});

class JobDetailScreen extends ConsumerStatefulWidget {
  final Job job;

  const JobDetailScreen({Key? key, required this.job}) : super(key: key);

  @override
  ConsumerState<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(jobDetailRef.notifier).getJobDetail(jobKey: widget.job.jobKey);
      ref.read(authRef.notifier).getSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;
    final authState = ref.watch(authRef);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.jobTittle ?? '',
              ),
              ref.watch(jobDetailRef).maybeWhen(
                success: (data, extraData) {
                  final jobDetail = data as JobDetail;
                  return Text(
                    'Posted on ${jobDetail.postDate ?? ''}',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  );
                },
                orElse: () {
                  return Text(
                    'Posted on ${job.postDate ?? ''}',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  );
                },
              ),
            ],
          ),
          actions: ref.watch(jobDetailRef).maybeWhen(
            success: (data, extraData) {
              final jobDetail = data as JobDetail;
              return [
                IconButton(
                  onPressed: () {
                    Share.share(
                      '${jobDetail.jobTittle}\n'
                      '${jobDetail.link}',
                      subject: jobDetail.jobTittle,
                    );
                  },
                  icon: Icon(
                    Ionicons.share_outline,
                    color: AppColors.white,
                  ),
                ),
              ];
            },
            orElse: () {
              return null;
            },
          ),
        ),
        body: ref.watch(jobDetailRef).maybeWhen(
          loading: () {
            return SizedBox(
              width: double.infinity,
              height: 100.h,
              child: Center(
                child: SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          },
          success: (data, extraData) {
            final jobDetail = data as JobDetail;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    CompanyDetailWidget(jobDetail: jobDetail),
                    verticalSpacer(10.h),
                    JobDetailWidget(jobDetail: jobDetail),
                    verticalSpacer(10.h),
                    JobDescriptionWidget(jobDetail: jobDetail),
                    // const SizedBox(height: 10.0),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     color: AppColors.white,
                    //   ),
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         'Qualification Criteria',
                    //         style: TextStyle(
                    //           fontSize: 18.0,
                    //           fontWeight: FontWeight.bold,
                    //           color: AppColors.primary,
                    //         ),
                    //       ),
                    //       const Divider(),
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.symmetric(vertical: 2.5),
                    //             child: Icon(
                    //               Ionicons.ellipse,
                    //               size: 14.0,
                    //               color: AppColors.primary,
                    //             ),
                    //           ),
                    //           const SizedBox(width: 10.0),
                    //           Expanded(
                    //             child: Text(
                    //               'A Bachelor’s degree in any technical field',
                    //               style: TextStyle(
                    //                 fontSize: 16.0,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: AppColors.grey,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       const SizedBox(height: 5.0),
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.symmetric(vertical: 2.5),
                    //             child: Icon(
                    //               Ionicons.ellipse,
                    //               size: 14.0,
                    //               color: AppColors.primary,
                    //             ),
                    //           ),
                    //           const SizedBox(width: 10.0),
                    //           Expanded(
                    //             child: Text(
                    //               'At least 2-3 years of experience working with IT support or sales related to LAN, WAN, VPN, Router, Switch, Firewall, Server, Storage, Visualization, Wi-fi, Surveillance etcetera.',
                    //               style: TextStyle(
                    //                 fontSize: 16.0,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: AppColors.grey,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       const SizedBox(height: 5.0),
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.symmetric(vertical: 2.5),
                    //             child: Icon(
                    //               Ionicons.ellipse,
                    //               size: 14.0,
                    //               color: AppColors.primary,
                    //             ),
                    //           ),
                    //           const SizedBox(width: 10.0),
                    //           Expanded(
                    //             child: Text(
                    //               'Must own a two-wheeler with a valid license',
                    //               style: TextStyle(
                    //                 fontSize: 16.0,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: AppColors.grey,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    if ((jobDetail.jobApplyUrl ?? '').isNotEmpty)
                      const SizedBox(height: 10.0),
                    if ((jobDetail.jobApplyUrl ?? '').isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.white,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Interested candidate can directly apply to the '
                              'official page ${jobDetail.jobApplyUrl}. We will '
                              'let you know the detail after successful job apply. '
                              'Good Luck for your career.',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            MaterialButton(
                              onPressed: () {
                                openUrl(jobDetail.jobApplyUrl ?? '');
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: AppColors.primary,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              height: 44.0,
                              elevation: 0.0,
                              child: Text(
                                'Apply on Company Site',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 10.0),
                    if ((jobDetail.jobApplyUrl ?? '').isEmpty)
                      MaterialButton(
                        onPressed: () {
                          if (authState.isAuthenticated) {
                            context.pushNamed(jobApplyRoute, extra: jobDetail);
                          } else {
                            context.pushNamed(loginRoute);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: AppColors.primary,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minWidth: double.infinity,
                        height: 56.0,
                        elevation: 0.0,
                        child: Text(
                          'Apply Now',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if ((jobDetail.jobApplyUrl ?? '').isNotEmpty &&
                        (jobDetail.applicationReceieveBoth ?? '').trim() ==
                            'yes')
                      MaterialButton(
                        onPressed: () {
                          if (authState.isAuthenticated) {
                            context.pushNamed(jobApplyRoute, extra: jobDetail);
                          } else {
                            context.pushNamed(loginRoute);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: AppColors.primary,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minWidth: double.infinity,
                        height: 56.0,
                        elevation: 0.0,
                        child: Text(
                          'Apply Now',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            );
          },
          error: (data) {
            final error = data as Failure;
            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.verticalSpace,
                  Text(
                    error.reason,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
          orElse: () {
            return Container(
              color: Colors.amber,
              child: Text(
                '',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class JobDescriptionWidget extends StatelessWidget {
  const JobDescriptionWidget({
    super.key,
    required this.jobDetail,
  });

  final JobDetail jobDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Descriptions',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Divider(),
          HtmlWidget(
            jobDetail.descriptions ?? '',
            onTapUrl: (url) async {
              return openUrl(url);
            },
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 2.5),
          //       child: Icon(
          //         Ionicons.ellipse,
          //         size: 14.0,
          //         color: AppColors.primary,
          //       ),
          //     ),
          //     const SizedBox(width: 10.0),
          //     Expanded(
          //       child: Text(
          //         'Researches, programs, plans, designs, and '
          //         'administers building projects for clients',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 2.5),
          //       child: Icon(
          //         Ionicons.ellipse,
          //         size: 14.0,
          //         color: AppColors.primary,
          //       ),
          //     ),
          //     const SizedBox(width: 10.0),
          //     Expanded(
          //       child: Text(
          //         'Assist customers with IT infrastructural design and recommendation as per requirements',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 2.5),
          //       child: Icon(
          //         Ionicons.ellipse,
          //         size: 14.0,
          //         color: AppColors.primary,
          //       ),
          //     ),
          //     const SizedBox(width: 10.0),
          //     Expanded(
          //       child: Text(
          //         'Identify and share best practices and standards to existing and potential customers',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 2.5),
          //       child: Icon(
          //         Ionicons.ellipse,
          //         size: 14.0,
          //         color: AppColors.primary,
          //       ),
          //     ),
          //     const SizedBox(width: 10.0),
          //     Expanded(
          //       child: Text(
          //         'Coordinate with the team and provide assistance for product and solution selection',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 2.5),
          //       child: Icon(
          //         Ionicons.ellipse,
          //         size: 14.0,
          //         color: AppColors.primary,
          //       ),
          //     ),
          //     const SizedBox(width: 10.0),
          //     Expanded(
          //       child: Text(
          //         'Prepare timely activity reports and submit them to the concerned department',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5.0),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 2.5),
          //       child: Icon(
          //         Ionicons.ellipse,
          //         size: 14.0,
          //         color: AppColors.primary,
          //       ),
          //     ),
          //     const SizedBox(width: 10.0),
          //     Expanded(
          //       child: Text(
          //         'Participate and conduct technical workshops and training',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontWeight: FontWeight.bold,
          //           color: AppColors.grey,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class JobDetailWidget extends StatelessWidget {
  const JobDetailWidget({
    super.key,
    required this.jobDetail,
  });

  final JobDetail jobDetail;

  List<TableRow> _buildTableRows() {
    final rows = <TableRow>[];
    final jobDetailMapData = jobDetail.toDisplayMap();
    rows.addAll(
      jobDetailMapData.entries.map(
        (e) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Text(
                  e.key,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Text(
                  e.value ?? 'N/A',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            jobDetail.jobTittle ?? '',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Divider(),
          Table(
            columnWidths: const {
              0: FixedColumnWidth(120.0),
            },
            children: _buildTableRows(),
          ),
        ],
      ),
    );
  }
}

class CompanyDetailWidget extends StatelessWidget {
  const CompanyDetailWidget({
    super.key,
    required this.jobDetail,
  });

  final JobDetail jobDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            jobDetail.company?.name ?? '',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Divider(),
          HtmlWidget(
            jobDetail.company?.description ?? '',
            onTapUrl: (url) async {
              return openUrl(url);
            },
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
