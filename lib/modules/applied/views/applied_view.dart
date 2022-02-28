import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/header_widget.dart';
import '../../jobs/widgets/job_list_item_applied.dart';

class AppliedView extends StatelessWidget {
  const AppliedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Ionicons.arrow_back,
            color: AppColors.primary,
          ),
        ),
        title: const HeaderWidget(),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (cxt, index) {
            return const JobListItemApplied();
          },
          separatorBuilder: (cxt, index) {
            return const SizedBox(height: 10.0);
          },
          itemCount: 3,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10.0),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
