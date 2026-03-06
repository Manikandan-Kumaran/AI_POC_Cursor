//
//  UserProfileFetchApp.swift
//  UserProfileFetch
//

import SwiftUI

@main
struct UserProfileFetchApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @StateObject private var loginViewModel = LoginViewModel(authService: AuthService.shared)
    @StateObject private var profileViewModel = UserProfileViewModel(profileService: ProfileService.shared)

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView(viewModel: profileViewModel)
            } else {
                LoginView(viewModel: loginViewModel) {
                    isLoggedIn = true
                }
            }
        }
    }
}
