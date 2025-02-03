import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/tl_step.freezed.dart';
part '../generate/tl_step.g.dart';

// $ dart run build_runner build

@freezed
class TLStep with _$TLStep {
  const factory TLStep({
    required String id,
    required String title,
    @Default(false) bool isChecked,
  }) = _TLStep;

  factory TLStep.fromJson(Map<String, dynamic> json) => _$TLStepFromJson(json);
}
