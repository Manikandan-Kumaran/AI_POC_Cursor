# User Profile Fetch (iOS)

A simple iOS app that fetches and displays a user profile from a remote API.

## Features

- **Fetch user profile** from [JSONPlaceholder](https://jsonplaceholder.typicode.com/) (public test API)
- **Profile card** showing name, username, email, phone, website, address, and company
- **Pull-to-refresh** and **Fetch / Refresh** button
- **Loading and error states** with clear feedback
- **SwiftUI** + **async/await** networking

## Requirements

- Xcode 15+
- iOS 17.0+
- Network access (uses HTTPS)

## How to run

1. Open `UserProfileFetch.xcodeproj` in Xcode.
2. Select a simulator or device.
3. Press **Run** (⌘R).

On launch, the app fetches user profile for ID `1`. Use **Fetch Profile** or pull down to refresh.

## Project structure

```
UserProfileFetch/
├── UserProfileFetchApp.swift   # App entry point
├── ContentView.swift           # Main UI (profile card, fetch button, states)
├── Models/
│   └── UserProfile.swift       # Codable profile model
├── Services/
│   └── ProfileService.swift    # Async API client (JSONPlaceholder)
├── Assets.xcassets
└── Preview Content/
```

## API

The app uses `GET https://jsonplaceholder.typicode.com/users/1`. No API key or auth required.

# 🚨 STRICT ARCHITECTURE REQUIREMENTS (MANDATORY)

This project follows STRICT architectural constraints.
All generated code MUST follow the rules below without exception.

Failure to follow these rules is considered invalid implementation.

---

# 1️⃣ Architecture Pattern

- The project MUST follow Clean Architecture.
- The project MUST use MVVM pattern.
- UI layer MUST NOT contain business logic.
- UI layer MUST NOT directly call API or database.
- ViewModels MUST NOT contain UI code.

---

# 2️⃣ Layer Responsibilities

## UI Layer
- Contains only Views.
- No API calls.
- No business logic.
- Only binds to ViewModel.

## ViewModel Layer
- Contains state management.
- Calls Services.
- No direct HttpClient usage.
- No database logic.

## Service Layer
- All API calls MUST go through Service classes.
- Services MUST use async/await.
- Services MUST handle errors properly.

---

# 3️⃣ Dependency Rules

- Dependency Injection MUST be used.
- No tight coupling between layers.
- No static service calls.
- All services MUST use interfaces.

Dependency Flow:
UI → ViewModel → Service → External API

Reverse dependency is NOT allowed.

---

# 4️⃣ Code Quality Rules

- No hardcoded API keys.
- No commented-out code.
- All public methods MUST have documentation.
- All async calls MUST use async/await properly.
- Proper error handling is required.

---

# 5️⃣ Folder Structure (MANDATORY)

Project/
 ├── Views/
 ├── ViewModels/
 ├── Services/
 ├── Models/
 ├── Interfaces/

Files MUST be placed in correct folders.

---

# 6️⃣ Security Rules

- Only minimum permissions allowed.
- All user input MUST be validated.
- Sensitive data MUST be encrypted.
- No insecure storage allowed.

---

# 7️⃣ Testing Rules

- Business logic MUST be testable.
- Services MUST be mockable.
- No logic should depend directly on UI.

---

# 🚨 IMPORTANT

If generating new code:
- Follow all rules above automatically.
- Do not ask whether to follow them.
- They are mandatory project standards.