import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/todos_in_category_widget_settings.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/view_model/settings/wks_provider.dart';
import '../component/wks_header.dart';

class CreateWKSettingsCard extends ConsumerStatefulWidget {
  final VoidCallback showAddWKSButtonAction;
  const CreateWKSettingsCard({super.key, required this.showAddWKSButtonAction});

  @override
  CreateWKSettingsCardState createState() => CreateWKSettingsCardState();
}

class CreateWKSettingsCardState extends ConsumerState<CreateWKSettingsCard> {
  final TextEditingController _wksInputController = TextEditingController();
  bool _ifUserHasEntered = false;
  int _selectedWorkspaceIndex = 0;
  int _selectedBCIdx = 0;
  int? _selectedSCIdx;

  TLWorkspace get _currentWorkspace =>
      ref.watch(tlAppStateProvider).tlWorkspaces[_selectedWorkspaceIndex];

  String get _currentBigCategoryID =>
      _currentWorkspace.bigCategories[_selectedBCIdx].id;

  @override
  void dispose() {
    _wksInputController.dispose();
    super.dispose();
  }

  // MARK: - Reset State
  void _resetState() {
    setState(() {
      _wksInputController.clear();
      _ifUserHasEntered = false;
      _selectedWorkspaceIndex = 0;
      _selectedBCIdx = 0;
      _selectedSCIdx = null;
    });
  }

  // MARK: - Handle Workspace Change
  void _onWorkspaceChanged(int? newIndex) {
    if (newIndex == null) return;
    TLVibrationService.vibrate();
    setState(() {
      if (!_ifUserHasEntered) {
        _wksInputController.text =
            ref.read(tlAppStateProvider).tlWorkspaces[newIndex].name;
      }
      _selectedWorkspaceIndex = newIndex;
      _selectedBCIdx = 0;
      _selectedSCIdx = null;
    });
  }

  // MARK: - Handle Big Category Change
  void _onBigCategoryChanged(int? newBCIdx) {
    if (newBCIdx == null) return;
    TLVibrationService.vibrate();
    setState(() {
      if (!_ifUserHasEntered) {
        _wksInputController.text =
            _currentWorkspace.bigCategories[newBCIdx].title;
      }
      _selectedBCIdx = newBCIdx;
      _selectedSCIdx = null;
    });
  }

  // MARK: - Handle Small Category Change
  void _onSmallCategoryChanged(int? newSCIdx) {
    if (newSCIdx == null) return;
    TLVibrationService.vibrate();
    setState(() {
      if (!_ifUserHasEntered) {
        _wksInputController.text = _currentWorkspace
            .smallCategories[_currentBigCategoryID]![newSCIdx].title;
      }
      _selectedSCIdx = newSCIdx;
    });
  }

  // MARK: - Build Dropdown
  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WKSHeader(text: label),
          DropdownButton<T>(
            isExpanded: true,
            iconEnabledColor: TLTheme.of(context).accentColor,
            value: value,
            items: items,
            style: const TextStyle(
                color: Colors.black45, fontWeight: FontWeight.bold),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // MARK: - Build Control Buttons
  Widget _buildControlButtons(WidgetKitSettingNotifier wksNotifier) {
    final controllButtonStyle = ButtonStyle(
      foregroundColor: WidgetStateProperty.all(TLTheme.of(context).accentColor),
      shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      overlayColor: WidgetStateProperty.resolveWith(
          (states) => TLTheme.of(context).accentColor.withOpacity(0.1)),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              _resetState();
              widget.showAddWKSButtonAction();
            },
            style: controllButtonStyle,
            child:
                const Text("戻る", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () async {
              TLVibrationService.vibrate();
              await TLValidation.validateNameAndExecute(
                context: context,
                name: _wksInputController.text,
                validator: TLValidation.validateWKSName,
                onSuccess: () async {
                  wksNotifier.addWidgetKitSettings(
                    newWidgetKitSettings: ToDosInCategoryWidgetSettings(
                      id: UniqueKey().toString(),
                      title: _wksInputController.text,
                      workspaceIdx: _selectedWorkspaceIndex,
                      bcIdx: _selectedBCIdx,
                      scIdx: _selectedSCIdx,
                    ),
                  );
                  _resetState();
                  widget.showAddWKSButtonAction();
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

  @override
  Widget build(BuildContext context) {
    final wksNotifier = ref.read(widgetKitSettingsProvider.notifier);
    final deviceWidth = MediaQuery.of(context).size.width;
    final workspaces = ref.watch(tlAppStateProvider).tlWorkspaces;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: TLDoubleCard(
        child: SizedBox(
          width: deviceWidth - 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Input
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    autofocus: true,
                    controller: _wksInputController,
                    onChanged: (t) => _ifUserHasEntered = true,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black45),
                    cursorColor: TLTheme.of(context).accentColor,
                    decoration: const InputDecoration(labelText: '- Title -'),
                  ),
                ),
                // Workspace Selection
                _buildDropdown(
                  label: "Workspace",
                  value: _selectedWorkspaceIndex,
                  items: workspaces
                      .asMap()
                      .entries
                      .map((entry) => DropdownMenuItem<int>(
                          value: entry.key, child: Text(entry.value.name)))
                      .toList(),
                  onChanged: _onWorkspaceChanged,
                ),
                // Big Category Selection
                _buildDropdown(
                  label: "Big Category",
                  value: _selectedBCIdx,
                  items: _currentWorkspace.bigCategories
                      .asMap()
                      .entries
                      .map((entry) => DropdownMenuItem<int>(
                          value: entry.key, child: Text(entry.value.title)))
                      .toList(),
                  onChanged: _onBigCategoryChanged,
                ),
                _buildControlButtons(wksNotifier),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
