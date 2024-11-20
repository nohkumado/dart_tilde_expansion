# dart tilde expansion

A String extension to expand the ~ in a path

since my proposition of a modification of the path project didn't find
favorable acknowledgment, this functionality being vital to most of my projects,
her a miniature standalone library just for this....

## usage
```
import 'package:tilde_expansion/tilde_expansion.dart' as tilde_expansion;

void main(List<String> arguments) {
print("Hello to convert ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser()}");
}
```

or look at the tests, if no tilde is found nothing is done, you can actually ask to canonicalize the path 
by adding:

```
import 'package:tilde_expansion/tilde_expansion.dart' as tilde_expansion;

void main(List<String> arguments) {
print("Hello to convert ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser(canonicalize: true)}");
}
```

