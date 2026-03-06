//
//  AuthServiceProtocol.swift
//  UserProfileFetch
//

import Foundation

/// Contract for authentication operations. All API or auth logic must go through a type conforming to this protocol.
protocol AuthServiceProtocol: AnyObject {
    /// Attempts to log in with the given credentials.
    /// - Parameters:
    ///   - email: User email (must be valid format).
    ///   - password: User password (must meet minimum requirements).
    /// - Returns: Success if credentials are valid; failure with `AuthServiceError` otherwise.
    func login(email: String, password: String) async -> Result<Void, AuthServiceError>
}
