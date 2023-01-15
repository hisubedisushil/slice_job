import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/core/models/profile/applied_job_response.dart';
import 'package:slice_job/features/jobs/views/applied_job_list_item.dart';
import 'package:slice_job/features/profile/provider/profile_provider.dart';
import 'package:slice_job/helpers/util/util.dart';

final appliedJobsRef =
    StateNotifierProvider.autoDispose<ProfileProvider, BaseState>((ref) {
  return ProfileProvider(ref: ref);
});

class AppliedJobsScreen extends ConsumerStatefulWidget {
  const AppliedJobsScreen({super.key});

  @override
  ConsumerState<AppliedJobsScreen> createState() => _AppliedJobsScreenState();
}

class _AppliedJobsScreenState extends ConsumerState<AppliedJobsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchAppliedJobs();
  }

  _fetchAppliedJobs() {
    Future.microtask(() => ref.read(appliedJobsRef.notifier).getAppliedJobs());
  }

  Future<void> _onRefresh() {
    return Future.sync(
      () => _fetchAppliedJobs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applied Jobs'),
      ),
      body: ref.watch(appliedJobsRef).maybeWhen(
        loading: () {
          return Column(
            children: [
              verticalSpacer(10.h),
              const AppliedJobShimmerItem(),
              verticalSpacer(10.h),
              const AppliedJobShimmerItem(),
              verticalSpacer(10.h),
              const AppliedJobShimmerItem(),
            ],
          );
        },
        success: (data, extraData) {
          final appliedJobs = data as List<AppliedJobs>;
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              itemBuilder: (cxt, index) {
                final applied = appliedJobs[index];
                return AppliedJobListItem(appliedJob: applied);
              },
              separatorBuilder: (cxt, index) {
                return const SizedBox(height: 10.0);
              },
              itemCount: appliedJobs.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              physics: const BouncingScrollPhysics(),
            ),
          );
        },
        orElse: () {
          return const SizedBox();
        },
      ),
    );
  }
}
