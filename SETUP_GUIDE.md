# 🚀 Message App - Firebase Real-time Messaging Setup Guide

## 📋 Table of Contents
1. [Quick Start](#quick-start)
2. [Firebase Setup](#firebase-setup)
3. [Android Configuration](#android-configuration)
4. [iOS Configuration](#ios-configuration)
5. [Features Implemented](#features-implemented)
6. [Testing](#testing)
7. [Troubleshooting](#troubleshooting)

---

## ⚡ Quick Start

### Step 1: Install Dependencies
```bash
cd C:\Users\srsad\StudioProjects\message
flutter pub get
```

### Step 2: Create Firebase Project
Visit [Firebase Console](https://console.firebase.google.com/) and create a new project.

### Step 3: Configure Firebase for Android & iOS
Follow the platform-specific guides below.

### Step 4: Run the App
```bash
flutter run
```

---

## 🔥 Firebase Setup

### Create Firebase Project

1. Go to [console.firebase.google.com](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `message-app`
4. Enable Google Analytics (optional)
5. Click "Create project"

### Add Android App

1. In Firebase Console, click the Android icon
2. **Package name:** `com.example.message` (check your `android/app/build.gradle.kts`)
3. **App nickname:** Message App (optional)
4. **Debug SHA-1:** (optional for development)
5. Click "Register app"
6. **Download** `google-services.json`
7. Place it in `android/app/` folder
8. Click "Next" through the setup steps
9. Click "Continue to console"

### Add iOS App

1. Click the iOS icon
2. **Bundle ID:** `com.example.message` (from your Xcode project)
3. Click "Register app"
4. Download `GoogleService-Info.plist`
5. Open Xcode: `ios/Runner.xcworkspace`
6. Right-click "Runner" folder → "Add Files to Runner"
7. Select `GoogleService-Info.plist`
8. Make sure it's added to "Runner" target

---

## 🤖 Android Configuration

### Step 1: Update android/build.gradle.kts

```kotlin
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
        classpath("com.google.gms:google-services:4.4.2")  // ✅ ADD THIS LINE
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

### Step 2: Update android/app/build.gradle.kts

At the **very top** of the file:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // ✅ ADD THIS LINE
}
```

### Step 3: Verify google-services.json

```
android/
  app/
    google-services.json  ✅ Must be here
    src/
    build.gradle.kts
```

---

## 🍎 iOS Configuration

### Step 1: Verify GoogleService-Info.plist

```
ios/
  Runner/
    GoogleService-Info.plist  ✅ Must be here
    AppDelegate.swift
    Info.plist
```

### Step 2: Update ios/Podfile

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'FIREBASE_CORE_VERSION=10.0.0',
      ]
    end
  end
end
```

### Step 3: Update Deployment Target

1. Open `ios/Podfile`
2. Set minimum iOS version to 11.0 or higher:

```ruby
platform :ios, '11.0'
```

---

## 🔐 Enable Firebase Services

### Authentication

1. Go to **Build** → **Authentication** in Firebase Console
2. Click **Get Started**
3. Click **Email/Password**
4. Toggle **Enable**
5. Click **Save**

### Cloud Firestore

1. Go to **Build** → **Firestore Database**
2. Click **Create Database**
3. Start in **Test mode** (for development)
4. Select region: **asia-south1** (or nearest to you)
5. Click **Enable**

### Cloud Storage

1. Go to **Build** → **Storage**
2. Click **Get Started**
3. Start in **Test mode**
4. Click **Done**

---

## 📊 Firestore Security Rules

Go to **Firestore Database** → **Rules** and update:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Development: Allow everything (test mode)
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
    
    // Production: Restrict access by user
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /messages/{messageId} {
      allow read, write: if request.auth != null;
    }
    
    match /chats/{chatId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

## ✨ Features Implemented

### ✅ Authentication
- [x] Email/Password Registration
- [x] Email/Password Login
- [x] Logout with status update
- [x] Remember Me checkbox
- [x] Input validation
- [x] Error handling
- [x] Loading states

### ✅ User Management
- [x] Firestore user profile creation
- [x] User data persistence
- [x] Online/Offline status
- [x] Last seen timestamp
- [x] User bio/profile info

### ✅ UI/UX
- [x] Login Screen
- [x] Registration Screen
- [x] Onboarding Screen
- [x] Responsive design
- [x] Localization support
- [x] Loading indicators

### ✅ Database Structure
- [x] Users collection
- [x] Messages collection (structure)
- [x] Chats collection (structure)
- [x] Security rules

---

## 🧪 Testing

### Test Login
1. Launch app
2. Go to Login screen
3. Test credentials:
   - **Email:** test@example.com
   - **Password:** test123456
4. Click "Log In"

### Test Registration
1. Go to Registration screen
2. Enter:
   - **Name:** Test User
   - **Email:** newuser@example.com
   - **Password:** test123456
   - **Confirm:** test123456
3. Check "I agree to Terms"
4. Click "Register"

### Verify Firestore
1. Go to Firebase Console
2. **Firestore Database** → **Data**
3. Check `/users` collection for new user profile

---

## 🐛 Troubleshooting

### ❌ Firebase Initialization Error

**Error:** `Target of URI doesn't exist: 'package:firebase_core/firebase_core.dart'`

**Solution:**
```bash
flutter clean
flutter pub get
```

### ❌ google-services.json Not Found

**Error:** Build fails with "google-services.json not found"

**Solution:**
1. Download `google-services.json` from Firebase Console
2. Place in `android/app/` folder
3. Ensure filename is exactly `google-services.json`

### ❌ Authentication Fails

**Error:** "Authentication failed" or "user-not-found"

**Solution:**
1. Check Firebase Console → Authentication → Email/Password is **Enabled**
2. Verify internet connection
3. Check email format is valid

### ❌ Firestore Access Denied

**Error:** "Permission denied" in Firestore

**Solution:**
1. Go to Firestore Database → Rules
2. Set to **Test mode** for development
3. Or update security rules to allow authenticated users

### ❌ iOS Build Error

**Error:** `Module FirebaseCore not found`

**Solution:**
```bash
cd ios
rm -rf Pods Podfile.lock
cd ..
flutter pub get
flutter run
```

### ❌ Android Build Error

**Error:** `Gradle compilation error`

**Solution:**
1. Verify `com.google.gms:google-services:4.4.2` in `build.gradle.kts`
2. Verify `id("com.google.gms.google-services")` in `app/build.gradle.kts`
3. Run:
```bash
flutter clean
flutter pub get
./gradlew clean
./gradlew build
```

---

## 📦 Installed Packages

```yaml
firebase_core: ^3.8.1      # Firebase core library
firebase_auth: ^5.3.4      # Firebase authentication
cloud_firestore: ^5.6.0    # Cloud Firestore database
firebase_storage: ^12.3.8  # Cloud Storage
```

---

## 🎯 Project Structure

```
lib/
├── main.dart                          # ✅ Firebase initialized
├── core/
│   ├── services/
│   │   └── firebase_services/
│   │       └── firebase_auth_service.dart    # ✅ Auth service
│   └── localization/
│       └── en_us.dart                 # ✅ Updated strings
├── feature/
│   ├── auth/
│   │   ├── login/
│   │   │   ├── controllers/
│   │   │   │   └── login_controller.dart     # ✅ Firebase integrated
│   │   │   └── screens/
│   │   │       └── login_screen.dart
│   │   └── registration/
│   │       ├── controllers/
│   │       │   └── registration_controller.dart  # ✅ Firebase integrated
│   │       └── screens/
│   │           └── registration_screen.dart     # ✅ Complete UI
│   └── sp_and_onboarding_flow/
│       └── onboarding/                        # ✅ Already created
└── build.gradle.kts                  # ✅ Updated for Firebase

android/
├── app/
│   ├── google-services.json          # ✅ Add here
│   └── build.gradle.kts              # ✅ Updated
└── build.gradle.kts                  # ✅ Updated
```

---

## 🚀 Next Steps

After Firebase setup:

1. **Test Authentication:**
   - [ ] Register a new account
   - [ ] Login with registered account
   - [ ] Verify user in Firestore

2. **Build Chat Features:**
   - [ ] Chat list screen
   - [ ] Real-time messaging
   - [ ] Message history
   - [ ] User search

3. **Add Advanced Features:**
   - [ ] Profile editing
   - [ ] Image uploads
   - [ ] Push notifications
   - [ ] Group chats

---

## 📞 Support

- **Firebase Docs:** https://firebase.flutter.dev/
- **GetX Docs:** https://github.com/jonataslaw/getx
- **Firestore Guide:** https://firebase.google.com/docs/firestore

---

## ✅ Checklist

- [ ] Firebase project created
- [ ] google-services.json downloaded & placed in `android/app/`
- [ ] GoogleService-Info.plist downloaded & added to Xcode
- [ ] build.gradle.kts files updated
- [ ] Podfile updated (iOS)
- [ ] `flutter pub get` completed
- [ ] Authentication enabled in Firebase
- [ ] Firestore database created
- [ ] Security rules updated
- [ ] App runs successfully
- [ ] Registration works
- [ ] Login works
- [ ] User appears in Firestore

---

**Status:** Ready for Development ✅
**Last Updated:** February 27, 2026
**Version:** 1.0.0

