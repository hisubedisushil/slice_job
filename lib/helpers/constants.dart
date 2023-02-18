import 'package:ionicons/ionicons.dart';
import 'package:slice_job/features/blogs/views/blogs_screen.dart';
import 'package:slice_job/features/home/home_screen.dart';
import 'package:slice_job/features/jobs/views/job_search_screen.dart';
import 'package:slice_job/features/profile/views/profile_screen.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

const String fKeyJobCategory = 'job_category';
const String fKeyJobTypeKey = 'job_type';
const String fKeyCareerLevelKey = 'career_level';
const String fKeyJobSalaryKey = 'job_salary';
const String fKeyEducationLevelKey = 'education_level';
const String fKeyExperienceKey = 'experience';
final List<String> currencies = ['USD', 'NRP'];
final List<String> months = [
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

final List<String> years = [
  for (int i = 1950; i <= DateTime.now().year; i += 1) i.toString()
];

final List<String> expLevels = ['Beginner', 'Intermediate', 'Expert'];
final List<String> lanExpLevels = [
  'Beginner',
  'Intermediate',
  'Expert',
  'Native'
];

const pages = [
  HomeScreen(),
  JobSearchScreen(),
  BlogsScreen(),
  ProfileScreen(),
];

final navBarItems = <BarItem>[
  BarItem(
    icon: Ionicons.home_outline,
    title: 'Home',
  ),
  BarItem(
    icon: Ionicons.briefcase_outline,
    title: 'Jobs',
  ),
  BarItem(
    icon: Ionicons.chatbox_ellipses_outline,
    title: 'Blogs',
  ),
  BarItem(
    icon: Ionicons.person_outline,
    title: 'Profile',
  ),
];
