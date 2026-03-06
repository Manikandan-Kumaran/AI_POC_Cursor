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
