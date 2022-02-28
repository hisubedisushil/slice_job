import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import '../modules/jobs/widgets/menu_sheet.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
              AppImages.logoLarge,
              fit: BoxFit.fitHeight,
              height: 40.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        SizedBox(
          height: 35.0,
          width: 35.0,
          child: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                ),
                builder: (cxt) => const MenuSheet(),
              );
            },
            tooltip: 'Menu',
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Ionicons.menu,
              color: AppColors.primary,
            ),
          ),
        )
      ],
    );
  }
}
