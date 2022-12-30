

import 'package:flutter_riverpod/flutter_riverpod.dart';

// final userProvider = Provider.autoDispose<SessionResponse>((ref) {
//   final u = ref.watch(appController.notifier).state;
//   return u.maybeMap(
//     authenticated: (s) => s.data,
//     orElse: () => SessionResponse(token: '', niceName: '', displayName: '', userFirstName: '', userLastName: '', acf: Acf(), motherStatus: MotherStatus()),
//   );
// });
// ///
// final appController =
//     StateNotifierProvider<AppStateNotifier, AppState<SessionResponse>>((ref) {
//   return AppStateNotifier(ref.read)..appStarted();
// });

// class AppStateNotifier extends StateNotifier<AppState<SessionResponse>> {
//   ///
//   AppStateNotifier(this._read) : super(const AppState.started());

//   final Reader _read;

//   Future<void> appStarted() async {
//     final _db = _read(obDbProvider);
//     await _db.init();
//     final session = _read(obDbProvider).loggedUser();
//     if (session != null) {
//       Future.delayed(Duration.zero, () {
//         state = AppState.authenticated(session);
//       });
//     } else {
//       Future.delayed(Duration.zero, () {
//         state = const AppState.unAuthenticated();
//       });
//     }
//   }

//   Future<void> unAuthenticated() async {
//     _read(obDbProvider).logOut();
//     Future.delayed(Duration.zero, () {
//       state = const AppState.unAuthenticated();
//     });
//   }

//   void updateAppState(AppState<SessionResponse> appState) {
//     Future.delayed(Duration.zero, () {
//       state = appState;
//     });
//   }
// }
