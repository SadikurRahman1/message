es# 🔥 Firebase Setup - IMMEDIATE FIX

## সমস্যা: google-services.json Missing

আপনার app crashed করছে কারণ **google-services.json** file নেই।

---

## ✅ দ্রুত সমাধান (5 মিনিট)

### Option 1: Firebase Console থেকে Download করুন (সুপারিশকৃত)

#### Step 1: Firebase Console এ যান
```
https://console.firebase.google.com/
```

#### Step 2: আপনার project select করুন
- যদি project না থাকে, নতুন project তৈরি করুন

#### Step 3: Android app যোগ করুন
1. গিয়ার icon (⚙️) ক্লিক করুন
2. "Project settings" এ যান
3. "Your apps" section এ Android icon ক্লিক করুন
4. **Package name:** `com.example.message` enter করুন
   - (আপনার android/app/build.gradle.kts এ `applicationId` দেখুন)
5. "Register app" click করুন

#### Step 4: google-services.json download করুন
1. "Download google-services.json" button ক্লিক করুন
2. ফাইল download হবে

#### Step 5: সঠিক জায়গায় রাখুন
```
android/
└─ app/
   └─ google-services.json  ← এখানে রাখুন
```

**Important:** File name exactly `google-services.json` হতে হবে!

#### Step 6: Android project sync করুন
```bash
cd C:\Users\srsad\StudioProjects\message
flutter clean
flutter pub get
```

#### Step 7: App চালান
```bash
flutter run
```

---

### Option 2: Development এর জন্য Mock setup (যদি Firebase না চাইলে)

যদি এখনই Firebase সেটআপ না করতে চান, তাহলে এই dummy file ব্যবহার করুন:

**Create:** `android/app/google-services.json`

```json
{
  "project_info": {
    "project_number": "123456789",
    "firebase_url": "https://your-project.firebaseio.com",
    "project_id": "your-project",
    "storage_bucket": "your-project.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:123456789:android:abcdef1234567890",
        "android_client_info": {
          "package_name": "com.example.message"
        }
      },
      "oauth_client": [],
      "api_key": [
        {
          "current_key": "AIzaXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": []
        }
      }
    }
  ],
  "configuration_version": "1"
}
```

**তারপর:**
```bash
flutter clean
flutter pub get
flutter run
```

---

## 🔧 Android Configuration Check

### Verify android/build.gradle.kts

```kotlin
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
        classpath("com.google.gms:google-services:4.4.2")  // ✅ এটি থাকতে হবে
    }
}
```

### Verify android/app/build.gradle.kts

**উপরের দিকে (plugins section):**
```kotlin
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // ✅ এটি থাকতে হবে
}
```

**নিচের দিকে (end of file):**
```kotlin
// ... existing code ...
```

---

## ✅ ধাপে ধাপে সমাধান

### 1. Firebase Console থেকে google-services.json download করুন
```
⏱️ সময়: 5 মিনিট
```

### 2. android/app/ folder এ রাখুন
```
✓ File: android/app/google-services.json
```

### 3. Clean এবং restart করুন
```bash
flutter clean
flutter pub get
flutter run
```

### 4. Android Studio এ sync করুন (যদি error থাকে)
- Android Studio খুলুন
- android folder ক্লিক করুন
- File → Sync Now

---

## 🚀 এরপর কী হবে

### সফল হলে:
```
✅ Firebase initialized successfully
✅ App চালু হবে splash screen দিয়ে
✅ Onboarding screen দেখা যাবে
```

### Error থাকলে:
1. android/app/google-services.json আছে কিনা check করুন
2. build.gradle.kts files সঠিক কিনা verify করুন
3. Android Studio এ Sync Now করুন
4. `flutter clean && flutter pub get` চালান
5. Again `flutter run` করুন

---

## 📝 Package Name কীভাবে খুঁজবেন

**android/app/build.gradle.kts এ খুঁজুন:**

```kotlin
android {
    namespace = "com.example.message"  // ← এটিই আপনার package name
    
    defaultConfig {
        applicationId = "com.example.message"  // ← এটাও
    }
}
```

Firebase এ এই exact name ব্যবহার করুন!

---

## 🆘 যদি এখনও error হয়

### Option 1: Flutter Doctor চালান
```bash
flutter doctor -v
```

এটি কোনো missing config দেখাবে।

### Option 2: Gradle Cache Clear করুন
```bash
cd C:\Users\srsad\StudioProjects\message\android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Option 3: Android Emulator Restart করুন
1. Emulator বন্ধ করুন
2. Android Studio → Virtual Device Manager
3. আপনার device select করুন → Play button

---

## ✨ Success Checklist

- [ ] Firebase project created
- [ ] google-services.json downloaded
- [ ] google-services.json in android/app/ folder
- [ ] android/build.gradle.kts updated
- [ ] android/app/build.gradle.kts updated
- [ ] `flutter clean` run করা হয়েছে
- [ ] `flutter pub get` run করা হয়েছে
- [ ] `flutter run` successful
- [ ] App চালু হয়েছে
- [ ] Splash screen দেখা যাচ্ছে

---

## 📞 Next Steps

যখন Firebase properly setup হয়:
1. Registration screen test করুন
2. Login screen test করুন
3. Firestore এ user data check করুন
4. SETUP_GUIDE.md এ বাকি security rules add করুন

---

**আপনাকে কি আমি আরও help করতে পারি?**

এই document এর steps follow করুন এবং report করুন কি হলো। 🚀

