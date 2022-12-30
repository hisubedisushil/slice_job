import 'package:flutter_riverpod/flutter_riverpod.dart';

extension ProviderBaseX on ProviderBase {
  String get nameOrType => '${name ?? runtimeType}';
}
