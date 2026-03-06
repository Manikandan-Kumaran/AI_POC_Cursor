//
//  LoginView.swift
//  UserProfileFetch
//

import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @FocusState private var focusedField: Field?

    private enum Field {
        case email, password
    }

    private var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        !password.isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                header
                formSection
                if let errorMessage {
                    errorBanner(errorMessage)
                }
                loginButton
            }
            .padding(24)
            .padding(.top, 48)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(Color(.systemGroupedBackground))
    }

    private var header: some View {
        VStack(spacing: 12) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .font(.system(size: 64))
                .foregroundStyle(.tint)
            Text("Welcome back")
                .font(.title.bold())
            Text("Sign in to view your profile")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 8)
    }

    private var formSection: some View {
        VStack(spacing: 0) {
            Group {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .password }

                Divider()
                    .padding(.leading, 16)

                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit { performLogin() }
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemGroupedBackground)))
    }

    private func errorBanner(_ message: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundStyle(.red)
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.red)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.red.opacity(0.12)))
    }

    private var loginButton: some View {
        Button(action: performLogin) {
            Text("Log in")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
        .disabled(!canSubmit)
        .padding(.top, 8)
    }

    private func performLogin() {
        errorMessage = nil
        focusedField = nil

        let trimmed = email.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            errorMessage = "Please enter your email."
            return
        }
        guard !password.isEmpty else {
            errorMessage = "Please enter your password."
            return
        }

        // For this POC we accept any non-empty email + password and log in.
        // Replace with real auth (e.g. API call) when needed.
        withAnimation(.easeInOut(duration: 0.25)) {
            isLoggedIn = true
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
