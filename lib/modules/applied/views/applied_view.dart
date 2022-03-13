import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/profile_controller.dart';
import '../../jobs/widgets/job_list_item_applied.dart';

class AppliedView extends StatelessWidget {
  const AppliedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileController>();
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Applied Jobs'),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => profile.getAppliedJobs(),
            child: ListView.separated(
              itemBuilder: (cxt, index) {
                final applied = profile.appliedJobs[index];
                return JobListItemApplied(model: applied);
              },
              separatorBuilder: (cxt, index) {
                return const SizedBox(height: 10.0);
              },
              itemCount: profile.appliedJobs.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              physics: const BouncingScrollPhysics(),
            ),
          ),
        ),
      ),
    );
  }
}
