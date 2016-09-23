import "package:string_editor/string_editor.dart";

main() {
  var editor = new StringEditor("Hello, world!");

  // Find all alphanumeric characters...
  for (var ch in editor.toList().where((ch) => ch.isAlphaNumeric(underscore: false))) {
    print("Found a letter or number: $ch");
  }
}