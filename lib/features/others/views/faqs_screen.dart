import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/others/faq.dart';
import 'package:slice_job/features/others/provider/pages_provider.dart';
import 'package:slice_job/helpers/util/util.dart';

final faqsRef =
    StateNotifierProvider.autoDispose<PagesProvider, BaseState>((ref) {
  return PagesProvider(ref: ref);
});

class FaqsScreen extends ConsumerStatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends ConsumerState<FaqsScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ref.read(faqsRef.notifier).getFaqs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('FAQ\'s'),
        ),
        body: ref.watch(faqsRef).maybeWhen(
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
            final faqs = data as List<Faq>;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              itemCount: faqs.length,
              separatorBuilder: (cxt, i) => const SizedBox(height: 10.0),
              itemBuilder: (cxt, i) {
                final faq = faqs[i];
                return Material(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Theme(
                    data: ThemeData().copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      title: Text(
                        faq.question ?? '',
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
                            faq.answer ?? '',
                            onTapUrl: (url) async {
                              return openUrl(url);
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
