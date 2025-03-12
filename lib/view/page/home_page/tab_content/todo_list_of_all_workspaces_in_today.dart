import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';
import 'package:today_list/view/page/add_todo_page/add_todo_page.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/view/component/common_ui_part/tl_loading_indicator.dart';

import 'package:today_list/view/page/home_page/tab_content/build_todo_list/list_of_category_to_todos.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/num_todos_card.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

class ToDoListOfAllWorkspacesInToday extends ConsumerWidget {
  const ToDoListOfAllWorkspacesInToday({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspacesAsync = ref.watch(workspacesProvider);
    final currentWorkspaceIdAsync = ref.watch(currentWorkspaceIdProvider);

    return workspacesAsync.when(
      data: (workspaces) {
        return currentWorkspaceIdAsync.when(
          data: (currentWorkspaceId) {
            // 各ワークスペースのToDoの合計数を計算
            final int totalNumTodos = workspaces.fold(
              0,
              (sum, workspace) =>
                  sum + workspace.getNumOfToDoInWorkspace(ifInToday: true),
            );

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: totalNumTodos == 0
                  ? Center(
                      child: _NoTasksMessage(),
                    ) // タスクがない場合はメッセージのみ中央に表示
                  : ListView(
                      children: [
                        const SizedBox(height: 12),
                        for (TLWorkspace workspace in workspaces)
                          _ToDoListOfWorkspaceCard(workspace: workspace),
                        const SizedBox(height: 200),
                      ],
                    ),
            );
          },
          loading: () => const Center(child: TLLoadingIndicator()),
          error: (error, stackTrace) => Center(
            child: Text('ワークスペースIDの読み込みに失敗しました: $error'),
          ),
        );
      },
      loading: () => const Center(child: TLLoadingIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('エラーが発生しました: $error'),
      ),
    );
  }
}

// MARK: - 個別のToDoリストカード
class _ToDoListOfWorkspaceCard extends ConsumerWidget {
  final TLWorkspace workspace;

  const _ToDoListOfWorkspaceCard({required this.workspace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int numTodos = workspace.getNumOfToDoInWorkspace(ifInToday: true);

    if (numTodos == 0) return const SizedBox.shrink(); // タスクがない場合は表示しない

    return TLDoubleCard(
      borderRadius: 12,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToDoPage(workspaceID: workspace.id),
                ),
              ),
              child: NumToDosCard(
                title: workspace.name,
                numTodos: numTodos,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListOfCategoryToToDos(
              ifInToday: true,
              corrWorkspace: workspace,
            ),
          ),
        ],
      ),
    );
  }
}

// MARK: - タスクがない場合のメッセージ表示
class _NoTasksMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int currentHour = int.parse(DateFormat('HH').format(DateTime.now()));
    final bool isNightTime = currentHour >= 18 || currentHour < 4;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isNightTime ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max,
          size: 80,
          color: Colors.grey,
        ),
        const SizedBox(height: 20),
        Text(
          isNightTime ? "Good job today!" : "Let's add today's tasks!",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
