import "package:cstring/cstring.dart";
import "package:test/test.dart";

main() {
  group("Char", () {
    test("isAlpha", () {
      var units = ["A", "a", "B45890inojnoacd"];

      for (String unit in units) {
        var ch = new Char(unit);
        expect(ch.isAlpha(), equals(true));
      }
    });
  });
}
