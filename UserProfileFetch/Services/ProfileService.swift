//
//  ProfileService.swift
//  UserProfileFetch
//

import Foundation

enum ProfileServiceError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .networkError(let error): return "Network error: \(error.localizedDescription)"
        case .invalidResponse: return "Invalid server response"
        case .decodingError: return "Failed to decode profile"
        }
    }
}

protocol ProfileServiceProtocol: AnyObject {
    func fetchProfile(userId: Int) async -> Result<UserProfile, ProfileServiceError>
}

final class ProfileService: ProfileServiceProtocol {
    static let shared = ProfileService()

    private let baseURL = "https://jsonplaceholder.typicode.com/users"
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchProfile(userId: Int = 1) async -> Result<UserProfile, ProfileServiceError> {
        guard let url = URL(string: "\(baseURL)/\(userId)") else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return .failure(.invalidResponse)
            }

            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(UserProfile.self, from: data)
                return .success(profile)
            } catch {
                return .failure(.decodingError)
            }
        } catch {
            return .failure(.networkError(error))
        }
    }
}
