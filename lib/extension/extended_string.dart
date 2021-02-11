extension ExtendedString on String {
  String safetyExtrapolation() {
    if (this == null) return "";
    return this;
  }

  bool isSafety() {
    return this != null && this.isNotEmpty;
  }

  bool isNotSafety() {
    return this == null || this.isEmpty;
  }
}
