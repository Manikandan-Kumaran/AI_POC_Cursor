//
//  AuthService.swift
//  UserProfileFetch
//

import Foundation

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case networkError(Error)
    case cancelled

    var errorDescription: String? {
        switch self {
        case .invalidCredentials: return "Invalid email or password"
        case .networkError(let error): return "Network error: \(error.localizedDescription)"
        case .cancelled: return "Login was cancelled"
        }
    }
}

protocol AuthServiceProtocol: AnyObject {
    func login(email: String, password: String) async -> Result<Void, AuthError>
}

/// Mock auth service for demo. Validates format and simulates network delay.
final class AuthService: AuthServiceProtocol {
    static let shared = AuthService()

    init() {}

    func login(email: String, password: String) async -> Result<Void, AuthError> {
        do {
            try await Task.sleep(nanoseconds: 800_000_000)
        } catch is CancellationError {
            return .failure(.cancelled)
        } catch {
            return .failure(.networkError(error))
        }

        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.contains("@"), trimmed.contains("."), password.count >= 6 else {
            return .failure(.invalidCredentials)
        }
        return .success(())
    }
}
