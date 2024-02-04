class StringFormatter{
  static int formatCurrencyNumber(String value) {
    String cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
    return int.parse(cleanedValue);
  }
}