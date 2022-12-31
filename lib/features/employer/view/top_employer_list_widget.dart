import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slice_job/core/models/company.dart';
import 'package:slice_job/features/employer/view/widgets/top_employer_list_item.dart';
import 'package:slice_job/features/home/home_screen.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';

class TopEmployerListWidget extends ConsumerWidget {
  const TopEmployerListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = (ScreenUtil().screenWidth - 30.w) / 2;
    final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.h,
      // childAspectRatio: 2.0,
      mainAxisExtent: width,
    );
    return ref.watch(topEmployerRef).maybeWhen(
      loading: () {
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return const TopEmployerShimmerListItem().pXY(10.h, 10.h);
            },
            childCount: 5,
          ),
          gridDelegate: gridDelegate,
        );
      },
      success: (data, extraData) {
        final companyData = data as List<Company>;
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final company = companyData[index];
              return TopEmployerListItem(
                company: company,
              ).pXY(10.h, 10.h);
            },
            childCount: companyData.length,
          ),
          gridDelegate: gridDelegate,
        );
      },
      error: (failure) {
        return SliverToBoxAdapter(
          child: Container(
            color: Colors.red,
          ),
        );
      },
      orElse: () {
        return SliverToBoxAdapter(
          child: Container(
            color: Colors.amber,
          ),
        );
      },
    );
  }
}
