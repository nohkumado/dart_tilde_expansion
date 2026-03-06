# Security Policy

## Supported Versions
This package is maintained for the **latest stable version of Dart**.
Only the most recent major version receives security updates.

| Version | Supported          |
|---------|--------------------|
| `>=1.0.0` | :white_check_mark: |

## Reporting a Vulnerability
If you discover a security vulnerability in `dart_tilde_expansion`, please report it **responsibly** by:
1. **Opening an issue** on GitHub (preferred for non-critical issues).
2. **Emailing** [nohkumado@gmail] (mailto:nohkumado@gmail) for sensitive disclosures.

### Vulnerability Handling
- **Response time**: We aim to acknowledge reports within **48 hours** and provide a fix within **7 days** for critical issues.
- **Disclosure**: Public disclosure will be coordinated with you and published after a fix is released.

## Security Scope
This policy covers:
- Remote code execution risks.
- Path traversal vulnerabilities.
- Any behavior that could lead to unintended filesystem access.

### Out of Scope
- Issues in dependencies (report to their maintainers).
- Theoretical vulnerabilities without practical impact.

## Best Practices for Users
- Always validate paths before using them in filesystem operations.
- Avoid using untrusted input with `expandTilde`.

## Credits
Security researchers who report vulnerabilities responsibly will be credited in the project’s `CHANGELOG.md`.

