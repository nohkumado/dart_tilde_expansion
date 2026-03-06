import 'package:tilde_expansion/tilde_expansion.dart' as tilde_expansion;

void main(List<String> arguments) {
  print( "Hello to convert ~/Documents/test.txt to   ${'~/Documents/test.txt'.expandUser()}"); 
  print("Hello to convert ~docker/Documents/test.txt to  ${'~docker/Documents/test.txt'.expandUser()}");
  print("Hello to convert ~docker/Documents/test.txt to ${'~docker/Documents/test.txt'.expandUser(canonicalize:true)}");
  print("Hello to convert ~toto/Documents/test.txt to   ${'~toto/Documents/test.txt'.expandUser()}");
  }
