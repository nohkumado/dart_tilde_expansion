import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:tilde_expansion/tilde_expansion.dart';
import 'package:test/test.dart';

void main() {
  test('expandUser should expand tilde to home directory', () {
    // Mock the environment variable
    final userName = Platform.environment['USER'] ?? "user";

    List<List<String>> candidates = [
      [
        'path/to/file.txt',
        'path/to/file.txt',
        '${Directory.current.path}${path.separator}path/to/file.txt'
      ], //easy path
      [
        '/path/to/file.txt',
        '/path/to/file.txt',
        '/path/to/file.txt'
      ], //absolute path
      [
        '~/Documents/test.txt',
        '/home/$userName/Documents/test.txt',
        '/home/$userName/Documents/test.txt'
      ], //absolute path
      [
        '~/Documents/../Downloads/test.txt',
        '/home/$userName/Documents/../Downloads/test.txt',
        '/home/$userName/Downloads/test.txt'
      ], //absolute path
      [
        '~toto/Documents/test.txt',
        '/home/toto/Documents/test.txt'
      ], //absolute path
    ];

    for (List<String> candidate in candidates) {
      expect(candidate[0].expandUser(canonicalize: false), candidate[1],
          reason: '${candidate[0]} should be expanded to ${candidate[1]}');
      if (candidate.length > 2) {
        expect(candidate[0].expandUser(canonicalize: true), candidate[2],
            reason:
                '${candidate[0]} should be expanded to canonical ${candidate[1]}');
      }
    }
  });
}
