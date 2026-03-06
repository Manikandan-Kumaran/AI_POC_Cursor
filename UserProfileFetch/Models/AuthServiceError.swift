//
//  AuthServiceError.swift
//  UserProfileFetch
//

import Foundation

/// Errors produced by authentication operations.
enum AuthServiceError: Error, LocalizedError {
    case invalidEmail
    case invalidPassword
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .invalidEmail: return "Please enter a valid email address."
        case .invalidPassword: return "Password must be at least 6 characters."
        case .invalidCredentials: return "Invalid email or password."
        }
    }
}
