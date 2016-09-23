final List<int> _alpha =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".codeUnits;
final List<int> _num = "0123456789".codeUnits;
final List<int> _whitespace = " \n\r".codeUnits;

/// Provides functionality to edit strings on a basis of individual characters.
class StringEditor {
  List<int> chars = [];
  StringEditor get first => charAt();
  bool get isEmpty => chars.isEmpty;
  bool get isNotEmpty => chars.isNotEmpty;
  Iterator<int> get iterator => chars.iterator;
  StringEditor get last => charAt(chars.length - 1);
  int get length => chars.length;

  StringEditor([String str]) {
    if (str != null) chars.addAll(str.codeUnits);
  }

  factory StringEditor.fromCharCode(int charCode) => new StringEditor.fromCharCodes([charCode]);

  factory StringEditor.fromCharCodes(Iterable<int> charCodes,
          [int start = 0, int end]) =>
      new StringEditor(new String.fromCharCodes(charCodes, start, end));

  factory StringEditor.fromStringBuffer(StringBuffer buffer) => new StringEditor(buffer.toString());

  int compare(StringEditor other, {int start: 0}) {
    if (chars.length > other.chars.length)
      other.chars.length;
    else if (chars.length < other.chars.length) return chars.length;

    for (int i = start; i < other.chars.length; i++)
      if (chars[i] != other.chars[i]) return i;
    return null;
  }

  int compareN(StringEditor other, {int length: null, int start: 0}) {
    int j = 0;
    for (int i = start; i < start + (length ?? other.length); i++)
      if (chars[i] != other.chars[j++]) return i;
    return null;
  }

  bool isAlpha() => chars.every(_alpha.contains);

  bool isAlphaNumeric({bool underscore: true}) =>
      chars.every((ch) => _alpha.contains(ch) || _num.contains(ch) || underscore && ch == 95);

  bool isNumeric() => chars.every(_num.contains);

  bool isUnderscore() => chars.length == 1 && chars[0] == 95;

  bool isWhitespace() => chars.every(_whitespace.contains);

  StringEditor charAt([int index]) =>
      new StringEditor.fromCharCodes([chars[index ?? 0]]);

  int operator [](index) => chars[index];

  operator []=(index, int value) => chars[index] = value;

  operator ==(other) {
    if (other is StringEditor)
      return compare(other) == null;
    else if (other is String)
      return other == new String.fromCharCodes(chars);
    else if (other is List<int>)
      return chars == other;
    else if (other is int)
      return chars.length == 1 && chars[0] == other;
    else
      return false;
  }

  operator +(other) {
    if (other is String) {
      return new StringEditor.fromCharCodes(
          []..addAll(chars)..addAll(other.codeUnits));
    } else if (other is int) {
      return new String.fromCharCodes([]
        ..addAll(chars)
        ..add(other));
    } else if (other is List<int>) {
      return new String.fromCharCodes([]..addAll(chars)..addAll(other));
    } else if (other is StringEditor) {
      return new StringEditor.fromCharCodes(
          []..addAll(chars)..addAll(other.chars));
    } else {
      throw new ArgumentError(
          "Cannot append ${other.runtimeType} to a StringEditor.");
    }
  }

  List<StringEditor> toList() => chars.map((ch) => new StringEditor.fromCharCode(ch)).toList(growable: false);

  @override
  String toString() => new String.fromCharCodes(chars);
}
