import 'package:damn_nullable/damn_nullable.dart';
import 'package:test/test.dart';

void main() {
  group('DamnNullable', () {
    test('wraps a non-null value and returns it', () {
      final wrapped = DamnNullable("hello");
      expect(wrapped.or("fallback"), "hello");
    });

    test('wraps a null value intentionally', () {
      final wrapped = DamnNullable<String?>(null);
      expect(wrapped.or("fallback"), null);
    });

    test('null wrapper means no update (fallback returned)', () {
      DamnNullable<String>? wrapped = null;
      expect(wrapped.or("fallback"), "fallback");
    });

    test('keeps fallback when wrapper not passed', () {
      DamnNullable<int>? wrapped = null;
      expect(wrapped.or(999), 999);
    });

    test('handles multiple types (int)', () {
      final wrapped = DamnNullable(123);
      expect(wrapped.or(999), 123);
    });

    test('handles multiple types (custom class)', () {
      final dummy = Dummy("test");
      final wrapped = DamnNullable(dummy);
      expect(wrapped.or(Dummy("fallback")), dummy);
    });
  });
}

class Dummy {
  final String value;
  Dummy(this.value);

  @override
  bool operator ==(Object other) =>
      other is Dummy && other.value == value;

  @override
  int get hashCode => value.hashCode;
}
