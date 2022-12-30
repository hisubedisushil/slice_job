import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/job_category.dart';
import 'package:slice_job/features/job_category/provider/job_category_provider.dart';
import 'package:slice_job/features/jobs/views/job_category_widget.dart';
import 'package:slice_job/features/main/main_screen.dart';
import 'package:slice_job/widgets/header_widget.dart';

final featuredJobCategoryRef =
    StateNotifierProvider.autoDispose<JobCategoryProvider, BaseState>((ref) {
  return JobCategoryProvider(ref: ref);
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(featuredJobCategoryRef.notifier).getFeaturedJobCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            ref
                                .read(navBarController.notifier)
                                .setSelectedIndex(1);
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(24.0),
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
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                ref.watch<BaseState>(featuredJobCategoryRef).maybeWhen(
                  orElse: () {
                    return Container(
                      color: Colors.amber,
                    );
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                  success: (data, extraData) {
                    final response = data as List<JobCategory>;
                    return SizedBox(
                      height: 32.0,
                      child: ListView.separated(
                        itemBuilder: (cxt, index) {
                          final category = response[index];
                          return ActionChip(
                            label: Text(
                              category.name,
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
                                  builder: (cxt) => JobCategoryWidget(
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
                        itemCount: response.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        // body begins here
        SliverPersistentHeader(
          delegate: Delegate('Featured Jobs'),
        ),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       return Container(
        //         color: Colors.red,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final String _title;

  Delegate(this._title);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.primary,
      child: Center(
        child: Text(
          _title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
