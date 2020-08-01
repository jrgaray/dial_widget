// Function that builds a list of Strings from start and end numbers.
List<String> buildOptions(int start, int end) {
  List<String> options = [];
  for (int i = start; i < end + 1; i++) {
    String str = i < 10 ? '0${i.toString()}' : i.toString();
    options.add(str);
  }
  return options;
}
