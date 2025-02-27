import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/settings_data/todos_in_category_widget_settings.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_uuid_generator.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/view_model/settings/tcw_provider.dart';
import '../tcw_card_list/component/wks_header.dart';

class CreateWKSettingsCard extends HookConsumerWidget {
  final VoidCallback showAddWKSButtonAction;
  final ValueNotifier<bool> showBottomNavBar;

  const CreateWKSettingsCard({
    super.key,
    required this.showAddWKSButtonAction,
    required this.showBottomNavBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wksInputController = useTextEditingController();
    final ifUserHasEntered = useState(false);
    final selectedWorkspaceIndex = useState(0);
    final selectedBCIdx = useState<int?>(null);
    final selectedSCIdx = useState<int?>(null);

    final List<TLWorkspace> workspaces =
        ref.watch(tlAppStateProvider).tlWorkspaces;
    final TLWorkspace currentWorkspace =
        workspaces[selectedWorkspaceIndex.value];
    final TLToDoCategory? currentBigCategory = selectedBCIdx.value != null
        ? currentWorkspace.bigCategories[selectedBCIdx.value!]
        : null;
    final TLToDoCategory? currentSmallCategory = selectedSCIdx.value == null
        ? null
        : currentWorkspace
            .smallCategories[currentBigCategory?.id]![selectedSCIdx.value!];

    void resetState() {
      wksInputController.clear();
      ifUserHasEntered.value = false;
      selectedWorkspaceIndex.value = 0;
      selectedBCIdx.value = 0;
      selectedSCIdx.value = null;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: TLDoubleCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
                child: Focus(
                  onFocusChange: (hasFocus) =>
                      showBottomNavBar.value = !hasFocus,
                  child: TextField(
                    autofocus: true,
                    controller: wksInputController,
                    onChanged: (t) => ifUserHasEntered.value = true,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45),
                    cursorColor: TLTheme.of(context).accentColor,
                    decoration: const InputDecoration(
                      labelText: '- Title -',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                    ),
                  ),
                ),
              ),
              _DropdownWidget(
                label: "Workspace",
                value: selectedWorkspaceIndex.value,
                displayWidget: Text(
                  workspaces[selectedWorkspaceIndex.value].name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45, // 未選択時の色
                  ),
                ),
                items: workspaces
                    .asMap()
                    .entries
                    .map(
                      (entry) => DropdownMenuItem<int>(
                          value: entry.key, child: Text(entry.value.name)),
                    )
                    .toList(),
                onChanged: (newIndex) {
                  if (newIndex == null) return;
                  selectedWorkspaceIndex.value = newIndex;
                  selectedBCIdx.value = null;
                  selectedSCIdx.value = null;
                },
              ),
              _DropdownWidget(
                label: "Big Category",
                value: selectedBCIdx.value,
                displayWidget: Text(
                  selectedBCIdx.value == null
                      ? "なし"
                      : currentWorkspace
                          .bigCategories[selectedBCIdx.value!].name,
                ),
                items: [
                  const DropdownMenuItem<int?>(
                    value: -1,
                    child: Text(
                      "なし",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45, // 未選択時の色
                      ),
                    ),
                  ),
                  ...currentWorkspace.bigCategories.asMap().entries.map(
                        (entry) => DropdownMenuItem<int>(
                            value: entry.key, child: Text(entry.value.name)),
                      )
                ],
                onChanged: (newBCIdx) {
                  if (newBCIdx == -1) {
                    selectedBCIdx.value = null;
                  } else {
                    selectedBCIdx.value = newBCIdx;
                  }
                  selectedSCIdx.value = null;
                },
              ),
              if (selectedBCIdx.value != null)
                _DropdownWidget(
                  label: "Small Category",
                  value: selectedSCIdx.value,
                  displayWidget: Text(
                    selectedSCIdx.value == null
                        ? "なし"
                        : currentWorkspace
                            .smallCategories[currentWorkspace
                                .bigCategories[selectedBCIdx.value!]
                                .id]![selectedSCIdx.value!]
                            .name,
                  ),
                  items: [
                    const DropdownMenuItem<int?>(
                      value: -1,
                      child: Text(
                        "なし",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    ...currentWorkspace.smallCategories[currentWorkspace
                            .bigCategories[selectedBCIdx.value!].id]!
                        .asMap()
                        .entries
                        .map(
                          (entry) => DropdownMenuItem<int>(
                              value: entry.key, child: Text(entry.value.name)),
                        )
                  ],
                  onChanged: (newSCIdx) {
                    if (newSCIdx == -1) {
                      selectedSCIdx.value = null;
                    } else {
                      selectedSCIdx.value = newSCIdx;
                    }
                  },
                ),
              _ControlButtons(
                resetState: resetState,
                showAddWKSButtonAction: showAddWKSButtonAction,
                wksInputController: wksInputController,
                currentWorkspace: currentWorkspace,
                currentBigCategory: currentBigCategory,
                currentSmallCategory: currentSmallCategory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MARK: - Dropdown Widget
class _DropdownWidget<T> extends StatelessWidget {
  final String label;
  final T value;
  final Widget displayWidget;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _DropdownWidget({
    required this.label,
    required this.value,
    required this.displayWidget,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tlThemeConfig = TLTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TCWHeader(text: label),
          DropdownButton<T>(
            dropdownColor: tlThemeConfig.whiteBasedColor,
            isExpanded: true,
            iconEnabledColor: tlThemeConfig.accentColor,
            hint: displayWidget,
            items: items.map((item) {
              final isSelected = item.value == value;
              return DropdownMenuItem<T>(
                value: item.value,
                child: Text(
                  (item.child as Text).data ?? '',
                  style: TextStyle(
                    color:
                        isSelected ? tlThemeConfig.accentColor : Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// MARK: - Control Buttons Widget
class _ControlButtons extends ConsumerWidget {
  final VoidCallback resetState;
  final VoidCallback showAddWKSButtonAction;
  final TextEditingController wksInputController;
  final TLWorkspace currentWorkspace;
  final TLToDoCategory? currentBigCategory;
  final TLToDoCategory? currentSmallCategory;

  const _ControlButtons({
    required this.resetState,
    required this.showAddWKSButtonAction,
    required this.wksInputController,
    required this.currentWorkspace,
    required this.currentBigCategory,
    required this.currentSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllButtonStyle = ButtonStyle(
      foregroundColor: WidgetStateProperty.all(TLTheme.of(context).accentColor),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      overlayColor: WidgetStateProperty.resolveWith(
          // ignore: deprecated_member_use
          (states) => TLTheme.of(context).accentColor.withOpacity(0.1)),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              resetState();
              showAddWKSButtonAction();
            },
            style: controllButtonStyle,
            child:
                const Text("戻る", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () async {
              await TLValidation.validateNameAndExecute(
                context: context,
                name: wksInputController.text,
                validator: TLValidation.validateWKSName,
                onSuccess: () async {
                  ref
                      .read(toDosInCategoryWidgetSettingsProvider.notifier)
                      .addToDosInCategoryWidgetSettings(
                        newToDosInCategoryWidgetSettings:
                            ToDosInCategoryWidgetSettings(
                          id: TLUUIDGenerator.generate(),
                          title: wksInputController.text,
                          workspace: currentWorkspace,
                          bigCategory: currentBigCategory,
                          smallCategory: currentSmallCategory,
                        ),
                      );
                  resetState();
                  showAddWKSButtonAction();
                },
              );
            },
            style: controllButtonStyle,
            child:
                const Text("追加", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
