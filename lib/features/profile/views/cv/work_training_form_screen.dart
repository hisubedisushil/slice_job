import 'package:flutter/material.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/experience.dart';

class WorkTrainingFormScreen extends StatefulWidget {
  final Training? training;

  const WorkTrainingFormScreen({
    Key? key,
    this.training,
  }) : super(key: key);

  @override
  State<WorkTrainingFormScreen> createState() => _WorkTrainingFormScreenState();
}

class _WorkTrainingFormScreenState extends State<WorkTrainingFormScreen> {
  final _title = TextEditingController();
  String? _startYear;
  String? _startMonth;
  String? _endYear;
  String? _endMonth;

  final List<String> _years = [
    for (int i = 1950; i <= DateTime.now().year; i += 1) i.toString()
  ];
  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.training != null) {
      _title.text = widget.training?.title ?? '';
      try {
        _startYear = _years.firstWhere(
          (e) => widget.training?.startYear == e,
        );
      } catch (e) {}
      try {
        _endYear = _years.firstWhere(
          (e) => widget.training?.endYear == e,
        );
      } catch (e) {}
      try {
        _startMonth = _months.firstWhere(
          (e) => widget.training?.startMonth == e,
        );
      } catch (e) {}
      try {
        _endMonth = _months.firstWhere(
          (e) => widget.training?.endMonth == e,
        );
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(
            '${widget.training != null ? 'Update' : 'Add'} CV Training',
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Training Title',
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
                  controller: _title,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start Month',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<String>(
                        value: _startMonth,
                        items: _months.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _startMonth = value;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        hint: Text(
                          'Select Start Month',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                        ),
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start Year',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<String>(
                        value: _startYear,
                        items: _years.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _startYear = value;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        hint: Text(
                          'Select Start Year',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                        ),
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'End Month',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<String>(
                        value: _endMonth,
                        items: _months.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _endMonth = value;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        hint: Text(
                          'Select End Month',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                        ),
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'End Year',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<String>(
                        value: _endYear,
                        items: _years.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _endYear = value;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        hint: Text(
                          'Select End Year',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey,
                          ),
                        ),
                        isExpanded: true,
                        underline: Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                MaterialButton(
                  onPressed: _add,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: AppColors.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: double.infinity,
                  height: 56.0,
                  elevation: 0.0,
                  child: Text(
                    widget.training != null ? 'Update' : 'Add',
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
      ),
    );
  }

  _add() async {
    FocusScope.of(context).requestFocus(FocusNode());

    // String result = await showDialog(
    //   context: context,
    //   builder: (context) => FutureProgressDialog(
    //     context.read<ProfileController>().postTraining(
    //           id: widget.training?.id,
    //           title: _title.text,
    //           startMonth: _startMonth ?? '',
    //           startYear: _startYear ?? '',
    //           endMonth: _endMonth ?? '',
    //           endYear: _endYear ?? '',
    //         ),
    //   ),
    // );
    // log(result.toString());

    // if (result.isEmpty) {
    //   await PanaraInfoDialog.showAnimatedGrow(
    //     context,
    //     title: "Success",
    //     message: "Training Saved Successfully.",
    //     buttonText: 'Okay',
    //     onTapDismiss: () => Navigator.pop(context),
    //     panaraDialogType: PanaraDialogType.success,
    //     barrierDismissible: true,
    //   );
    //   Navigator.pop(context);
    // } else {
    //   await PanaraInfoDialog.showAnimatedGrow(
    //     context,
    //     title: "Failed",
    //     message: result,
    //     buttonText: 'Okay',
    //     onTapDismiss: () => Navigator.pop(context),
    //     panaraDialogType: PanaraDialogType.error,
    //     barrierDismissible: true,
    //   );
    //   return;
    // }
  }
}
