# dart_cstring
Native bindings for a few `<cstring>` functions, also includes char support.

# Installation

```yaml
dependencies:
  cstring: ^1.0.0-dev
```

# Usage

### Strings

```dart
import "package:cstring/cstring.dart";

main() {
  var greeting = new Cstring("Hello, world!");

  // strncmp
  bool saysHi = greeting.compareN(new Cstring("Hello"), 5) == 0;

  // strcmp
  print(saysHi = "foo");

  // Also static
  print(Cstring.strncmp("A", "B", 1));
}
```

### Chars

```dart
import "package:cstring/cstring.dart";

class SomeLexer {
  List<Token> tokens = [];

  void scan(String text) {
    // Automatically takes first char of string
    Char ch = new Char(text);

    // isdigit, isalnum, isalpha
    if (ch.isDigit())
      tokens.add(new Token("NUMBER", ch.value));
  }
}
```
