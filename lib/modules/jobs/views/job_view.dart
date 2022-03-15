import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/general_controller.dart';
import '../../../controllers/job_controller.dart';
import '../../../widgets/header_widget.dart';
import '../../navbar/controllers/nav_bar_controller.dart';
import '../widgets/job_list_item.dart';
import '../widgets/job_list_item_single.dart';
import '../widgets/top_employer_list_item.dart';
import 'job_category_view.dart';

class JobView extends StatelessWidget {
  const JobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobController = context.watch<JobController>();
    final generalController = context.watch<GeneralController>();
    final navController = context.watch<NavBarController>();
    return CustomScrollView(
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        child: InkWell(
                          onTap: () {
                            navController.setSelectedIndex(1);
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(24.0),
                              // left: Radius.circular(24.0),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                fillColor: AppColors.primary.withOpacity(0.2),
                                hintText: 'Search jobs here...',
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                                filled: true,
                                isDense: true,
                                enabled: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 5.0),
                      // IconButton(
                      //   onPressed: () {
                      //     FocusScope.of(context).requestFocus(FocusNode());
                      //     context.read<NavBarController>().setSelectedIndex(1);
                      //     Navigator.pushAndRemoveUntil(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (cxt) => NavBarView(
                      //           searchText: _searchText.text,
                      //         ),
                      //       ),
                      //       (route) => false,
                      //     );
                      //     setState(() {});
                      //   },
                      //   icon: CircleAvatar(
                      //     backgroundColor: AppColors.primary,
                      //     radius: 18.0,
                      //     child: Icon(
                      //       Ionicons.search_outline,
                      //       color: AppColors.white,
                      //       size: 20.0,
                      //     ),
                      //   ),
                      //   visualDensity: VisualDensity.compact,
                      //   padding: EdgeInsets.zero,
                      // ),
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
                      final category =
                          generalController.featureCategories[index];
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
                              builder: (cxt) => JobCategoryView(
                                model: category,
                              ),
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
                    itemCount: generalController.featureCategories.length,
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
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Featured Job',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            ListView.separated(
              itemBuilder: (cxt, index) {
                final job = jobController.featuredJobs[index];
                return JobListItem(item: job);
              },
              separatorBuilder: (cxt, index) {
                return const SizedBox(height: 10.0);
              },
              itemCount: jobController.featuredJobs.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              physics: const NeverScrollableScrollPhysics(),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Recent Job',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            ListView.separated(
              itemBuilder: (cxt, index) {
                final job = jobController.recentJobs[index];
                return JobListItemSingle(job: job);
              },
              separatorBuilder: (cxt, index) {
                return const SizedBox(height: 10.0);
              },
              itemCount: jobController.recentJobs.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              physics: const NeverScrollableScrollPhysics(),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Top Employers',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (cxt, index) {
                final c = generalController.companies[index];
                return TopEmployerListItem(company: c);
              },
              itemCount: generalController.companies.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              physics: const NeverScrollableScrollPhysics(),
            ),
            const SizedBox(height: 60.0),
          ]),
        ),
      ],
    );
  }
}
