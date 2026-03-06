# Tilde Expansion for Dart

A simple, efficient, and reusable Dart package to expand tilde (~) paths to the user's home directory.


since my proposition of a modification of the path project didn't find
favorable acknowledgment, this functionality being vital to most of my projects,
here a miniature standalone library just for this....

## Key Features:

    Simple Usage: Easily expand tilde paths with a single method call.
                  Works with ~/ and ~user paths, note that no verification of
                  that user existence is done
    Cross-Platform Compatibility: Works seamlessly across different operating systems.
    Flexible Configuration: Customize expansion behavior with optional parameters.
    Efficient Implementation: Optimized for performance and clarity.

## Installation:
```bash
dart pub add tilde_expansion
```

## Usage
```
import 'package:tilde_expansion/tilde_expansion.dart';

print("Expand path from ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser()}");
```

or look at the tests, if no tilde is found nothing is done, you can actually ask to canonicalize the path 
by adding:

```
import 'package:tilde_expansion/tilde_expansion.dart';

print("Hello to convert ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser(canonicalize: true)}");
print("Hello to convert ~toto/Documents/test.txt to   ${'~toto/Documents/test.txt'.expandUser(canonicalize: true)}");
```

# Additional Notes:

    Error Handling: The package handles cases where the HOME environment variable is not set.
    Performance: The implementation is optimized for efficiency, especially when dealing with large numbers of path expansions.

By using this package, you can simplify your code and make it more portable across different environments.
