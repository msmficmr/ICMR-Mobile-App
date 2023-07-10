extension StringExtension on String {
  String get toKey {
    return replaceAll(RegExp(r"\s+"), "").toLowerCase();
  }
}
