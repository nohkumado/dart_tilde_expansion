import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:tilde_expansion/tilde_expansion.dart';
import 'package:test/test.dart';

void main() {
  group('expandUser', () {
    final userName = Platform.environment['USER'] ?? Platform.environment['USERNAME'] ?? "user";
    final homeDir = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE']!;

    // Fonction pour générer les chemins attendus
    String expectedPath(String user, String subPath, {bool canonicalize = false}) {
      final basePath = Platform.isWindows
          ? 'C:\\Users\\$user\\$subPath'.replaceAll('/', path.separator)
          : '/home/$user/$subPath';
      return canonicalize ? path.canonicalize(basePath) : basePath;
    }

    test('should expand normal paths correctly', () {
      // Cas normaux (sans dépendance utilisateur)
      final normalCases = [
        ['path/to/file.txt', 'path/to/file.txt',
         '${Directory.current.path}${path.separator}path${path.separator}to${path.separator}file.txt'],

        ['/path/to/file.txt', '/path/to/file.txt', '/path/to/file.txt'],

        ['~/Documents/test.txt',
         expectedPath(userName, 'Documents/test.txt'),
         expectedPath(userName, 'Documents/test.txt', canonicalize: true)],

        ['~/Documents/../Downloads/test.txt',
         expectedPath(userName, 'Documents/../Downloads/test.txt'),
         expectedPath(userName, 'Downloads/test.txt', canonicalize: true)],
      ];

      // Tester les cas normaux
      for (final candidate in normalCases) {
        expect(candidate[0].expandUser(canonicalize: false), candidate[1]);
        expect(candidate[0].expandUser(canonicalize: true), candidate[2]);
      }
    });

    test('should handle ~username cases correctly', () {
      if (Platform.isWindows) {
        // Sur Windows, ~username doit lever une exception
        expect(() => '~docker/Documents/test.txt'.expandUser(),
               throwsA(isA<UnsupportedError>()));
        expect(() => '~toto/Documents/test.txt'.expandUser(),
               throwsA(isA<UnsupportedError>()));
      } else {
        // Sur Unix, on teste uniquement la structure du chemin
        // sans vérifier l'existence réelle de l'utilisateur
        final expectedDocker = expectedPath('docker', 'Documents/test.txt');
        final resultDocker = '~docker/Documents/test.txt'.expandUser();
        // On vérifie juste que le chemin a la bonne structure
        expect(resultDocker, endsWith('docker/Documents/test.txt'));

        // Pour un utilisateur inexistant, on vérifie qu'une exception est levée
        // Mais on ne peut pas garantir que 'toto' n'existe pas sur la machine de test
        // Donc on saute ce test ou on utilise un nom très improbable
        try {
          '~nonexistentuser123456789'.expandUser();
          fail('Should have thrown an exception for non-existent user');
        } catch (e) {
          expect(e, isA<Exception>());
        }
      }
    });
  });
}

/*
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:tilde_expansion/tilde_expansion.dart';
import 'package:test/test.dart';

void main() {
  test('expandUser should expand tilde to home directory', () {
    final userName = Platform.environment['USER'] ??
        Platform.environment['USERNAME'] ??
        "user";
    final homeDir =
        Platform.environment['HOME'] ?? Platform.environment['USERPROFILE']!;

    // Fonction pour générer les chemins attendus selon la plateforme
    String expectedPath(String user, String subPath,
        {bool canonicalize = false}) {
      final basePath = Platform.isWindows
          ? 'C:\\Users\\$user\\$subPath'.replaceAll('/', path.separator)
          : '/home/$user/$subPath';

      return canonicalize ? path.canonicalize(basePath) : basePath;
    }

    // Liste des cas de test [input, expected_no_canonicalize, expected_canonicalize?]
    // Pour les cas d'erreur: [input, exceptionMatcher, null]
    final candidates = [
      // Cas normaux
      [
        'path/to/file.txt',
        'path/to/file.txt',
        '${Directory.current.path}${path.separator}path${path.separator}to${path.separator}file.txt'
      ],

      ['/path/to/file.txt', '/path/to/file.txt', '/path/to/file.txt'],

      [
        '~/Documents/test.txt',
        expectedPath(userName, 'Documents/test.txt'),
        expectedPath(userName, 'Documents/test.txt', canonicalize: true)
      ],

      [
        '~/Documents/../Downloads/test.txt',
        expectedPath(userName, 'Documents/../Downloads/test.txt'),
        expectedPath(userName, 'Downloads/test.txt', canonicalize: true)
      ],

      // Cas spéciaux avec gestion d'erreurs
      [
        '~docker/Documents/test.txt',
        Platform.isWindows
            ? throwsA(isA<UnsupportedError>())
            : expectedPath('docker', 'Documents/test.txt'),
        null
      ],

      [
        '~toto/Documents/test.txt',
        Platform.isWindows
            ? throwsA(isA<UnsupportedError>())
            : throwsA(isA<Exception>()),
        null
      ],
    ];

    for (final candidate in candidates) {
      final input = candidate[0] as String;

      // Test sans canonicalize
      if (candidate[1] is String) {
        expect(input.expandUser(canonicalize: false), candidate[1],
            reason: '$input should expand to ${candidate[1]}');
      } else {
        expect(() => input.expandUser(canonicalize: false),
            candidate[1] as Matcher);
      }

      // Test avec canonicalize (si présent)
      if (candidate.length > 2 && candidate[2] != null) {
        expect(input.expandUser(canonicalize: true), candidate[2],
            reason: '$input should canonicalize to ${candidate[2]}');
      }
    }
  });
}
*/
