/// Extension methods for String class.
extension AlbiruniFormat on String {
  /// Transfrom given string to albiruni parseable format.
  ///
  /// Example: `ppbm1331` will return `PPBM 1331`
  String toAlbiruniFormat() {
    var x = toUpperCase().replaceAll(" ", "");

    // Processing logic is the same with the original site that were written in JS
    var spacepos = x.indexOf(RegExp(r'[0-9]'));

    /// `CCDN1352E` will be as it is,
    ///  meanwhile `TQB1001M` will be seperated.
    /// (It's their convention btw)
    if (x.length < 9) {
      x = x.substring(0, (spacepos == -1 ? x.length : spacepos)) +
          (spacepos == -1 ? "" : " ") +
          (spacepos == -1 ? "" : x.substring(spacepos));
    }
    return x;
  }
}
