//
//  UserProfileFetchApp.swift
//  UserProfileFetch
//

import SwiftUI

@main
struct UserProfileFetchApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @StateObject private var viewModel = UserProfileViewModel(profileService: ProfileService.shared)

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView(viewModel: viewModel, isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
