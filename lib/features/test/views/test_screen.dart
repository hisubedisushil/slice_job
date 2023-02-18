import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:slice_job/app/entities/base_state.dart';
import 'package:slice_job/app/entities/failure.dart';
import 'package:slice_job/app_setup/routes/router.dart';
import 'package:slice_job/core/models/test/test_response.dart';
import 'package:slice_job/features/test/provider/test_provider.dart';
import 'package:slice_job/features/test/test_util.dart';
import 'package:slice_job/helpers/extensions/context_extension.dart';
import 'package:slice_job/helpers/extensions/padding_extensions.dart';
import 'package:slice_job/helpers/util/util.dart';
import 'package:url_launcher/url_launcher.dart';

import '/constants/app_colors.dart';

final testRef =
    StateNotifierProvider.autoDispose<TestProvider, BaseState>((ref) {
  return TestProvider(ref: ref);
});

final submitTestRef =
    StateNotifierProvider.autoDispose<TestProvider, BaseState>((ref) {
  return TestProvider(ref: ref);
});

class TestScreen extends ConsumerStatefulWidget {
  final TestCategory category;

  const TestScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  Timer? _timer;
  ValueNotifier<int> currentQuestion = ValueNotifier<int>(0);
  ValueNotifier<bool> showParagraph = ValueNotifier<bool>(true);
  final List<Answer> _answers = [];
  final ValueNotifier<int> _remainingTime = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _startTest();
  }

  void _startTest() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(testRef.notifier).startTest(widget.category.id);
    });
  }

  void _finishTest(String entranceSet) {
    if (_timer != null) {
      _timer!.cancel();
    }
    ref.read(submitTestRef.notifier).finishTest(
          categoryId: widget.category.id,
          entranceSet: entranceSet,
          answers: _answers,
        );
  }

  _startTimer(final int remainingTime) {
    _remainingTime.value = remainingTime;
    _timer = Timer.periodic(
        const Duration(
          seconds: 1,
        ), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value = _remainingTime.value - 1;
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseState>(
      submitTestRef,
      (previous, next) {
        if (next is BaseLoading) {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalSpacer(20.h),
                  const CircularProgressIndicator(),
                  verticalSpacer(10.h),
                  Text(
                    'Submitting Test and generating result...',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ),
                  verticalSpacer(20.h),
                ],
              ),
            ),
          );
        } else {
          Navigator.of(context).pop();
          if (next is BaseSuccess) {
            final result = next.data as TestResult;
            context.pushReplacementNamed(testCompleteRoute, extra: {
              'category': widget.category,
              'result': result,
            });
          } else if (next is BaseError) {
            final errorData = next.data as Failure;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errorData.reason,
                ),
              ),
            );
          }
        }
      },
    );
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80.h),
          child: AppBar(
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpacer(16.h),
                Text(
                  widget.category.name ?? '',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: 10.w,
                        bottom: 5.h,
                      ),
                      child: ValueListenableBuilder<int>(
                          valueListenable: _remainingTime,
                          builder: (context, value, child) {
                            return Text(
                              _getTimer(value),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: ref.watch(testRef).maybeWhen(
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          success: (data, extraData) {
            final testData = data as Test;
            final testTime = testData.set?.examDuration ?? 0;
            if (_timer == null) {
              _startTimer(testTime);
            }
            if ((testData.questions ?? []).isNotEmpty) {
              final questions = testData.questions!;
              return ValueListenableBuilder<int>(
                  valueListenable: currentQuestion,
                  builder: (context, questionIndex, child) {
                    final questionKey = GlobalKey<FormBuilderState>();
                    final question = questions[questionIndex];
                    final isLast = questionIndex >= questions.length - 1;
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                        // left: 16.0,
                        right: 16.h,
                        top: 16.h,
                        bottom: 50.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: showParagraph,
                            builder: (context, value, child) {
                              return Column(
                                children: [
                                  question.getWidgetForType(
                                      showParagraph: value),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        showParagraph.value = !value;
                                      },
                                      child: Text(
                                        '${!value ? 'Show' : 'Hide'} Case Study',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          verticalSpacer(10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Q.${questionIndex + 1}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grey,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: HtmlWidget(
                                  question.question ?? '',
                                  onTapUrl: (uri) async {
                                    final url = Uri.parse(uri);
                                    launchUrl(url);
                                    return await canLaunchUrl(url);
                                  },
                                  textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ).pX(16.w),
                          verticalSpacer(20.h),
                          // answer options begins here
                          AnswerOptionsWidget(
                            question: question,
                            qKey: questionKey,
                          ),
                          const SizedBox(height: 24.0),
                          Consumer(
                            builder: (context, ref, child) {
                              final isLoading =
                                  ref.watch(submitTestRef).maybeWhen(
                                        loading: () => true,
                                        orElse: () => false,
                                      );
                              return MaterialButton(
                                onPressed: () async {
                                  if (isLoading) return;
                                  if (questionKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    final formValue =
                                        questionKey.currentState!.value;
                                    final answerOption =
                                        (question.type == "written"
                                            ? formValue['written']
                                            : formValue['options']) as String;
                                    final answer = Answer(
                                      id: question.id,
                                      qno: questionIndex + 1,
                                      question: question.question,
                                      answer: question.answer,
                                      txt: question.type == "written"
                                          ? answerOption
                                          : '',
                                      option: question.type != "written"
                                          ? answerOption
                                          : '',
                                    );
                                    log('saveAnswerOption: $answerOption');
                                    _answers.add(answer);
                                    if (isLast) {
                                      _finishTest(question.setId!);
                                    } else {
                                      currentQuestion.value = questionIndex + 1;
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: AppColors.primary,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                minWidth: 120.0,
                                height: 44.0,
                                elevation: 0.0,
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        isLast ? 'Finish Test' : 'Next',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              );
                            },
                          ),
                          const SizedBox(height: 60.0),
                        ],
                      ),
                    );
                  });
            } else {
              return Text(
                'No Questions available at the moment.',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              );
            }
          },
          orElse: () {
            return const Center(
              child: SizedBox(),
            );
          },
        ),
      ),
    );
  }

  String _getTimer(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;

    return '${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s} minutes';
  }
}

class AnswerOptionsWidget extends StatefulWidget {
  const AnswerOptionsWidget({
    super.key,
    required this.question,
    required this.qKey,
  });

  final Question question;
  final GlobalKey<FormBuilderState> qKey;

  @override
  State<AnswerOptionsWidget> createState() => _AnswerOptionsWidgetState();
}

class _AnswerOptionsWidgetState extends State<AnswerOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    final qType = question.type;
    return FormBuilder(
      key: widget.qKey,
      child: Builder(
        builder: (context) {
          if (qType == 'written') {
            return FormBuilderTextField(
              name: 'written',
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: AppColors.white.withOpacity(0.8),
                hintStyle: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Please write to continue.';
                }
                return null;
              },
              maxLines: 10,
              // controller: _txt,
            );
          } else {
            final options = qType == 'yes_no'
                ? ['No', 'Yes']
                : [
                    question.optionA,
                    question.optionB,
                    question.optionC,
                    question.optionD,
                  ]
                    .where((element) => element != null && element.isNotEmpty)
                    .toList();
            return FormBuilderRadioGroup<String?>(
              name: 'options',
              valueTransformer: (value) {
                String answerToSave = "";
                if (qType == "yes_no") {
                  answerToSave = options.indexOf(value).toString();
                } else {
                  final answeredIndex = options.indexOf(value);
                  switch (answeredIndex) {
                    case 0:
                      answerToSave = 'a';
                      break;
                    case 1:
                      answerToSave = 'b';
                      break;
                    case 2:
                      answerToSave = 'c';
                      break;
                    case 3:
                      answerToSave = 'd';
                      break;
                  }
                }
                log('selected: $value, answerToSave: $answerToSave,');
                return answerToSave;
              },
              decoration: InputDecoration(
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              options: options
                  .map((e) => FormBuilderFieldOption(value: e))
                  .toList(growable: false),
            ).pL(16.w);
          }
        },
      ),
    );
  }
}
