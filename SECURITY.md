# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |

## Security Requirements

This project follows strict security practices:

- **No weak cryptography**: MD5/SHA1 are blocked for security purposes (SHA256+ required)
- **HTTPS only**: All URLs must use HTTPS (no plaintext HTTP)
- **No hardcoded secrets**: All credentials must use environment variables
- **SHA-pinned dependencies**: All GitHub Actions use SHA-pinned versions
- **SAST scanning**: CodeQL and TruffleHog run on all commits
- **Dependency auditing**: cargo-audit checks for vulnerable dependencies
- **OSSF Scorecard**: Daily security score analysis

## Reporting a Vulnerability

**Please do NOT report security vulnerabilities through public GitHub issues.**

Instead, please report them via:

1. **GitHub Security Advisories**: Use the "Report a vulnerability" button in the Security tab
2. **Email**: Send details to the maintainer (see CODEOWNERS or package metadata)

### What to Include

- Type of vulnerability (e.g., XSS, injection, memory safety)
- Full paths of affected source files
- Step-by-step instructions to reproduce
- Proof-of-concept or exploit code (if possible)
- Impact assessment

### Response Timeline

- **Initial response**: Within 48 hours
- **Status update**: Within 7 days
- **Resolution target**: Within 30 days for critical issues

### Recognition

Contributors who report valid security issues will be credited in the release notes (unless they prefer to remain anonymous).
