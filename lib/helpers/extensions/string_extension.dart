import 'package:path/path.dart';

extension StringX on String {
  String cacheKey() {
    final fileName = basename(this);
    return fileName;
  }
}
