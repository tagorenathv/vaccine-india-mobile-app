class NumericValidatorUtil {
  static bool isNumeric(String? result) {
    if (result == null) {
      return false;
    }
    return int.tryParse(result) != null;
  }
}
