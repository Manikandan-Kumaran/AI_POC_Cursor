//
//  LoginViewModel.swift
//  UserProfileFetch
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var loginSucceeded = false

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let result = await authService.login(email: email, password: password)

        switch result {
        case .success:
            loginSucceeded = true
        case .failure(let error):
            errorMessage = error.errorDescription ?? error.localizedDescription
        }
    }
}
