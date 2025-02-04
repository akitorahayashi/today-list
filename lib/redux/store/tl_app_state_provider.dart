import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/redux/reducer/tl_app_state_reducer.dart';

final tlAppStateProvider =
    StateNotifierProvider<TLAppStateReducer, TLAppState>((ref) {
  return TLAppStateReducer();
});
