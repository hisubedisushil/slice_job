import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/profile_controller.dart';
import '../../../models/language_model.dart';

class WorkLanguageFormView extends StatefulWidget {
  final LanguageModel? language;

  const WorkLanguageFormView({
    Key? key,
    this.language,
  }) : super(key: key);

  @override
  State<WorkLanguageFormView> createState() => _WorkLanguageFormViewState();
}

class _WorkLanguageFormViewState extends State<WorkLanguageFormView> {
  final _language = TextEditingController();
  String? _level;

  final List<String> _levels = [
    'Beginner',
    'Intermediate',
    'Expert',
    'Native',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.language != null) {
      _language.text = widget.language?.language ?? '';
      try {
        _level = _levels.firstWhere(
          (e) => widget.language?.level == e,
        );
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    _language.dispose();
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
            '${widget.language != null ? 'Update' : 'Add'} CV  Language',
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
                      'Language',
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
                  controller: _language,
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
                        'Level',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Divider(),
                      DropdownButton<String>(
                        value: _level,
                        items: _levels.map((item) {
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
                          _level = value;
                          setState(() {});
                        },
                        hint: Text(
                          'Select Experience Level',
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
                  child: Text(
                    widget.language != null ? 'Update' : 'Add',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: AppColors.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: double.infinity,
                  height: 56.0,
                  elevation: 0.0,
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

    String result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        context.read<ProfileController>().postLanguage(
              id: widget.language?.id,
              language: _language.text,
              level: _level ?? '',
            ),
      ),
    );
    log(result.toString());

    if (result.isEmpty) {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Success",
        message: "Language Saved Successfully.",
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.success,
        barrierDismissible: true,
      );
      Navigator.pop(context);
    } else {
      await PanaraInfoDialog.showAnimatedGrow(
        context,
        title: "Failed",
        message: result,
        buttonText: 'Okay',
        onTapDismiss: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: true,
      );
      return;
    }
  }
}
