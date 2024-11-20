import 'package:tilde_expansion/tilde_expansion.dart' as tilde_expansion;

void main(List<String> arguments) {
  print(
      "Hello to convert ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser()}");
}
