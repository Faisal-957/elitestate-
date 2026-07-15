# 🏠 EliteState

EliteState is a **real estate listing mobile app** built with Flutter and Firebase. Users can sign up, browse property listings, search/filter properties, list their own properties for sale/rent, and manage their listings — all backed by Firebase Authentication and Cloud Firestore.

---

## ✨ Features

- **Authentication** — Email/password sign up, sign in, and password reset (Firebase Auth)
- **Home Feed** — Browse all listed properties with a live search bar
- **Property Details** — View full details of a property (title, location, price, beds/baths, area, description, owner info)
- **Add Property** — List a new property with title, location, price, bedrooms, bathrooms, area, and description
- **Edit Property** — Update your own property listings
- **Delete Property** — Remove your own listings with a confirmation dialog
- **My Properties** — View and manage all properties you've listed
- **Profile** — View profile info, About Us, Privacy Policy, Terms & Conditions, and Logout
- **Bottom Navigation** — Quick access to Home, Add Property, My Properties, and Profile

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev) |
| Language | Dart |
| Backend | [Firebase](https://firebase.google.com) (Auth + Cloud Firestore) |
| State Management | [Provider](https://pub.dev/packages/provider) |
| Navigation | [GetX](https://pub.dev/packages/get) |
| Responsive UI | [flutter_screenutil_plus](https://pub.dev/packages/flutter_screenutil_plus) |
| Fonts | [google_fonts](https://pub.dev/packages/google_fonts) |

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── constant/          # App-wide colors & text styles
│   ├── services/          # Firebase services (Auth, Property CRUD)
│   └── widgets/           # Reusable UI widgets (buttons, cards, form fields)
├── models/                # Data models (PropertyModel, UserModel)
├── view/
│   ├── auth/              # Sign in & Sign up screens
│   ├── splashscreen/      # Splash screen
│   ├── Bottom_navigation/ # Bottom nav bar
│   ├── home/              # Home feed screen
│   ├── addproprety_screen/# Add / Edit property screen
│   ├── prop_detailsscreen/# Property details screen
│   └── profile_screen/    # Profile, My Properties, About, Privacy, Terms
├── view_model/            # ChangeNotifier view models (Auth, Property, Home, BottomNav)
├── firebase_options.dart  # Firebase configuration
└── main.dart              # App entry point
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (^3.12.2 or compatible)
- A [Firebase](https://console.firebase.google.com) project with **Authentication** (Email/Password) and **Cloud Firestore** enabled
- Android Studio / Xcode for running on an emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/elitestate.git
   cd elitestate
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable **Email/Password** sign-in under Authentication
   - Create a **Cloud Firestore** database (start in test mode for development)
   - Run FlutterFire CLI to generate your own `firebase_options.dart`:
     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```
   - For Android, place your `google-services.json` in `android/app/`

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🔥 Firestore Data Model

**`properties` collection**

| Field | Type |
|---|---|
| title | `string` |
| location | `string` |
| price | `number` |
| bedrooms | `number` |
| bathrooms | `number` |
| area | `number` |
| description | `string` |
| ownerId | `string` |
| ownerName | `string` |
| createdAt | `timestamp` |

**`users` collection**

| Field | Type |
|---|---|
| name | `string` |
| email | `string` |
| uid | `string` |
| createdAt | `timestamp` |

---

## 📱 Screens

| Screen | Description |
|---|---|
| Splash | App launch screen |
| Sign In / Sign Up | User authentication |
| Home | Browse & search all properties |
| Add Property | Create a new listing |
| Property Details | Full details + edit/delete (owner) or contact (visitor) |
| My Properties | Manage your own listings |
| Profile | Account info, settings, legal pages |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to open a pull request or file an issue.

## 📄 License

This project currently has no license specified. Add one (e.g. MIT) if you plan to open-source it.
