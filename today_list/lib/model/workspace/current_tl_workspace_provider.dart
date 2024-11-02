import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../external/tl_pref.dart';
import '../todo/tl_todo.dart';
import './tl_workspace.dart';
import './tl_workspaces_provider.dart';
import '../todo/tl_category.dart';
import '../todo/tl_todos.dart';

// currentWorkspaceを提供するProvider
final currentTLWorkspaceProvider =
    StateNotifierProvider.autoDispose<CurrentTLWorkspaceNotifier, TLWorkspace>(
        (ref) {
  final _tlWorkspaces = ref.watch(tlWorkspacesProvider);
  return CurrentTLWorkspaceNotifier(ref, _tlWorkspaces);
});

// currentWorkspaceを管理するNotifier
class CurrentTLWorkspaceNotifier extends StateNotifier<TLWorkspace> {
  final Ref ref;
  int currentTLWorkspaceIndex;

  CurrentTLWorkspaceNotifier(this.ref, List<TLWorkspace> workspaces)
      : currentTLWorkspaceIndex = 0,
        super(workspaces[0]) {
    // 初期化処理
    TLPref().getPref.then((pref) {
      final initialIndex = pref.getInt('currentWorkspaceIndex') ?? 0;
      currentTLWorkspaceIndex = initialIndex;
      state = workspaces[currentTLWorkspaceIndex];
    });
  }

  // 現在のワークスペースインデックスを変更する関数
  Future<void> changeCurrentWorkspaceIndex(
      {required int newCurrentWorkspaceIndex}) async {
    currentTLWorkspaceIndex = newCurrentWorkspaceIndex;
    state = ref.read(tlWorkspacesProvider)[currentTLWorkspaceIndex];
    await TLPref().getPref.then((pref) {
      pref.setInt('currentWorkspaceIndex', newCurrentWorkspaceIndex);
    });
  }

  // 現在のworkspaceの今日でチェック済みtodoを全て削除するための関数
  Future<void> deleteCheckedToDosInTodayInCurrentWorkspace() async {
    final tlWorkspacesNotifier = ref.read(tlWorkspacesProvider.notifier);
    final TLWorkspace selectedWorkspace = state;

    for (TLCategory bigCategory in selectedWorkspace.bigCategories) {
      // bigCategoryに関するチェック済みToDoの削除
      deleteAllCheckedToDosInAToDos(
        onlyToday: true,
        selectedWorkspaceIndex: currentTLWorkspaceIndex,
        selectedWorkspace: selectedWorkspace,
        selectedToDos: selectedWorkspace.toDos[bigCategory.id]!,
      );
      for (TLCategory smallCategory
          in selectedWorkspace.smallCategories[bigCategory.id]!) {
        // smallCategoryに関するチェック済みToDoの削除
        deleteAllCheckedToDosInAToDos(
            onlyToday: true,
            selectedWorkspaceIndex: currentTLWorkspaceIndex,
            selectedWorkspace: selectedWorkspace,
            selectedToDos: selectedWorkspace.toDos[smallCategory.id]!);
      }
    }

    // 更新されたワークスペースを保存
    tlWorkspacesNotifier.updateTLWorkspace(
        indexInWorkspaceList: currentTLWorkspaceIndex,
        updatedTLWorkspace: selectedWorkspace);
  }

  // 指定されたToDos内のチェック済みToDoを全て削除する関数
  void deleteAllCheckedToDosInAToDos({
    required bool onlyToday,
    int? selectedWorkspaceIndex,
    TLWorkspace? selectedWorkspace,
    required TLToDos selectedToDos,
  }) {
    // チェックされているToDoを削除
    selectedToDos.toDosInToday.removeWhere((todo) => todo.isChecked);
    if (!onlyToday) {
      selectedToDos.toDosInWhenever.removeWhere((todo) => todo.isChecked);
    }
    // 残っているToDo内のチェックされているステップを削除
    for (TLToDo todo in selectedToDos.toDosInToday) {
      todo.steps.removeWhere((step) => step.isChecked);
    }
    for (TLToDo todo in selectedToDos.toDosInWhenever) {
      todo.steps.removeWhere((step) => step.isChecked);
    }
  }
}
