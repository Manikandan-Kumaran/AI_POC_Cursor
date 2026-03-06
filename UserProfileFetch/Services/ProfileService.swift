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

final class ProfileService {
    static let shared = ProfileService()

    private let baseURL = "https://jsonplaceholder.typicode.com/users"
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchProfile(userId: Int = 1) async throws -> UserProfile {
        guard let url = URL(string: "\(baseURL)/\(userId)") else {
            throw ProfileServiceError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw ProfileServiceError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(UserProfile.self, from: data)
        } catch {
            throw ProfileServiceError.decodingError
        }
    }
}
