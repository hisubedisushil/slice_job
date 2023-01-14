import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:slice_job/core/models/authentication/login_response.dart';
import 'package:slice_job/core/models/authentication/user.dart';

// Boxes
const String authDataBox = 'AuthDataBox';
const String userBox = 'UserBox';

// Type Ids
const int authDataTypeId = 0;
const int userTypeId = 1;
const int profileTypeId = 2;

final hiveProvider = Provider<HiveDB>((ref) {
  return HiveDB();
});

class HiveDB {
  //

  init(String path) async {
    await Hive.initFlutter(path);
    Hive.registerAdapter(AuthDataAdapter());
    Hive.registerAdapter(UserAdapter());
  }

  Future<LazyBox> openBox(String name) async {
    return Hive.isBoxOpen(name)
        ? Hive.lazyBox<dynamic>(name)
        : await Hive.openLazyBox(name);
  }

  Future<AuthData?> getSession() async {
    final sessionBox = await openBox(authDataBox);
    if (sessionBox.isEmpty) return null;
    final a = await sessionBox.getAt(0) as AuthData;
    log('session: $a ');
    return a;
  }

  Future<void> setSession(AuthData session) async {
    final sessionBox = await openBox(authDataBox);
    AuthData? prev;
    if (sessionBox.isEmpty) {
      await sessionBox.add(session);
      prev = null;
    } else {
      prev = await sessionBox.getAt(0);
      await sessionBox.putAt(0, session);
    }
    final curr = await sessionBox.getAt(0) as AuthData;
    log('setSession from: $prev to: $curr');
  }

  //
}
