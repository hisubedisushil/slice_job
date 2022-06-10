import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/authentication_controller.dart';
import '../../../controllers/job_controller.dart';
import '../../../models/job_detail_model.dart';
import '../../../models/job_model.dart';
import '../../login/views/login_view.dart';
import 'job_apply_view.dart';

class JobDetailView extends StatefulWidget {
  final JobModel job;

  const JobDetailView({Key? key, required this.job}) : super(key: key);

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  bool _loading = true;
  bool _error = false;
  JobDetailModel? _jobDetail;
  @override
  void initState() {
    super.initState();
    _loadJobDetail();
  }

  _loadJobDetail() async {
    if (!_loading) {
      _loading = true;
      _error = false;
      if (mounted) {
        setState(() {});
      }
    }

    _jobDetail = await context
        .read<JobController>()
        .getJobDetail(jobId: widget.job.jobKey ?? '');

    if (_jobDetail == null) {
      _error = true;
    }

    _loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Material(
        color: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          appBar: AppBar(
            title: Text(
              widget.job.jobTittle ?? '',
            ),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _jobDetail?.jobTittle ?? '',
              ),
              Text(
                'Posted on ${_jobDetail?.postDate ?? ''}',
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Share.share(
                  '${_jobDetail?.jobTittle}\n'
                  '${_jobDetail?.link}',
                  subject: _jobDetail?.jobTittle,
                );
              },
              icon: Icon(
                Ionicons.share_outline,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
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
                        _jobDetail?.company?.name ?? '',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      HtmlWidget(
                        _jobDetail?.company?.description ?? '',
                        onTapUrl: (url) async {
                          launch(url);
                          return await canLaunch(url);
                        },
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
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
                        _jobDetail?.jobTittle ?? '',
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
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Job Category',
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
                                  _jobDetail?.jobCategory ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Job Location',
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
                                  _jobDetail?.jobCity ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Job Type',
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
                                  _jobDetail?.jobType ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Career Level',
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
                                  _jobDetail?.careerLevel ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Education Required',
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
                                  _jobDetail?.educationLevel ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Experience Required',
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
                                  _jobDetail?.experience ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Salary',
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
                                  _jobDetail?.jobSalary ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: Text(
                                  'Facility / Benefits Provided',
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
                                  _jobDetail?.benefits ?? '',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
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
                        'Descriptions',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      HtmlWidget(
                        _jobDetail?.descriptions ?? '',
                        onTapUrl: (url) async {
                          launch(url);
                          return await canLaunch(url);
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
                ),
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
                if ((_jobDetail?.jobApplyUrl ?? '').isNotEmpty)
                  const SizedBox(height: 10.0),
                if ((_jobDetail?.jobApplyUrl ?? '').isNotEmpty)
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
                          'official page ${_jobDetail?.jobApplyUrl}. We will '
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
                            launch(_jobDetail?.jobApplyUrl ?? '');
                          },
                          child: Text(
                            'Apply on Company Site',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: AppColors.primary,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          height: 44.0,
                          elevation: 0.0,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10.0),
                if ((_jobDetail?.jobApplyUrl ?? '').isEmpty)
                  MaterialButton(
                    onPressed: () {
                      if (context.read<AuthenticationController>().isLoggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (cxt) => JobApplyView(
                              jobDetail: _jobDetail!,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (cxt) => const LoginView(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Apply Now',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                  ),
                if ((_jobDetail?.jobApplyUrl ?? '').isNotEmpty &&
                    (_jobDetail?.applicationReceieveBoth ?? '').trim() == 'yes')
                  MaterialButton(
                    onPressed: () {
                      if (context.read<AuthenticationController>().isLoggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (cxt) => JobApplyView(
                              jobDetail: _jobDetail!,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (cxt) => const LoginView(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Apply Now',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 56.0,
                    elevation: 0.0,
                  ),
                const SizedBox(height: 60.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
