import 'package:flutter/material.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/experience.dart';
import 'package:slice_job/models/country_model.dart';

class WorkEducationFormScreen extends StatefulWidget {
  final Education? education;

  const WorkEducationFormScreen({
    Key? key,
    this.education,
  }) : super(key: key);

  @override
  State<WorkEducationFormScreen> createState() =>
      _WorkEducationFormScreenState();
}

class _WorkEducationFormScreenState extends State<WorkEducationFormScreen> {
  final _degree = TextEditingController();
  final _field = TextEditingController();
  final _institution = TextEditingController();
  final _city = TextEditingController();
  CountryModel? _country;

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

  final List<String> _endYears = [
    'Present',
    for (int i = 1950; i <= DateTime.now().year; i += 1) i.toString()
  ];

  final List<String> _endMonths = [
    'Present',
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

    if (widget.education != null) {
      _degree.text = widget.education?.degree ?? '';
      _field.text = widget.education?.field ?? '';
      _institution.text = widget.education?.institution ?? '';
      _city.text = widget.education?.city ?? '';
      try {
        _startYear = _years.firstWhere(
          (e) => widget.education?.startYear == e,
        );
      } catch (e) {}
      try {
        _endYear = _endYears.firstWhere(
          (e) => widget.education?.endYear == e,
        );
      } catch (e) {}
      try {
        _startMonth = _months.firstWhere(
          (e) => widget.education?.startMonth == e,
        );
      } catch (e) {}
      try {
        _endMonth = _endMonths.firstWhere(
          (e) => widget.education?.endMonth == e,
        );
      } catch (e) {}
      try {
        // _country = context.read<GeneralController>().countries.firstWhere(
        //       (e) => widget.education?.country == e.name,
        //     );
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    _degree.dispose();
    _field.dispose();
    _institution.dispose();
    _city.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final generalController = context.read<GeneralController>();

    return Material(
      color: AppColors.white,
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        appBar: AppBar(
          title: Text(
            '${widget.education != null ? 'Update' : 'Add'} CV Education',
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
                      'Degree',
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
                  controller: _degree,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Field of Study',
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
                  controller: _field,
                  // validator: (value) {
                  //   if (((value ?? '').length < 10)) {
                  //     return 'Mobile number must have 10 digits.';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'Institution',
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
                  controller: _institution,
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
                        'Country',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      // DropdownButton<CountryModel>(
                      //   value: _country,
                      //   items: generalController.countries.map((item) {
                      //     return DropdownMenuItem(
                      //       value: item,
                      //       child: Text(
                      //         item.name ?? '',
                      //         style: TextStyle(
                      //           fontSize: 16.0,
                      //           fontWeight: FontWeight.bold,
                      //           color: AppColors.black,
                      //         ),
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     FocusScope.of(context).requestFocus(FocusNode());
                      //     _country = value;
                      //     if (mounted) {
                      //       setState(() {});
                      //     }
                      //   },
                      //   hint: Text(
                      //     'Select country',
                      //     style: TextStyle(
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.bold,
                      //       color: AppColors.grey,
                      //     ),
                      //   ),
                      //   isExpanded: true,
                      //   underline: Container(),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    label: const Text(
                      'City',
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
                  controller: _city,
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
                        items: _endMonths.map((item) {
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
                        items: _endYears.map((item) {
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
                    widget.education != null ? 'Update' : 'Add',
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
    //     context.read<ProfileController>().postEducation(
    //           id: widget.education?.id,
    //           degree: _degree.text,
    //           field: _field.text,
    //           institution: _institution.text,
    //           country: _country?.name ?? '',
    //           city: _city.text,
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
    //     message: "Education Saved Successfully.",
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
