//
//  AuthService.swift
//  UserProfileFetch
//

import Foundation

/// Handles authentication. Validates input and performs login (POC uses validation only; no remote API).
final class AuthService: AuthServiceProtocol {
    private let minPasswordLength = 6

    init() {}

    /// Validates email and password, then performs login. For POC, accepts a fixed credential for demo.
    /// - Parameters:
    ///   - email: User email; must be non-empty and valid format.
    ///   - password: User password; must meet minimum length.
    /// - Returns: Success if validation and credentials pass; failure with `AuthServiceError` otherwise.
    func login(email: String, password: String) async -> Result<Void, AuthServiceError> {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard isValidEmail(trimmedEmail) else {
            return .failure(.invalidEmail)
        }
        guard trimmedPassword.count >= minPasswordLength else {
            return .failure(.invalidPassword)
        }

        if trimmedEmail.lowercased() == "user@example.com" && trimmedPassword == "password" {
            return .success(())
        }
        return .failure(.invalidCredentials)
    }

    private func isValidEmail(_ string: String) -> Bool {
        let pattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(string.startIndex..., in: string)
        return regex.firstMatch(in: string, options: [], range: range) != nil
    }
}
