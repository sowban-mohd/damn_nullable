# damn_nullable

A tiny and clean Dart utility that solves a classic problem:

### In a normal `copyWith`, you cannot distinguish between:

* not providing a value  **no update**
* providing `null`  **update field to null**

This prevents models from correctly handling nullable fields.

---

# damn_nullable solves this with a simple wrapper:

```dart
DamnNullable("John")   // update field to "John"
DamnNullable(null)      // update field to null
// omit parameter        // no update
```

This gives you full control over nullable updates.

---

# Usage

Import the package:

```dart
import 'package:damn_nullable/damn_nullable.dart';
```

---

# Example model

```dart
class User {
  final String? name;
  final int? age;

  User({this.name, this.age});

  User copyWith({
    DamnNullable<String>? name,
    DamnNullable<int>? age,
  }) {
    return User(
      name: name?.or(this.name) ?? this.name,
      age: age?.or(this.age) ?? this.age,
    );
  }
}
```

---

# Updating fields

### Update to a new value

```dart
user.copyWith(name: DamnNullable("John"));
```

### Explicitly set field to null

```dart
user.copyWith(name: DamnNullable(null));
```

### Do not update the field

```dart
user.copyWith();
```

---

# How `.or()` works

Inside `copyWith`, this expression:

```dart
name?.or(this.name)
```

means:

* If a `DamnNullable` was **passed**, return the wrapped value
* If the parameter was **not passed**, return the fallback (existing value)

So:

| Input                  | Behavior             |
| ---------------------- | -------------------- |
| `DamnNullable("John")` | updates to `"John"`  |
| `DamnNullable(null)`   | updates to `null`    |
| parameter omitted      | keeps existing value |

---

# When should you use damn_nullable?

* You have models with **nullable fields**
* You want clean `copyWith` behavior
* You want to intentionally set fields to **null**
* You want a tiny, readable solution

---

# Why "damn_nullable"?

Because sometimes you really need to say:

> "Damn it, I *meant* to set this field to null!"

---

# Contributing

Issues and PRs are welcome on GitHub.

---

# License

MIT License.
