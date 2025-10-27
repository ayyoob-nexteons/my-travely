# My Travely - Flutter MVVM App

A modern Flutter application built with MVVM architecture, featuring Google Sign-In, Material 3 design, and a clean, scalable folder structure.

## 🚀 Features

- **MVVM Architecture**: Clean separation of concerns with View, ViewModel, and Model layers
- **Google Sign-In**: Authentication without Firebase integration
- **Material 3 Design**: Modern, beautiful UI following Material Design 3 guidelines
- **Session Persistence**: User sessions saved locally using SharedPreferences
- **Centralized Navigation**: Clean routing system with navigation utilities
- **Reusable Components**: Common widgets for buttons and text fields
- **Form Validation**: Comprehensive input validation
- **Responsive Design**: Works across different screen sizes

## 📱 Screens

1. **Splash Screen**: Logo-based screen with 3-second delay
2. **Login Screen**: Email/password login with Google Sign-In option
3. **Signup Screen**: User registration with validation
4. **Home Screen**: User profile display with logout functionality

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── routes/
│   │   ├── app_routes.dart
│   │   └── route_generator.dart
│   ├── navigation/
│   │   └── navigation_utils.dart
│   ├── widgets/
│   │   ├── common_button.dart
│   │   └── common_text_field.dart
│   └── utils/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── constants.dart
│       └── common_utils.dart
├── features/
│   ├── splash/
│   │   ├── view/splash_screen.dart
│   │   ├── view_model/splash_view_model.dart
│   │   └── model/splash_model.dart
│   ├── login/
│   │   ├── view/login_screen.dart
│   │   ├── view_model/login_view_model.dart
│   │   └── model/login_model.dart
│   ├── signup/
│   │   ├── view/signup_screen.dart
│   │   ├── view_model/signup_view_model.dart
│   │   └── model/signup_model.dart
│   └── home/
│       ├── view/home_screen.dart
│       └── view_model/home_view_model.dart
└── main.dart
```

## 🛠️ Setup Instructions

### Prerequisites

1. **Install Flutter**: Download and install Flutter SDK from [flutter.dev](https://flutter.dev)
2. **Install Dart**: Flutter includes Dart SDK
3. **IDE**: Android Studio, VS Code, or IntelliJ IDEA with Flutter plugins

### Installation

1. **Clone/Download** this project
2. **Open terminal** in the project directory
3. **Get dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

### Google Sign-In Setup

To enable Google Sign-In functionality:

1. **Create a Google Cloud Project**:
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Create a new project or select existing one

2. **Enable Google Sign-In API**:
   - Navigate to "APIs & Services" > "Library"
   - Search for "Google Sign-In API" and enable it

3. **Create OAuth 2.0 Credentials**:
   - Go to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "OAuth 2.0 Client IDs"
   - Configure for Android/iOS as needed

4. **Update Configuration**:
   - For Android: Add SHA-1 fingerprint to OAuth client
   - For iOS: Add bundle identifier to OAuth client

## 📦 Dependencies

- `flutter`: SDK
- `google_sign_in: ^6.1.0`: Google Sign-In authentication
- `shared_preferences: ^2.2.0`: Local storage for session persistence
- `provider: ^6.1.2`: State management

## 🎨 Design System

### Colors
- Primary: `#6750A4` (Material 3 Purple)
- Surface: `#FFFBFE` (Light background)
- Error: `#BA1A1A` (Material 3 Red)

### Typography
- Headlines: 24-32px, various weights
- Body: 14-16px, regular weight
- Labels: 11-14px, medium weight

### Components
- **CommonButton**: Reusable button with loading states
- **CommonTextField**: Input field with validation and password toggle

## 🔧 Configuration

### App Constants
- App name: "My Travely"
- Splash duration: 3 seconds
- Password requirements: 8-50 characters
- Name requirements: 2-50 characters

### Navigation Routes
- `/` - Splash screen
- `/login` - Login screen
- `/signup` - Signup screen
- `/home` - Home screen

## 🚀 Running the App

1. **Development**:
   ```bash
   flutter run
   ```

2. **Release Build**:
   ```bash
   flutter build apk  # Android
   flutter build ios  # iOS
   ```

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔍 Testing

The app includes basic validation and error handling. For production use, consider adding:

- Unit tests for ViewModels
- Widget tests for UI components
- Integration tests for user flows
- Error logging and analytics

## 📄 License

This project is created for educational purposes. Feel free to use and modify as needed.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For issues or questions:
1. Check the Flutter documentation
2. Review the code comments
3. Test with different devices/screen sizes

---

**Happy Coding! 🎉**