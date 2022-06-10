import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/general_controller.dart';
import '../../../models/job_category_model.dart';
import '../../../models/job_type_model.dart';

class FilterSheet extends StatefulWidget {
  final JobCategoryModel? category;
  final JobTypeModel? type;
  final JobTypeModel? level;
  final JobTypeModel? salary;
  final JobTypeModel? education;
  final JobTypeModel? experience;
  final Function(
    JobCategoryModel? category,
    JobTypeModel? type,
    JobTypeModel? level,
    JobTypeModel? salary,
    JobTypeModel? education,
    JobTypeModel? experience,
  ) onFilter;

  const FilterSheet({
    Key? key,
    this.category,
    this.type,
    required this.onFilter,
    this.level,
    this.salary,
    this.education,
    this.experience,
  }) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  JobCategoryModel? _category;
  JobTypeModel? _type;
  JobTypeModel? _level;
  JobTypeModel? _salary;
  JobTypeModel? _education;
  JobTypeModel? _experience;

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      _category = context
          .read<GeneralController>()
          .allCategories
          .firstWhere((element) => element.id == widget.category?.id);
    }

    if (widget.type != null) {
      _type = context
          .read<GeneralController>()
          .jobTypes
          .firstWhere((element) => element.id == widget.type?.id);
    }

    if (widget.level != null) {
      _level = context
          .read<GeneralController>()
          .jobCareerLevels
          .firstWhere((element) => element.id == widget.level?.id);
    }

    if (widget.salary != null) {
      _salary = context
          .read<GeneralController>()
          .salaries
          .firstWhere((element) => element.id == widget.salary?.id);
    }

    if (widget.education != null) {
      _education = context
          .read<GeneralController>()
          .educationLevels
          .firstWhere((element) => element.id == widget.education?.id);
    }

    if (widget.experience != null) {
      _experience = context
          .read<GeneralController>()
          .experienceLevels
          .firstWhere((element) => element.id == widget.experience?.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final generalController = context.watch<GeneralController>();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15.0),
          Container(
            width: 120.0,
            height: 5.0,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          const SizedBox(height: 15.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.white,
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Job Category',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _category = null;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Ionicons.close_circle,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                DropdownButton<JobCategoryModel>(
                  value: _category,
                  items: generalController.allCategories.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _category = value;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  hint: Text(
                    'Select Job Category',
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Job Type',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _type = null;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Ionicons.close_circle,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                DropdownButton<JobTypeModel>(
                  value: _type,
                  items: generalController.jobTypes.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _type = value;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  hint: Text(
                    'Select Job Type',
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Career Level',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _level = null;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Ionicons.close_circle,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                DropdownButton<JobTypeModel>(
                  value: _level,
                  items: generalController.jobCareerLevels.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _level = value;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  hint: Text(
                    'Select Career Level',
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Job Salary',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _salary = null;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Ionicons.close_circle,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                DropdownButton<JobTypeModel>(
                  value: _salary,
                  items: generalController.salaries.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _salary = value;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  hint: Text(
                    'Select Job Salary',
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Education Level',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _education = null;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Ionicons.close_circle,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                DropdownButton<JobTypeModel>(
                  value: _education,
                  items: generalController.educationLevels.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _education = value;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  hint: Text(
                    'Select Education Level',
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Experience Level',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _experience = null;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Ionicons.close_circle,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                DropdownButton<JobTypeModel>(
                  value: _experience,
                  items: generalController.experienceLevels.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.name ?? '',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _experience = value;
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
          const SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Flexible(
                  child: MaterialButton(
                    onPressed: () => widget.onFilter(
                      _category,
                      _type,
                      _level,
                      _salary,
                      _education,
                      _experience,
                    ),
                    child: Text(
                      'Apply Filter',
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
                    height: 48.0,
                    elevation: 0.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                Flexible(
                  child: MaterialButton(
                    onPressed: () => widget.onFilter(
                      null,
                      null,
                      null,
                      null,
                      null,
                      null,
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: AppColors.red,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: double.infinity,
                    height: 48.0,
                    elevation: 0.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 20.0,
          )
        ],
      ),
    );
  }
}
