String capitalize(String input) {
  return '${input[0].toUpperCase()}${input.substring(1)}';
}

String propertyToName(String input) {
  return capitalize(input)
      .splitMapJoin(RegExp(r'([A-Z])'), onMatch: (m) => ' ${m[0]}');
}
