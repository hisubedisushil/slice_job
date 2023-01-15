import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/test/test_response.dart';
import 'package:slice_job/helpers/util/util.dart';

extension QuestionX on Question {
  Widget getWidgetForType({bool showParagraph = true}) {
    switch (type) {
      case 'case':
        {
          if (showParagraph) {
            return HtmlWidget(
              paragraph ?? '',
              onTapUrl: (uri) async {
                return openUrl(uri);
              },
              textStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            );
          } else {
            return const SizedBox();
          }
        }
      default:
        return const SizedBox();
    }
  }
}
