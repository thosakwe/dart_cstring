/// Exposes wrapper classes over &lt;cstring> functions.
library cstring;

import "dart-ext:cstring";

bool _compareChar(String ch1, ch2) native "_dartCompareChar";
bool _isAlnum(String ch) native "_dartIsAlnum";
bool _isAlpha(String ch) native "_dartIsAlpha";
bool _isDigit(String ch) native "_dartIsDigit";
int _dartStrcmp(String str1, String str2) native "_dartStrcmp";
int _dartStrncmp(String str1, String str2, int len) native "_dartStrncmp";

/// Represents a constant char array.
class Cstring {
  /// A String representation of this char array.
  String value;

  /// Returns the value of running `strlen` on this char array.
  int get length => value.length;

  Cstring(this.value);

  /// Compares one char array to another, and reports any discrepancy.
  static int strcmp(String str1, String str2) => _dartStrcmp(str1, str2);

  /// Compares one char array to another up until a certain number of chars has been processed, and reports any discrepancy.
  static int strncmp(String str1, String str2, int len) => _dartStrncmp(str1, str2, len);

  /// Returns the result of running `strcmp` on this string and another.
  int compare(Cstring other) => _dartStrcmp(value, other.value);

  /// Returns the result of running `strncmp` on this string and another.
  int compareN(Cstring other, int len) => _dartStrncmp(value, other.value, len);

  @override
  operator ==(other) {
    if (other is String)
      return compare(new Cstring(other)) == 0;
    else if (other is Cstring)
      return compare(other) == 0;
    else return other != null && hashCode == other.hashCode;
  }
}

/// Represents a single character.
class Char {
  String _text;

  /// A text representation of this character.
  String get value => _text;

  Char(String text) {
    this._text = text.substring(0, 1);
  }

  bool isAlnum() => _isAlnum(_text);
  bool isAlpha() => _isAlpha(_text);
  bool isDigit() => _isDigit(_text);

  @override
  operator ==(other) {
    if (other is Char)
      return _compareChar(_text, other._text);
    else if (other is String) {
      return other.length == 1 && _compareChar(_text, other);
    }

    else return other != null && hashCode == other.hashCode;
  }
}
