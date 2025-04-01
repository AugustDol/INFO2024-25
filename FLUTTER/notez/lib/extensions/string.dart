extension IntConversion on String {
  int toInt() {
    if (isEmpty) {
      return 0;
    }

    return int.parse(this);
  }
}