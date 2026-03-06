//
//  UserProfileViewModel.swift
//  UserProfileFetch
//

import Foundation

@MainActor
final class UserProfileViewModel: ObservableObject {
    @Published private(set) var profile: UserProfile?
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let profileService: ProfileServiceProtocol
    private let userId: Int

    init(profileService: ProfileServiceProtocol, userId: Int = 1) {
        self.profileService = profileService
        self.userId = userId
    }

    func loadProfile() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let result = await profileService.fetchProfile(userId: userId)

        switch result {
        case .success(let value):
            profile = value
        case .failure(let error):
            errorMessage = error.errorDescription ?? error.localizedDescription
        }
    }
}
