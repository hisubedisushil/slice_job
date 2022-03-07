import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../constants/app_colors.dart';
import '../../../models/company_model.dart';

class TopEmployerListItem extends StatelessWidget {
  final CompanyModel company;

  const TopEmployerListItem({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: CachedNetworkImage(
              imageUrl: company.photo ?? '',
              errorWidget: (cxt, str, val) {
                return Center(
                  child: Icon(
                    Ionicons.alert_circle_outline,
                    color: AppColors.red,
                    size: 36.0,
                  ),
                );
              },
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
