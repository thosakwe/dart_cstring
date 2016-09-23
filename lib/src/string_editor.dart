final List<int> _alpha =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".codeUnits;
final List<int> _num = "0123456789".codeUnits;
final List<int> _whitespace = " \n\r\t".codeUnits;

/// Provides functionality to edit strings on a basis of individual characters.
class StringEditor {
  /// A collection of all characters in this string.
  List<int> chars = [];

  /// A [StringEditor] instance containing the first character in this string.
  StringEditor get first => charAt();

  /// Returns `true` if there are no characters in this string.
  bool get isEmpty => chars.isEmpty;

  /// Returns `true` if there is at least one character in this string.
  bool get isNotEmpty => chars.isNotEmpty;

  /// Allows iteration through this string.
  Iterator<StringEditor> get iterator => toList().iterator;

  /// A [StringEditor] instance containing the first character in this string.
  StringEditor get last => charAt(chars.length - 1);

  /// Returns the number of characters in this string.
  int get length => chars.length;

  /// Default constructor. Pass a string to copy into this editor.
  StringEditor([String str]) {
    if (str != null) chars.addAll(str.codeUnits);
  }

  /// Creates an instance from a single character.
  factory StringEditor.fromCharCode(int charCode) => new StringEditor.fromCharCodes([charCode]);

  /// Creates an instance from a collection of characters.
  ///
  /// `start` and `end` are the same as `String.fromCharCodes`.
  factory StringEditor.fromCharCodes(Iterable<int> charCodes,
          [int start = 0, int end]) =>
      new StringEditor(new String.fromCharCodes(charCodes, start, end));

  /// Creates an instance from a string stored in a buffer.
  factory StringEditor.fromStringBuffer(StringBuffer buffer) => new StringEditor(buffer.toString());

  /// Finds the first index at which two strings differ.
  ///
  /// Returns `null` if they are equal.
  int compare(StringEditor other, {int start: 0}) {
    if (chars.length > other.chars.length)
      other.chars.length;
    else if (chars.length < other.chars.length) return chars.length;

    for (int i = start; i < other.chars.length; i++)
      if (chars[i] != other.chars[i]) return i;
    return null;
  }

  /// Finds the first index at which two string differ, within a given range of indices.
  ///
  /// Returns `null` if the two strings from equal from `start` to the given index.
  /// If no `length` is provided, then this function will search until the end of `other`.
  int compareN(StringEditor other, {int length: null, int start: 0}) {
    int j = 0;
    for (int i = start; i < start + (length ?? other.length); i++)
      if (chars[i] != other.chars[j++]) return i;
    return null;
  }

  /// Returns `true` if every character in this string is alphabetical.
  bool isAlpha() => chars.every(_alpha.contains);

  /// Returns `true` if every character in this string is alphabetical or numeric.
  ///
  /// If `underscore` is true, then underscores will also be accepted.
  bool isAlphaNumeric({bool underscore: true}) =>
      chars.every((ch) => _alpha.contains(ch) || _num.contains(ch) || underscore && ch == 95);

  /// Returns `true` if every character in this string is numeric.
  bool isNumeric() => chars.every(_num.contains);

  /// Returns `true` if this string has a length of 1 and is an underscore.
  bool isUnderscore() => chars.length == 1 && chars[0] == 95;

  /// Returns `true` if this string only contains newlines, spaces, carriage returns and tabs.
  bool isWhitespace() => chars.every(_whitespace.contains);

  /// Returns a reference to the character at the given index.
  ///
  /// `index` defaults to 0.
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
      return new StringEditor.fromCharCodes([]
        ..addAll(chars)
        ..add(other));
    } else if (other is List<int>) {
      return new StringEditor.fromCharCodes([]..addAll(chars)..addAll(other));
    } else if (other is StringEditor) {
      return new StringEditor.fromCharCodes(
          []..addAll(chars)..addAll(other.chars));
    } else {
      throw new ArgumentError(
          "Cannot append ${other.runtimeType} to a StringEditor.");
    }
  }

  /// Returns a set of [StringEditor] instances containing every character in this string.
  List<StringEditor> toList() => chars.map((ch) => new StringEditor.fromCharCode(ch)).toList(growable: false);

  @override
  String toString() => new String.fromCharCodes(chars);
}
