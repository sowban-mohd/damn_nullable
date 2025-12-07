library;

/// DamnNullable
/// A tiny utility to explicitly control nullable updates in copyWith methods.
///
/// Why this exists:
/// Dart cannot normally distinguish between:
///   - not providing a value (no update)
///   - providing null intentionally (set value to null)
///
/// With DamnNullable, you can do:
///   DamnNullable("John")   → update to "John"
///   DamnNullable(null)     → update field to null
///   omit parameter         → no update
///
class DamnNullable<T> {
  final T? value;
  final bool isPresent;

  /// Creates an intentional update wrapper.
  /// Even if [value] is null, this means: "update this field to null".
  const DamnNullable(this.value) : isPresent = true;
}

/// Returns [value] if present, otherwise returns [fallback].
extension DamnNullableX<T> on DamnNullable<T>? {
  T? or(T? fallback) {
    if (this == null) return fallback;
    return this!.value;
  }
}
