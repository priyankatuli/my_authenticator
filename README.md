# 🔐 Authenticator App
A Flutter-based Authenticator application that generates Time-based One-Time Passwords (TOTP) for secure two-factor authentication (2FA).

## ⚙️ Installation
### Git Clone
```
git clone https://github.com/priyankatuli/my_authenticator.git
```
### Install dependencies
```
flutter pub get
```
### Run the App
```
flutter run
```
### Build Apk
```
flutter build apk --release
```

## ✨ Features
- Add accounts via QR code scanning
- Securely store secrets using encrypted storage
- Generate 6-digit TOTP codes (RFC 6238 standard)
- Real-time countdown synced with Unix time
- Auto-refresh OTP every 30 seconds
- Clean and user-friendly UI
- Works completely offline after setup

## 🛠️ Tech Stack
- Flutter
- Dart
- GetX - State Management & Navigation
- Secure Storage - encrypted secret storage

## 📦 Packages Used
- get
- flutter_secure_storage
- mobile_scanner
- otp

