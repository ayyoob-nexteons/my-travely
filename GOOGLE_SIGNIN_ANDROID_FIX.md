# 🔧 Google Sign-In Android Fix Guide

## 🚨 **Error: ApiException 10**
This error occurs when Google Sign-In is not properly configured on Android.

## 📋 **Step-by-Step Fix**

### **Step 1: Get SHA-1 Fingerprint**

#### **Method A: Using Android Studio (Recommended)**
1. Open Android Studio
2. Open your Flutter project
3. Click on **Gradle** tab (right side panel)
4. Navigate to: `app > Tasks > android > signingReport`
5. Double-click `signingReport`
6. Copy the **SHA1** fingerprint from the output

#### **Method B: Using Command Line**
```bash
# Windows
keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android

# macOS/Linux
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

#### **Method C: Manual**
1. Navigate to: `C:\Users\[YourUsername]\.android\debug.keystore`
2. Use online SHA-1 generator tools

### **Step 2: Configure Google Cloud Console**

1. **Go to**: [Google Cloud Console](https://console.cloud.google.com/)
2. **Create Project**: Create a new project or select existing
3. **Enable APIs**:
   - Go to "APIs & Services" > "Library"
   - Search and enable "Google Sign-In API"
4. **Create Credentials**:
   - Go to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "OAuth 2.0 Client IDs"
   - Choose "Android" as application type
5. **Configure Android Client**:
   - **Package name**: `com.example.my_travely`
   - **SHA-1 fingerprint**: Paste the SHA-1 from Step 1
6. **Download**: Download the `google-services.json` file

### **Step 3: Add google-services.json**

1. **Place the file**: Put `google-services.json` in `android/app/` directory
2. **Remove template**: Delete `google-services.json.template` if it exists
3. **Verify location**: File should be at `android/app/google-services.json`

### **Step 4: Update Constants**

Update your client ID in `lib/core/utils/constants.dart`:

```dart
// Replace with your actual Android client ID from Google Console
static const String googleAndroidClientId = 'YOUR_ANDROID_CLIENT_ID.apps.googleusercontent.com';
```

### **Step 5: Clean and Rebuild**

```bash
flutter clean
flutter pub get
flutter run
```

## 🔍 **Troubleshooting**

### **Common Issues:**

1. **Wrong Package Name**: Ensure package name matches exactly
2. **SHA-1 Mismatch**: Double-check SHA-1 fingerprint
3. **Missing google-services.json**: File must be in `android/app/`
4. **Wrong Client ID**: Use Android client ID, not web client ID

### **Verify Configuration:**

1. **Check google-services.json**: Should contain your project info
2. **Check package name**: Must match `com.example.my_travely`
3. **Check SHA-1**: Must match your debug keystore
4. **Check client ID**: Use Android client ID in constants

## 📱 **Testing**

After configuration:
1. **Clean build**: `flutter clean && flutter pub get`
2. **Run app**: `flutter run`
3. **Test Google Sign-In**: Try signing in with Google
4. **Check logs**: Look for any remaining errors

## 🎯 **Expected Result**

After proper configuration:
- ✅ Google Sign-In popup appears
- ✅ User can select Google account
- ✅ Sign-in completes successfully
- ✅ User is redirected to home screen

## 🆘 **Still Having Issues?**

If you're still getting errors:
1. **Double-check SHA-1**: Make sure it's correct
2. **Verify package name**: Must match exactly
3. **Check google-services.json**: File should be valid JSON
4. **Clean rebuild**: Always clean before testing
5. **Check internet**: Ensure device has internet connection

---

**Note**: This error is very common and usually resolved by proper SHA-1 configuration and adding the correct `google-services.json` file.
