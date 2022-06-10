import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '/constants/app_colors.dart';
import '/controllers/test_controller.dart';
import '/models/answer_model.dart';
import '/models/question_model.dart';
import '/models/test_category_model.dart';
import '/models/test_finish_response_model.dart';
import '/models/test_start_response_model.dart';

class TestView extends StatefulWidget {
  final TestCategoryModel category;

  const TestView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  TestStartResponseModel? _startResponseModel;
  bool _loading = true;
  Timer? _timer;
  int _remainingTime = 0;

  int? _optionSelected;
  String _selectedOption = '';
  final _txt = TextEditingController();
  bool _showParagraph = true;

  TestFinishResponseModel? _finishResponseModel;
  int _currentIndex = 0;
  bool _finished = false;

  final List<AnswerModel> _answers = [];

  @override
  void initState() {
    super.initState();

    _getTestStart();
  }

  _getTestStart() async {
    if (!_loading) {
      _loading = true;
      if (mounted) {
        setState(() {});
      }
    }

    final test = context.read<TestController>();
    _startResponseModel = await test.getTestStart(
      categoryId: widget.category.id ?? '',
    );

    _remainingTime = _startResponseModel?.data?.set?.examDuration ?? 0;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingTime > 0) {
          _remainingTime--;
          if (mounted) {
            setState(() {});
          }
        } else {
          _timer?.cancel();
        }
      },
    );

    _loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  _finishTest() async {
    if (!_loading) {
      _loading = true;
      if (mounted) {
        setState(() {});
      }
    }

    final test = context.read<TestController>();
    _finishResponseModel = await test.getTestFinish(
      categoryId: widget.category.id ?? '',
      entranceSet: _startResponseModel?.data?.set?.id ?? '',
      answers: _answers,
    );

    if (_finishResponseModel != null) {
      _finished = true;
    }
    _loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  _answerQuestion(
    QuestionModel? model,
    int index,
    String txt,
    String option,
  ) {
    if (model != null) {
      _answers.add(
        AnswerModel(
          id: model.id,
          qno: index + 1,
          question: model.question,
          answer: model.answer,
          txt: txt,
          option: option,
        ),
      );

      _txt.text = '';
      _selectedOption = '';
      _optionSelected = null;

      _currentIndex = _currentIndex + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(_startResponseModel?.data?.set?.setName ??
              widget.category.name ??
              ''),
          actions: [
            if (!_finished)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    _getTimer(_remainingTime),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : _finished
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'CONGRATULATIONS!',
                            style: TextStyle(
                              fontSize: 34.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.green,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'You Just Finish',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
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
                            child: Text(
                              'Finish',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 80.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'case' &&
                            _showParagraph)
                          HtmlWidget(
                            _startResponseModel?.data?.questions?[_currentIndex]
                                    .paragraph ??
                                '',
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
                        if (_startResponseModel
                                ?.data?.questions?[_currentIndex].type ==
                            'case')
                          TextButton(
                            onPressed: () {
                              _showParagraph = !_showParagraph;
                              setState(() {});
                            },
                            child: Text(
                              '${!_showParagraph ? 'Show' : 'Hide'} Case Study',
                            ),
                          ),
                        if (_startResponseModel
                                ?.data?.questions?[_currentIndex].type ==
                            'case')
                          const SizedBox(height: 16.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Q.${_currentIndex + 1}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: HtmlWidget(
                                _startResponseModel?.data
                                        ?.questions?[_currentIndex].question ??
                                    '',
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
                        ),
                        const SizedBox(height: 24.0),
                        if (_startResponseModel
                                ?.data?.questions?[_currentIndex].type ==
                            'written')
                          TextFormField(
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'Please write to continue.';
                              }
                              return null;
                            },
                            maxLines: 10,
                            controller: _txt,
                          ),
                        if (_startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'choose' ||
                            _startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'case')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _optionSelected,
                                onChanged: (value) {
                                  _optionSelected = value as int;
                                  _selectedOption = _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionA ??
                                      '';
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: HtmlWidget(
                                  _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionA ??
                                      '',
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
                          ),
                        if (_startResponseModel
                                ?.data?.questions?[_currentIndex].type ==
                            'yes_no')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _optionSelected,
                                onChanged: (value) {
                                  _optionSelected = value as int;
                                  _selectedOption = 'Yes';
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: HtmlWidget(
                                  'Yes',
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
                          ),
                        const SizedBox(height: 8.0),
                        if (_startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'choose' ||
                            _startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'case')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _optionSelected,
                                onChanged: (value) {
                                  _optionSelected = value as int;
                                  _selectedOption = _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionB ??
                                      '';
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: HtmlWidget(
                                  _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionB ??
                                      '',
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
                          ),
                        if (_startResponseModel
                                ?.data?.questions?[_currentIndex].type ==
                            'yes_no')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _optionSelected,
                                onChanged: (value) {
                                  _optionSelected = value as int;
                                  _selectedOption = 'No';
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: HtmlWidget(
                                  'No',
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
                          ),
                        const SizedBox(height: 8.0),
                        if (_startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'choose' ||
                            _startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'case')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _optionSelected,
                                onChanged: (value) {
                                  _optionSelected = value as int;
                                  _selectedOption = _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionC ??
                                      '';
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: HtmlWidget(
                                  _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionC ??
                                      '',
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
                          ),
                        const SizedBox(height: 8.0),
                        if (_startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'choose' ||
                            _startResponseModel
                                    ?.data?.questions?[_currentIndex].type ==
                                'case')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 4,
                                groupValue: _optionSelected,
                                onChanged: (value) {
                                  _optionSelected = value as int;
                                  _selectedOption = _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionD ??
                                      '';
                                  setState(() {});
                                },
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: HtmlWidget(
                                  _startResponseModel?.data
                                          ?.questions?[_currentIndex].optionD ??
                                      '',
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
                          ),
                        const SizedBox(height: 24.0),
                        MaterialButton(
                          onPressed: () async {
                            if (_selectedOption.trim().isEmpty &&
                                _txt.text.trim().isEmpty) {
                              return;
                            }
                            _answerQuestion(
                              _startResponseModel
                                  ?.data?.questions?[_currentIndex],
                              _currentIndex,
                              _txt.text.trim(),
                              _selectedOption,
                            );

                            if (_currentIndex >=
                                (_startResponseModel?.data?.questions ?? [])
                                    .length) {
                              await _finishTest();
                            }

                            setState(() {});
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
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 60.0),
                      ],
                    ),
                  ),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    _txt.dispose();
    super.dispose();
  }

  String _getTimer(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;

    return '${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s} minutes';
  }
}
