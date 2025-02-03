import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/redux/action/todo/tl_todo_action.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/tl_workspace_reducer.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';

class TLAppStateNotifier extends StateNotifier<TLAppState> {
  TLAppStateNotifier()
      : super(TLAppState(
            tlWorkspaces: initialTLWorkspaces, currentWorkspaceIndex: 0)) {
    // _loadWorkspaces();
  }

  void dispatchTodoAction(TLToDoAction action) {
    // state = state.copyWith(
    //   todos: RPTodosReducer.handle(state.todos, action),
    // );
  }

  void dispatchWorkspaceAction(TLWorkspaceAction action) {
    state = action.map(
      changeCurrentWorkspaceIndex: (a) => state.copyWith(
        currentWorkspaceIndex: a.newIndex,
      ),
      addWorkspace: (a) => state.copyWith(
        tlWorkspaces: TLWorkspaceReducer.handle(
            state.tlWorkspaces, action, state.currentWorkspaceIndex),
      ),
      removeWorkspace: (a) => state.copyWith(
        tlWorkspaces: TLWorkspaceReducer.handle(
            state.tlWorkspaces, action, state.currentWorkspaceIndex),
      ),
      updateCurrentWorkspace: (a) => state.copyWith(
        tlWorkspaces: TLWorkspaceReducer.handle(
            state.tlWorkspaces, action, state.currentWorkspaceIndex),
      ),
      updateWorkspaceList: (a) => state.copyWith(
        tlWorkspaces: TLWorkspaceReducer.handle(
            state.tlWorkspaces, action, state.currentWorkspaceIndex),
      ),
    );
  }

  // void dispatchCategoryAction(RPTodoCategoryAction action) {
  //   state = state.copyWith(
  //     categories: RpCategoriesReducer.handle(state.categories, action),
  //   );
  // }
}
