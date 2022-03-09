import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:slice_job/models/job_type_model.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/job_controller.dart';
import '../../../models/job_category_model.dart';
import '../../../models/job_model.dart';
import '../../../widgets/header_widget.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/job_list_item_single.dart';
import 'job_search_view.dart';

class JobFilterView extends StatefulWidget {
  const JobFilterView({Key? key}) : super(key: key);

  @override
  State<JobFilterView> createState() => _JobFilterViewState();
}

class _JobFilterViewState extends State<JobFilterView> {
  final _searchTextController = TextEditingController();
  JobCategoryModel? _category;
  JobTypeModel? _type;
  JobTypeModel? _level;
  JobTypeModel? _salary;
  JobTypeModel? _education;
  JobTypeModel? _experience;

  @override
  void initState() {
    super.initState();
    _initSearch();
  }

  _initSearch() {
    _searching = true;
    setState(() {});
    _page = 1;
    _search();
    Timer(
      const Duration(seconds: 3),
      () {
        _searching = false;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobController = context.watch<JobController>();
    final generalController = context.watch<GeneralController>();
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          log(scrollInfo.metrics.pixels.toString());
          _page++;
          _loadingMore = true;
          setState(() {});
          _search();
        }
        return false;
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.white,
            floating: true,
            pinned: false,
            snap: false,
            title: const HeaderWidget(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(87.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 15.0),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(24.0),
                          ),
                          color: AppColors.primary.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(5.5),
                            child: Icon(
                              Ionicons.search_outline,
                              color: AppColors.primary,
                              size: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(24.0),
                            ),
                            child: TextFormField(
                              controller: _searchTextController,
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                fillColor: AppColors.primary.withOpacity(0.2),
                                hintText: 'Search jobs here ...',
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                filled: true,
                                isDense: true,
                              ),
                              onChanged: (value) {
                                _initSearch();
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.0),
                                ),
                              ),
                              builder: (cxt) => FractionallySizedBox(
                                heightFactor: 0.8,
                                child: FilterSheet(
                                  category: _category,
                                  type: _type,
                                  level: _level,
                                  salary: _salary,
                                  education: _education,
                                  experience: _experience,
                                  onFilter: (
                                    category,
                                    type,
                                    level,
                                    salary,
                                    education,
                                    experience,
                                  ) {
                                    _category = category;
                                    _type = type;
                                    _level = level;
                                    _salary = salary;
                                    _education = education;
                                    _experience = experience;
                                    setState(() {});
                                    Navigator.pop(context);
                                    _initSearch();
                                  },
                                ),
                              ),
                            );
                          },
                          icon: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  color: AppColors.primary,
                                ),
                              ),
                              if ((_category != null ? 1 : 0) +
                                      (_type != null ? 1 : 0) +
                                      (_level != null ? 1 : 0) +
                                      (_salary != null ? 1 : 0) +
                                      (_education != null ? 1 : 0) +
                                      (_experience != null ? 1 : 0) !=
                                  0)
                                Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.red,
                                    radius: 7.0,
                                    child: Text(
                                      '${(_category != null ? 1 : 0) + (_type != null ? 1 : 0) + (_level != null ? 1 : 0) + (_salary != null ? 1 : 0) + (_education != null ? 1 : 0) + (_experience != null ? 1 : 0)}',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //   child: Text(
                  //     'View Jobs by Popular Category',
                  //     style: TextStyle(
                  //       fontSize: 20.0,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.white,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 32.0,
                    child: ListView.separated(
                      itemBuilder: (cxt, index) {
                        final category = generalController.allCategories[index];
                        return ActionChip(
                          label: Text(
                            category.name ?? '',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (cxt) => const JobSearchView(),
                              ),
                            );
                          },
                          backgroundColor: AppColors.primary,
                        );
                      },
                      separatorBuilder: (cxt, index) {
                        return const SizedBox(width: 5.0);
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      itemCount: generalController.allCategories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if (_searching)
                const SizedBox(
                  height: 160.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              if (!_searching)
                ListView.separated(
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
                  physics: const NeverScrollableScrollPhysics(),
                ),
              if (_loadingMore)
                const SizedBox(
                  height: 52.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              const SizedBox(height: 60.0),
            ]),
          ),
        ],
      ),
    );
  }

  List<JobModel> _searchedJobs = [];
  bool _searching = false;
  bool _loadingMore = false;
  int _page = 1;

  _search() async {
    List<JobModel> jobs = await context.read<JobController>().searchJobs(
          page: _page,
          category: _category?.name ?? '',
          type: _type?.name ?? '',
          level: _level?.name ?? '',
          salary: _salary?.name ?? '',
          education: _education?.name ?? '',
          experience: _experience?.name ?? '',
        );
    if (_page == 1) {
      _searchedJobs
        ..clear()
        ..addAll(jobs);
    } else {
      _searchedJobs.addAll(jobs);
    }
    log(_searchedJobs.length.toString());
    _loadingMore = false;
    setState(() {});
  }
}
