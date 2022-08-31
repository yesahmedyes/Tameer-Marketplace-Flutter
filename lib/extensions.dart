extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DoubleExtension on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
