# Firebase Setup Instructions

## আপনার Message অ্যাপে Firebase সেটআপ করুন

### ১. Firebase Packages ইনস্টল করুন

```bash
flutter pub get
```

### ২. Firebase Project তৈরি করুন

1. [Firebase Console](https://console.firebase.google.com/) এ যান
2. "Add project" ক্লিক করুন
3. প্রজেক্টের নাম দিন (যেমন: "Message App")
4. Google Analytics সক্রিয় রাখুন (optional)
5. প্রজেক্ট তৈরি করুন

### ৩. Android App যোগ করুন

1. Firebase Console এ আপনার project এ ক্লিক করুন
2. Android icon ক্লিক করুন
3. Android package name দিন: `com.example.message` (আপনার `android/app/build.gradle.kts` থেকে নিন)
4. "Register app" ক্লিক করুন
5. `google-services.json` ফাইল ডাউনলোড করুন
6. এটি `android/app/` ফোল্ডারে রাখুন

### ৪. Android Configuration

#### `android/build.gradle.kts` ফাইলে যোগ করুন:

```kotlin
buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
}
```

#### `android/app/build.gradle.kts` ফাইলের শেষে যোগ করুন:

```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // এই লাইন যোগ করুন
}
```

### ৫. Firebase Services সক্রিয় করুন

Firebase Console এ:

1. **Authentication** সক্রিয় করুন:
   - Build → Authentication → Get Started
   - Sign-in method → Email/Password → Enable
   - Save করুন

2. **Cloud Firestore** সক্রিয় করুন:
   - Build → Firestore Database → Create database
   - Test mode select করুন (development এর জন্য)
   - Location select করুন (asia-south1 recommended)
   - Enable করুন

3. **Storage** সক্রিয় করুন (ভবিষ্যতে image/file upload এর জন্য):
   - Build → Storage → Get Started
   - Test mode select করুন
   - Done ক্লিক করুন

### ৬. Firestore Security Rules (Production এর জন্য)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Messages collection
    match /messages/{messageId} {
      allow read, write: if request.auth != null;
    }
    
    // Chats collection
    match /chats/{chatId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### ৭. Main.dart Update করুন

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import '../../../../../core/exported_files/exported_file.dart';
import 'app/message.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();

  runApp(Message());
}
```

### ৮. Test করুন

```bash
flutter run
```

## Features Implemented ✅

### 1. Firebase Authentication Service
- ✅ Email/Password Registration
- ✅ Email/Password Login
- ✅ Logout
- ✅ Password Reset
- ✅ User Profile in Firestore
- ✅ Online/Offline Status
- ✅ Error Handling

### 2. Login Screen
- ✅ Email & Password fields
- ✅ Remember Me checkbox
- ✅ Forgot Password link
- ✅ Firebase integration
- ✅ Loading state
- ✅ Input validation
- ✅ Navigation to Registration

### 3. Registration Screen
- ✅ Full Name field
- ✅ Email field
- ✅ Password field
- ✅ Confirm Password field
- ✅ Terms & Conditions checkbox
- ✅ Firebase integration
- ✅ Loading state
- ✅ Input validation
- ✅ Automatic Firestore user creation

## User Data Structure (Firestore)

প্রতিটি user এর জন্য `/users/{userId}` document:

```json
{
  "uid": "user_id",
  "name": "User Name",
  "email": "user@example.com",
  "photoUrl": "",
  "bio": "Hey there! I am using Message app",
  "isOnline": true,
  "lastSeen": "timestamp",
  "createdAt": "timestamp"
}
```

## Next Steps 📱

1. ✅ Onboarding Screen - Done
2. ✅ Login Screen - Done  
3. ✅ Registration Screen - Done
4. 🔜 Chat List Screen
5. 🔜 Chat Screen (Real-time messaging)
6. 🔜 User Profile Screen
7. 🔜 Image Upload
8. 🔜 Push Notifications

## Important Files Created

```
lib/
  core/
    services/
      firebase_services/
        ✅ firebase_auth_service.dart
  feature/
    auth/
      login/
        presentation/
          controllers/
            ✅ login_controller.dart (Updated with Firebase)
          screens/
            ✅ login_screen.dart (Already existed)
      registration/
        presentation/
          controllers/
            ✅ registration_controller.dart (Complete Firebase integration)
          screens/
            ✅ registration_screen.dart (Complete UI)
```

## Troubleshooting

### যদি Firebase সংযোগ না হয়:
1. `google-services.json` সঠিক জায়গায় আছে কিনা চেক করুন
2. `flutter clean && flutter pub get` রান করুন
3. Android build.gradle files সঠিকভাবে কনফিগার করা আছে কিনা দেখুন

### যদি Authentication error আসে:
1. Firebase Console এ Email/Password authentication enable করা আছে কিনা চেক করুন
2. Internet connection চেক করুন

---

**Created by:** AI Assistant
**Date:** February 27, 2026

