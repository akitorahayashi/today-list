import 'package:uuid/uuid.dart';

class TLUUIDGenerator {
  static const _uuid = Uuid();

  /// UUID v4 を生成するメソッド
  static String generate() {
    return _uuid.v4(); // UUID v4 を返す
  }
}
