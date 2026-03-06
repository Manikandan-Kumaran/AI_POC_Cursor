//
//  ContentView.swift
//  UserProfileFetch
//

import SwiftUI

struct ContentView: View {
    @State private var profile: UserProfile?
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if isLoading {
                        ProgressView("Loading profile…")
                            .padding(.top, 60)
                    } else if let errorMessage {
                        VStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundStyle(.orange)
                            Text(errorMessage)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 40)
                    } else if let profile {
                        profileCard(profile)
                    } else {
                        VStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 64))
                                .foregroundStyle(.secondary)
                            Text("Tap below to fetch a user profile")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 60)
                    }

                    if !isLoading {
                        Button {
                            Task { await fetchProfile() }
                        } label: {
                            Label(profile == nil ? "Fetch Profile" : "Refresh Profile", systemImage: "arrow.clockwise")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                    }
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("User Profile")
            .refreshable {
                await fetchProfile()
            }
        }
        .task {
            if profile == nil && !isLoading {
                await fetchProfile()
            }
        }
    }

    @ViewBuilder
    private func profileCard(_ profile: UserProfile) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(.tint)
                VStack(alignment: .leading, spacing: 4) {
                    Text(profile.name)
                        .font(.title2.bold())
                    Text("@\(profile.username)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding(.bottom, 4)

            Divider()

            row(icon: "envelope.fill", title: "Email", value: profile.email)
            if let phone = profile.phone, !phone.isEmpty {
                row(icon: "phone.fill", title: "Phone", value: phone)
            }
            if let website = profile.website, !website.isEmpty {
                row(icon: "globe", title: "Website", value: website)
            }
            if let address = profile.address {
                row(icon: "mappin.circle.fill", title: "Address", value: "\(address.street), \(address.city)")
            }
            if let company = profile.company {
                row(icon: "building.2.fill", title: "Company", value: company.name)
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .padding(.horizontal, 20)
    }

    private func row(icon: String, title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(.secondary)
                .frame(width: 24, alignment: .center)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.subheadline)
            }
            Spacer()
        }
    }

    private func fetchProfile() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            profile = try await ProfileService.shared.fetchProfile()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    ContentView()
}
