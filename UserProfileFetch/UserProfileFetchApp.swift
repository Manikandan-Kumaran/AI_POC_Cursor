//
//  UserProfileFetchApp.swift
//  UserProfileFetch
//

import SwiftUI

@main
struct UserProfileFetchApp: App {
    @StateObject private var loginViewModel = LoginViewModel(authService: AuthService())
    @StateObject private var profileViewModel = UserProfileViewModel(profileService: ProfileService.shared)

    var body: some Scene {
        WindowGroup {
            if loginViewModel.isAuthenticated {
                ContentView(viewModel: profileViewModel)
            } else {
                LoginView(viewModel: loginViewModel)
            }
        }
    }
}
