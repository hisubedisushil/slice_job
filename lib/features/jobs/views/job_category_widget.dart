import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/models/job_model.dart';
import 'package:slice_job/modules/jobs/widgets/job_list_item_single.dart';

class JobCategoryWidget extends StatefulWidget {
  final JobCategory model;

  const JobCategoryWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<JobCategoryWidget> createState() => _JobCategoryWidgetState();
}

class _JobCategoryWidgetState extends State<JobCategoryWidget> {
  @override
  void initState() {
    super.initState();
    _initSearch();
  }

  _initSearch() {
    _searching = true;
    if (mounted) {
      setState(() {});
    }
    _page = 1;
    _search();
    Timer(
      const Duration(seconds: 3),
      () {
        _searching = false;
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(
            widget.model.name,
          ),
        ),
        body: Column(
          children: [
            if (_searching)
              const SizedBox(
                height: 160.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            if (!_searching)
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      log(scrollInfo.metrics.pixels.toString());
                      _page++;
                      _loadingMore = true;
                      if (mounted) {
                        setState(() {});
                      }
                      _search();
                    }
                    return false;
                  },
                  child: ListView.separated(
                    itemBuilder: (cxt, index) {
                      // final job = jobController.allJobs[index];
                      final job = _searchedJobs[index];
                      return JobListItemSingle(job: job);
                    },
                    separatorBuilder: (cxt, index) {
                      return const SizedBox(height: 10.0);
                    },
                    // itemCount: jobController.allJobs.length,
                    itemCount: _searchedJobs.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ),
            if (_loadingMore)
              const SizedBox(
                height: 52.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<JobModel> _searchedJobs = [];
  bool _searching = false;
  bool _loadingMore = false;
  int _page = 1;

  _search() async {
    // List<JobModel> jobs = await context
    //     .read<JobController>()
    //     .searchJobsByCategory(page: _page, id: widget.model.id ?? '');
    final jobs = <JobModel>[];
    if (_page == 1) {
      _searchedJobs
        ..clear()
        ..addAll(jobs);
    } else {
      _searchedJobs.addAll(jobs);
    }
    log(_searchedJobs.length.toString());
    _loadingMore = false;
    if (mounted) {
      setState(() {});
    }
  }
}
