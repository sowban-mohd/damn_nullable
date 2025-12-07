import 'package:damn_nullable/damn_nullable.dart';

class User {
  final String? name;
  final int? age;

  User({this.name, this.age});

  User copyWith({
    // If the caller wants to update a field which can be nullable, they wrap the new value in DamnNullable.
    // If they don't pass anything, the parameter stays null → which means "no update".
    DamnNullable<String>? name,
    DamnNullable<int>? age,
  }) {
    return User(
      // `.or(this.name)` means:
      // - If 'name' was passed → use wrapped value (even if it's null)
      // - If 'name' was not passed → use existing value (this.name)
      name: name.or(this.name),
      age: age.or(this.age),
    );
  }
}

void main() {
  final user = User(name: "Alice", age: 20);

  // Case 1: Update the field
  // DamnNullable("Bob") means: update name to "Bob".
  final updated1 = user.copyWith(name: DamnNullable("Bob"));
  print(updated1.name); // Bob

  // Case 2: Explicitly set the field to null
  // DamnNullable(null) means: intentionally replace value with null.
  final updated2 = user.copyWith(name: DamnNullable(null));
  print(updated2.name); // null

  // Case 3: Do not update the field
  // No wrapper passed → parameter remains null → .or() returns existing value.
  final updated3 = user.copyWith();
  print(updated3.name); // Alice
}
