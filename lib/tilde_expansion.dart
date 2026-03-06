import 'dart:io';
import 'package:path/path.dart' as path;

/// An extension on [String] to expand the tilde (`~`) character in paths.
///
/// This extension provides a method to replace the `~` or `~username` prefix
/// in a path with the corresponding user's home directory, mimicking shell behavior.
///
/// **Supported patterns:**
/// - `~` → Expands to the current user's home directory.
/// - `~username` → Expands to the specified user's home directory (Unix-like systems only).
///
/// **Example:**
/// ```dart
/// print('~/Documents'.expandUser());
/// // On Linux/macOS: "/home/current_user/Documents"
/// // On Windows: "C:\Users\current_user\Documents"
///
/// print('~bob/Documents'.expandUser());
/// // On Unix-like systems: "/home/bob/Documents" (if user "bob" exists)
/// // Throws [Exception] if user "bob" does not exist.
/// ```
///
/// **Parameters:**
/// - [canonicalize]: If `true`, resolves symlinks and normalizes the path (e.g., `..`).
///   Defaults to `false` for performance.
///
/// **Throws:**
/// - [Exception] if the home directory cannot be determined (e.g., `HOME` environment variable is missing).
/// - [Exception] if the specified user does not exist (Unix-like systems only).
/// - [UnsupportedError] if `~username` is used on Windows.
///
/// **Platform Notes:**
/// - On **Windows**, only `~` (current user) is supported. `~username` will throw an error.
/// - On **Unix-like systems**, both `~` and `~username` are supported.
///
/// **See also:**
/// - [path.canonicalize] for path normalization.
/// - [Platform.environment] for accessing environment variables.
extension PathExtension on String {
  /// Expands the tilde (`~`) in the path to the corresponding user's home directory.
  ///
  /// If [canonicalize] is `true`, the returned path will be normalized (symlinks resolved, `.` and `..` processed).
  ///
  /// **Example:**
  /// ```dart
  /// print('~/Downloads'.expandUser());
  /// // Output: "/home/user/Downloads" (Linux/macOS) or "C:\Users\user\Downloads" (Windows)
  /// ```
  String expandUser({bool canonicalize = false}) {
    String result = this;
    //RegExp regex = RegExp(r'^~(\w+)?${path.separator|^~${path.separator');
    //RegExp regex = RegExp(r'^~(\w+)?' + (path.separator == '/' ? r'/?' : r'\\?'));
    final regex =
        RegExp(r'^~(\w*)' + RegExp.escape(path.separator) + '?(.*?)?\$');
    final match = regex.matchAsPrefix(this);
    if (match != null) {
      //remove the tilde
      result = result.substring(match.end - 1);
      // Retrieve the username from the match
      // Note: This assumes that the username is a single word, separated by a single character
      // If the username contains multiple words, this may not work correctly. To handle this, you would need to modify the regex to match multiple words separated by spaces or underscores.
      final username = match.group(1) ?? '';
      final remainingPath = (match.groupCount > 1) ? match.group(2) ?? '' : '';
      final homeDir =
          Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
      // Retrieve the home directory from environment variables
      if (homeDir == null) {
        throw Exception('Unable to determine user home directory');
      }
      if (username == null || username.isEmpty) {
        result = homeDir + path.separator + remainingPath;
      } else if (Platform.isLinux || Platform.isMacOS) {
        // Case: `~username` → validate user existence on Unix-like systems
        try {
          // Check if the user exists by trying to access their home directory
          // Note: This is a simple check and might not work in all environments
          final userHome = path.join(path.dirname(homeDir), username);
          if (!Directory(userHome).existsSync()) {
            throw Exception(
                'User "$username" does not exist or has no home directory');
          }
          result = path.join(userHome, remainingPath);
        } catch (e) {
          throw Exception(
              'Failed to expand path for user "$username": ${e.toString()}');
        }
      } else {
        throw UnsupportedError(
            'User-specific home directories (e.g., ~username) are not supported on this platform.');
        //result = path.dirname(homeDir) + path.separator + username + result;
      }
    }
    // Return the canonical file path
    return (canonicalize) ? path.canonicalize(result) : result;
  }
}
