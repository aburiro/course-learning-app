# Kr Learning

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?style=for-the-badge&logo=flutter" alt="Flutter Version">
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-orange?style=for-the-badge" alt="Platform">
</p>

> A modern Flutter-based course learning application with API integration for loading and displaying course content.

## 📱 Overview

Kr Learning is a feature-rich mobile application built with Flutter that enables users to browse and learn from various courses. The app integrates with a RESTful API to fetch course data and provides a seamless learning experience on both Android and iOS platforms.

## ✨ Features

- **Course Catalog** - Browse available courses with details like instructor, rating, and student count
- **Video Learning** - Integrated video player for course content
- **Course Details** - Comprehensive course information including description, pricing, and lesson count
- **Responsive Design** - Beautiful UI that works on various screen sizes
- **Cross-Platform** - Runs smoothly on both Android and iOS

## 🛠️ Technical Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter |
| Language | Dart |
| State Management | Provider (or your state's solution) |
| HTTP Client | Dio/http |
| Architecture | Clean Architecture |

## 📋 Prerequisites

Before building the project, ensure you have the following installed:

- **Flutter SDK** (version 3.x or higher)
- **Dart SDK** (comes with Flutter)
- **Android SDK** (for Android builds)
- **Xcode** (for iOS builds on macOS)

## 🚀 Getting Started

### 1. Clone the Repository

```
bash
git clone <repository-url>
cd kr_learning
```

### 2. Install Dependencies

```
bash
flutter pub get
```

### 3. Configure API Endpoint

Update the API endpoint in the following file:

- **`lib/services/api_service.dart`**
  - Modify `ApiService.coursesEndpoint` to point to your API

#### Expected JSON Response Format

The API should return course data in one of these formats:

**Format 1: Array**
```
json
[
  {
    "id": 1,
    "title": "Flutter Basics",
    "instructor": "Jane Doe",
    "image": "FB",
    "lessons": 12,
    "rating": 4.7,
    "students": 12000,
    "price": 99,
    "videoId": "aqz-KE-bpKQ",
    "description": "Learn Flutter from scratch"
  }
]
```

**Format 2: Object with courses key**
```
json
{
  "courses": [
    {
      "id": 1,
      "title": "Flutter Basics",
      "instructor": "Jane Doe",
      "image": "FB",
      "lessons": 12,
      "rating": 4.7,
      "students": 12000,
      "price": 99,
      "videoId": "aqz-KE-bpKQ",
      "description": "Learn Flutter from scratch"
    }
  ]
}
```

### 4. Build the APK

#### Android (Release)
```
bash
flutter build apk --release
```

#### Android (Debug)
```
bash
flutter build apk --debug
```

#### iOS (Requires macOS)
```
bash
flutter build ios
```

> **Note:** If you're using Firebase on iOS, ensure you've added `ios/Runner/GoogleService-Info.plist` before building for iOS.

## 📁 Project Structure

```
kr_learning/
├── lib/
│   ├── main.dart              # Application entry point
│   ├── services/              # API and external services
│   ├── models/               # Data models
│   ├── screens/              # UI screens
│   ├── widgets/              # Reusable widgets
│   └── utils/                # Utility functions
├── ios/                      # iOS platform files
├── android/                  # Android platform files
├── test/                     # Unit and widget tests
└── pubspec.yaml              # Project dependencies
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter API Reference](https://api.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

---

<p align="center">Made with ❤️🤩🤗😂  using Flutter</p>
