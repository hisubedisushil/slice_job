import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/header_widget.dart';

class JobFilterView extends StatelessWidget {
  const JobFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: const HeaderWidget(),
      ),
      body: const Center(
        child: Text(
          'Jobs',
        ),
      ),
    );
  }
}
