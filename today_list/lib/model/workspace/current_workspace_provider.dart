import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../external/tl_pref.dart';
import './tl_workspace.dart';
import './tl_workspaces_provider.dart';
import '../todo/tl_category.dart';

// currentWorkspaceを提供するProvider
final currentWorkspaceProvider =
    StateNotifierProvider.autoDispose<CurrentWorkspaceNotifier, TLWorkspace>(
        (ref) {
  final _tlWorkspaces = ref.watch(tlWorkspacesProvider);
  return CurrentWorkspaceNotifier(ref, _tlWorkspaces);
});

// currentWorkspaceを管理するNotifier
class CurrentWorkspaceNotifier extends StateNotifier<TLWorkspace> {
  final Ref ref;
  int currentWorkspaceIndex;

  CurrentWorkspaceNotifier(this.ref, List<TLWorkspace> workspaces)
      : currentWorkspaceIndex = 0,
        super(workspaces[0]) {
    // 初期化処理
    TLPref().getPref.then((pref) {
      final initialIndex = pref.getInt('currentWorkspaceIndex') ?? 0;
      currentWorkspaceIndex = initialIndex;
      state = workspaces[currentWorkspaceIndex];
    });
  }

  // 現在のワークスペースインデックスを変更する関数
  Future<void> changeCurrentWorkspaceIndex(int newCurrentWorkspaceIndex) async {
    currentWorkspaceIndex = newCurrentWorkspaceIndex;
    state = ref.read(tlWorkspacesProvider)[currentWorkspaceIndex];
    await TLPref().getPref.then((pref) {
      pref.setInt('currentWorkspaceIndex', newCurrentWorkspaceIndex);
    });
  }

  // 現在のworkspaceの今日でチェック済みtodoを全て削除するための関数
  Future<void> deleteCheckedToDosInTodayInAWorkspace() async {
    final tlWorkspacesNotifier = ref.read(tlWorkspacesProvider.notifier);
    final TLWorkspace selectedWorkspace = state;

    for (TLCategory bigCategory in selectedWorkspace.bigCategories) {
      // bigCategoryに関するcheckのsort
      deleteAllCheckedToDosInThisToDos(
        onlyToday: true,
        selectedWorkspaceIndex: currentWorkspaceIndex,
        selectedWorkspace: selectedWorkspace,
        selectedToDos: selectedWorkspace.toDos[bigCategory.id]!,
      );
      for (TLCategory smallCategory
          in selectedWorkspace.smallCategories[bigCategory.id]!) {
        // smallCategoryに関するcheckのsort
        deleteAllCheckedToDosInThisToDos(
            onlyToday: true,
            selectedWorkspaceIndex: currentWorkspaceIndex,
            selectedWorkspace: selectedWorkspace,
            selectedToDos: selectedWorkspace.toDos[smallCategory.id]!);
      }
    }

    void deleteAllCheckedToDosInThisToDos({
      required bool onlyToday,
      int? selectedWorkspaceIndex,
      TLWorkspace? selectedWorkspace,
      required TLToDos selectedToDos,
    }) {
      // effortなどを更新する
      // ToDos.countDeletedToDo(
      //     selectedWorkspaceIndex: selectedWorkspaceIndex,
      //     selectedWorkspace: selectedWorkspace,
      //     numberOfDeletedToDo: selectedToDos.countCheckedToDosAndStepsInThisToDos(
      //         selectedToDos: selectedToDos));
      // チェックされているtodoを消す
      selectedToDos.toDosInToday.removeWhere((todo) => todo.isChecked);
      if (!onlyToday) {
        selectedToDos.toDosInWhenever.removeWhere((todo) => todo.isChecked);
      }
      // 残っているものでstepがチェックされているものを消す
      for (TLToDo todo in selectedToDos.toDosInToday) {
        todo.steps.removeWhere((step) => step.isChecked);
      }
      for (TLToDo todo in selectedToDos.toDosInWhenever) {
        todo.steps.removeWhere((step) => step.isChecked);
      }
      // ここでセーブとかvibrateしたら複数になることがある
    }

    // 更新されたワークスペースを保存
    tlWorkspacesNotifier.updateWorkspace(
        currentWorkspaceIndex, selectedWorkspace);
  }
}
