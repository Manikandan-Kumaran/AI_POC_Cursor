//
//  LoginViewModel.swift
//  UserProfileFetch
//

import Foundation

/// Manages login screen state and coordinates with `AuthService`. No UI code; only state and service calls.
@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var isAuthenticated = false

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    /// Performs login using the current email and password. Updates `isAuthenticated` on success.
    func login() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let result = await authService.login(email: email, password: password)

        switch result {
        case .success:
            isAuthenticated = true
        case .failure(let error):
            errorMessage = error.errorDescription ?? error.localizedDescription
        }
    }
}
