import 'package:flutter/material.dart';
import 'package:slice_job/constants/app_colors.dart';
import 'package:slice_job/core/models/experience.dart';

class WorkSkillFormScreen extends StatefulWidget {
  final Skill? skill;

  const WorkSkillFormScreen({
    Key? key,
    this.skill,
  }) : super(key: key);

  @override
  State<WorkSkillFormScreen> createState() => _WorkSkillFormScreenState();
}

class _WorkSkillFormScreenState extends State<WorkSkillFormScreen> {
  final _skill = TextEditingController();
  String? _level;

  final List<String> _levels = ['Beginner', 'Intermediate', 'Expert'];

  @override
  void initState() {
    super.initState();

    if (widget.skill != null) {
      _skill.text = widget.skill?.skill ?? '';
      try {
        _level = _levels.firstWhere((e) => widget.skill?.level == e);
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    _skill.dispose();
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
            '${widget.skill != null ? 'Update' : 'Add'} CV Skill',
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
                      'Skill',
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
                  controller: _skill,
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
                        'Experience Level',
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
                          if (mounted) {
                            setState(() {});
                          }
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: AppColors.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: double.infinity,
                  height: 56.0,
                  elevation: 0.0,
                  child: Text(
                    widget.skill != null ? 'Update' : 'Add',
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
    //     context.read<ProfileController>().postSkill(
    //           id: widget.skill?.id,
    //           skill: _skill.text,
    //           level: _level ?? '',
    //         ),
    //   ),
    // );
    // log(result.toString());

    // if (result.isEmpty) {
    //   await PanaraInfoDialog.showAnimatedGrow(
    //     context,
    //     title: "Success",
    //     message: "Skill Saved Successfully.",
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
