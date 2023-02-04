import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/features/others/provider/pages_provider.dart';
import 'package:slice_job/helpers/util/util.dart';

final aboutUsRef =
    StateNotifierProvider.autoDispose<PagesProvider, BaseState>((ref) {
  return PagesProvider(ref: ref);
});

class AboutUsScreen extends ConsumerStatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends ConsumerState<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(aboutUsRef.notifier).getAboutInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('About Us'),
        ),
        body: ref.watch(aboutUsRef).maybeWhen(
          loading: () {
            return const SizedBox(
              width: double.infinity,
              height: 100,
              child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
          success: (data, extraData) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: HtmlWidget(
                data.postDesc ?? '',
                onTapUrl: (url) async {
                  return openUrl(url);
                },
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
              ),
            );
          },
          orElse: () {
            return Container(
              color: Colors.amber,
            );
          },
        ),
      ),
    );
  }
}
