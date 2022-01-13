String propertyToName(String input) {
  return '${input[0].toUpperCase()}${input.substring(1)}'
      .splitMapJoin(RegExp(r'([A-Z])'), onMatch: (m) => ' ${m[0]}');
}
