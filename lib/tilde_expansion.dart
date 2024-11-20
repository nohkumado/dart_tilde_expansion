import 'dart:io';
import 'package:path/path.dart' as path;

/// Helper function to expand the '~' character to the full home directory path
///
extension PathExtension on String {
  String expandUser({bool canonicalize = false}) {
    String result = this;
    //RegExp regex = RegExp(r'^~(\w+)?${path.separator|^~${path.separator');
    RegExp regex = RegExp(r'^~(\w+)?' + (path.separator));
    final match = regex.matchAsPrefix(this);
    if (match != null) {
      //remove the tilde
      result = result.substring(match.end - 1);
      // Retrieve the username from the match
      // Note: This assumes that the username is a single word, separated by a single character
      // If the username contains multiple words, this may not work correctly. To handle this, you would need to modify the regex to match multiple words separated by spaces or underscores.
      final username = match.group(1);
      final homeDir = Platform.environment['HOME'];
      // Retrieve the home directory from environment variables
      if (homeDir == null) {
        throw Exception('Unable to determine user home directory');
      }
      if (username == null) {
        result = homeDir + result;
      } else {
        result = path.dirname(homeDir) + path.separator + username + result;
      }
    }
    // Return the canonical file path
    return (canonicalize) ? path.canonicalize(result) : result;
  }
}
