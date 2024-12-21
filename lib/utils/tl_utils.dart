class TLUtils {
  static String generateUniqueId() {
    final DateTime now = DateTime.now();
    return '${now.microsecondsSinceEpoch}';
  }
}
