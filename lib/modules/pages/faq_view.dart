import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../controllers/general_controller.dart';

class FAQView extends StatelessWidget {
  const FAQView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final general = context.watch<GeneralController>();
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('FAQ\'s'),
        ),
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          itemCount: (general.faq?.data ?? []).length,
          separatorBuilder: (cxt, i) => const SizedBox(height: 10.0),
          itemBuilder: (cxt, i) {
            final faq = general.faq?.data?[i];
            return Material(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.0),
              child: Theme(
                data: ThemeData().copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: Text(
                    faq?.question ?? '',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 10.0,
                        bottom: 10.0,
                      ),
                      child: HtmlWidget(
                        faq?.answer ?? '',
                        onTapUrl: (url) async {
                          launch(url);
                          return await canLaunch(url);
                        },
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
