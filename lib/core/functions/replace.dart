replace({required var text, required Map replace}) {
  List keys = replace.keys.toList();
  List vals = replace.values.toList();
  for (int i = 0; i < keys.length; i++) {
    text = text.toString().replaceAll('${keys[i]}', '${vals[i]}');
  }
  return text.toString();
}
