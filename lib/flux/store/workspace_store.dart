import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_vibration.dart';

// ワークスペースリストのプロバイダー
final workspacesProvider =
    AsyncNotifierProvider<WorkspacesNotifier, List<TLWorkspace>>(
      WorkspacesNotifier.new,
    );

// ワークスペースリストを管理するNotifier
class WorkspacesNotifier extends AsyncNotifier<List<TLWorkspace>> {
  static const _prefKey = 'tlWorkspaces';

  @override
  Future<List<TLWorkspace>> build() async {
    return _loadWorkspaces();
  }

  Future<List<TLWorkspace>> _loadWorkspaces() async {
    final pref = await TLPrefService().getPref;
    final stringWorkspaces = pref.getString(_prefKey);

    if (stringWorkspaces != null) {
      try {
        final List<dynamic> jsonWorkspaces = jsonDecode(stringWorkspaces);
        return jsonWorkspaces
            .map((json) => TLWorkspace.fromJson(json as Map<String, dynamic>))
            .toList();
      } catch (e) {
        return initialTLWorkspaces;
      }
    }
    return initialTLWorkspaces;
  }

  Future<void> _saveWorkspaces(List<TLWorkspace> workspaces) async {
    final pref = await TLPrefService().getPref;
    final encodedWorkspaces = jsonEncode(
      workspaces.map((w) => w.toJson()).toList(),
    );

    // iOSウィジェットの更新
    TCWiOSMethodChannelService.updateTLWorkspaces(
      encodedWorkspaces: encodedWorkspaces,
    );

    await pref.setString(_prefKey, encodedWorkspaces);
  }

  // ワークスペースを追加
  Future<void> addWorkspace(TLWorkspace newWorkspace) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final currentWorkspaces = await future;
      final updatedWorkspaces = [...currentWorkspaces, newWorkspace];
      await _saveWorkspaces(updatedWorkspaces);

      // 成功したら新しい状態を設定
      state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // ワークスペースを更新
  Future<void> updateWorkspace(TLWorkspace updatedWorkspace) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final currentWorkspaces = await future;
      final updatedWorkspaces =
          currentWorkspaces.map((workspace) {
            return workspace.id == updatedWorkspace.id
                ? updatedWorkspace
                : workspace;
          }).toList();
      await _saveWorkspaces(updatedWorkspaces);

      // 成功したら新しい状態を設定
      state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // ワークスペースを削除
  Future<void> deleteWorkspace(String workspaceId) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final currentWorkspaces = await future;
      final updatedWorkspaces =
          currentWorkspaces
              .where((workspace) => workspace.id != workspaceId)
              .toList();
      await _saveWorkspaces(updatedWorkspaces);

      // 成功したら新しい状態を設定
      state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // ワークスペース内のチェック済みToDoをすべて削除
  Future<void> deleteAllCheckedToDosInWorkspace(TLWorkspace workspace) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final currentWorkspaces = await future;

      // `workspaceIDToToDos` をコピーする
      final copiedWorkspaceIDToToDos =
          Map<String, TLToDosInTodayAndWhenever>.from(
            workspace.workspaceIDToToDos,
          );

      // ワークスペースIDに対応するTLToDosInTodayAndWheneverの中のチェック済みToDoを削除
      for (String workspaceID in copiedWorkspaceIDToToDos.keys) {
        final corrToDosInTodayAndWhenever =
            copiedWorkspaceIDToToDos[workspaceID];
        if (corrToDosInTodayAndWhenever == null) continue;
        copiedWorkspaceIDToToDos[workspaceID] = corrToDosInTodayAndWhenever
            .deleteAllCheckedToDosInAToDosList(isInToday: null);
      }

      // workspacesを更新
      final corrWorkspaceIdx = currentWorkspaces.indexWhere(
        (ws) => ws.id == workspace.id,
      );
      if (corrWorkspaceIdx < 0) {
        // 該当なし
        state = AsyncValue<List<TLWorkspace>>.data(currentWorkspaces);
        return;
      }

      final updatedWorkspaces = List<TLWorkspace>.from(currentWorkspaces);
      updatedWorkspaces[corrWorkspaceIdx] = workspace.copyWith(
        workspaceIDToToDos: copiedWorkspaceIDToToDos,
      );

      await _saveWorkspaces(updatedWorkspaces);

      // 成功したら新しい状態を設定
      state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // ワークスペースの並び替え
  Future<void> reorderWorkspace(int oldIndex, int newIndex) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final currentWorkspaces = await future;

      if (oldIndex == newIndex) {
        // 変更なし
        state = AsyncValue<List<TLWorkspace>>.data(currentWorkspaces);
        return;
      }

      final List<TLWorkspace> copiedWorkspaces = List.from(currentWorkspaces);
      final TLWorkspace movedWorkspace = copiedWorkspaces.removeAt(oldIndex);
      copiedWorkspaces.insert(newIndex, movedWorkspace);

      await _saveWorkspaces(copiedWorkspaces);

      // 成功したら新しい状態を設定
      state = AsyncValue<List<TLWorkspace>>.data(copiedWorkspaces);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // ワークスペースリスト全体を更新
  Future<void> updateWorkspaces(List<TLWorkspace> updatedWorkspaces) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      await _saveWorkspaces(updatedWorkspaces);

      // 成功したら新しい状態を設定
      state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // 今日のチェック済みToDoをすべて削除（全ワークスペース対象）
  Future<void> deleteAllCheckedToDosInTodayInWorkspaceList(
    List<TLWorkspace> workspaces,
  ) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      List<TLWorkspace> updatedWorkspaceList = [];
      for (TLWorkspace workspace in workspaces) {
        final updatedWorkspace = workspace.copyWith(
          workspaceIDToToDos: workspace.workspaceIDToToDos.map((
            workspaceID,
            tlToDosInTodayAndWhenever,
          ) {
            return MapEntry(
              workspaceID,
              tlToDosInTodayAndWhenever.deleteAllCheckedToDosInAToDosList(
                isInToday: true,
              ),
            );
          }),
        );
        updatedWorkspaceList = [...updatedWorkspaceList, updatedWorkspace];
      }

      await _saveWorkspaces(updatedWorkspaceList);

      // 成功したら新しい状態を設定
      state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaceList);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }
}
