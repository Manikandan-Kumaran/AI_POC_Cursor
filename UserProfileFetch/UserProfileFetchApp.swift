//
//  UserProfileFetchApp.swift
//  UserProfileFetch
//

import SwiftUI

@main
struct UserProfileFetchApp: App {
    @StateObject private var viewModel = UserProfileViewModel(profileService: ProfileService.shared)

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
