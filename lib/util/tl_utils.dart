import 'package:uuid/uuid.dart';

class TLUtils {
  static const _uuid = Uuid(); // UUIDインスタンスを生成

  /// UUID v4 を生成するメソッド
  static String generateUniqueId() {
    return _uuid.v4(); // UUID v4 を返す
  }
}
