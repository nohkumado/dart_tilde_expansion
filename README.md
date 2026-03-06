# Tilde Expansion for Dart

[![Pub Version](https://img.shields.io/pub/v/tilde_expansion)](https://pub.dev/packages/tilde_expansion)
[![CI Status](https://github.com/nohkumado/tilde_expansion/actions/workflows/test.yml/badge.svg)](https://github.com/nohkumado/tilde_expansion/actions)
[![License: GPL](https://img.shields.io/badge/license-GPL-purple.svg)](https://opensource.org/license/gpl-3-0-only)

**Expand `~` and `~/` in paths like a shell – cross-platform, lightweight, and zero-dependency.**

Tired of manually replacing `~` with the user’s home directory in your Dart/Flutter apps?
`tilde_expansion` does it for you, **just like your shell**.

## Key Features:

- Simple Usage: Easily expand tilde paths with a single method call.
- Works with ~/ and ~user paths, note that no verification of
                  that user existence is done
- Cross-Platform Compatibility: Works seamlessly across different operating systems.
- Flexible Configuration: Customize expansion behavior with optional parameters.
- Efficient Implementation: Optimized for performance and clarity.

## Why?

- **No built-in solution in Dart**: The official `path` package [ignores Unix user needs](https://github.com/dart-lang/core/issues/538) (yes, really).
- **Cross-platform**: Works everywhere, from CLI tools to Flutter apps.
- **Tiny and fast**: Zero dependencies, minimal overhead.

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  tilde_expansion: ^latest_version
```

Or install via CLI:

```bash
dart pub add tilde_expansion
```

## Usage

### Basic Expansion

```dart
import 'package:tilde_expansion/tilde_expansion.dart';

void main() {
print("Expand path from ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser()}");
}
```

### Custom User Paths or to canonicalize the path

```dart
import 'package:tilde_expansion/tilde_expansion.dart';
void main() {
print("Hello to convert ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser(canonicalize: true)}");
print("Hello to convert ~toto/Documents/test.txt to   ${'~toto/Documents/test.txt'.expandUser(canonicalize: true)}");
}
```

## Features

- ✅ Shell-like behavior: Mimics bash/zsh expansion rules.
- ✅ No dependencies: Pure Dart, < 100 lines of code.
- ✅ Error-resistant: Gracefully handles invalid paths.


## Who Needs This?
- CLI tools: Stop hardcoding /home/user/ – use ~ like in scripts!
- Flutter apps: Save user paths (e.g., ~/Downloads) without platform-specific code.
- Cross-platform projects: Write once, expand everywhere.

## Contributing

Found a bug? Want to add a feature?
PRs are welcome! Check out the GitHub repo.

## Running Tests

```bash
dart test ## to run the validation tests
dart run ## to run a minimal example
```


# Additional Notes:

- Error Handling: The package handles cases where the HOME environment variable is not set.
- Performance: The implementation is optimized for efficiency, especially when dealing with large numbers of path expansions.

# License

released under the [GPLv3](LICENCE.md)
