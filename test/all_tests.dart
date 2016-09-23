import "package:string_editor/chars.dart" as Chars;
import "package:string_editor/string_editor.dart";
import "package:test/test.dart";

main() {
  test("compare", () async {
    var editor = new StringEditor("A");
    expect(editor == Chars.A, equals(true));
    print("'$editor' == 'A'");
  });

  test("concat", () async {
    String hello = "Hello, ", world = "world!", helloWorld = hello + world;
    var editorAndEditor = new StringEditor(hello) + new StringEditor(world);
    var editorAndString = new StringEditor(hello) + world;
    var editorAndInt = new StringEditor(hello + "world") + "!".codeUnitAt(0);
    var editorAndList = new StringEditor(hello) + world.codeUnits;

    expect(editorAndEditor.toString(), equals(helloWorld));
    expect(editorAndString.toString(), equals(helloWorld));
    expect(editorAndInt.toString(), equals(helloWorld));
    expect(editorAndList.toString(), equals(helloWorld));
    print(helloWorld);

    expect(() {
      editorAndEditor += 24.5;
    }, throws);
  });

  test("compareN", () {
    var editor = new StringEditor("Star Wars");

    expect(editor.compareN(new StringEditor("Star")), equals(null));
    expect(editor.compareN(new StringEditor("tar"), start: 1, length: 3), equals(null));
    expect(editor.compareN(new StringEditor("Darth Vader")), equals(0));
    expect(editor.compareN(new StringEditor("Stellar!"), start: 1), equals(1));
  });

  test("isAlpha, etc.", () {
    var editor = new StringEditor("password123_");
    expect(editor.isAlpha(), equals(false));
    expect(editor.isAlphaNumeric(), equals(true));
    expect(editor.isAlphaNumeric(underscore: false), equals(false));
    expect(editor.isNumeric(), equals(false));
    expect(editor.isUnderscore(), equals(false));
    expect(editor.isWhitespace(), equals(false));

    var w = editor.charAt(4);
    expect(w == "w", equals(true));
    expect(w.isAlpha(), equals(true));
    expect(w.isAlphaNumeric(), equals(true));
    expect(w.isNumeric(), equals(false));
    expect(w.isUnderscore(), equals(false));
    expect(w.isWhitespace(), equals(false));
  });

  test("manual trim", () {
    var sourceCode = '''
    int main() async => 0;
    ''';
    var editor = new StringEditor(sourceCode);

    while(editor.isNotEmpty && editor.first.isWhitespace())
      editor.chars.removeAt(0);
    while(editor.isNotEmpty && editor.last.isWhitespace())
      editor.chars.removeLast();

    print("Trimmed: '$editor'");
    expect(editor.toString(), equals(sourceCode.trim()));
  });

  test("iterator", () {});
}
