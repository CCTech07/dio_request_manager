# Dio Request Manager

**DioRequestManager** is a lightweight, easy-to-use Dart package for handling API requests using the Dio package. It supports GET, POST, PUT, and DELETE methods with token authentication.

## 📌 Features
✅ Simplifies API calls with Dio
✅ Supports authentication tokens
✅ Error handling for API failures
✅ Customizable token storage

## 📦 Installation
Add the package to your `pubspec.yaml`:
```yaml
dependencies:
  dio_request_manager:
    git: https://github.com/your-repo/dio_request_manager.git
```
Run:
```sh
flutter pub get
```

## 🚀 Usage
### 1️⃣ **Initialize API Manager**
```dart
import 'package:dio_request_manager/dio_request_manager.dart';

final apiManager = DioRequestManager(
  baseUrl: "https://your-api.com/",
  getToken: () async => "your_auth_token",
);
```

### 2️⃣ **Make API Requests**
```dart
Future<void> getPaymentMethods() async {
  final response = await apiManager.request(
    "/payment-methods",
    {},
    RequestType.get,
    useToken: true,
  );
  
  if (response.success) {
    print("Success: ${response.data}");
  } else {
    print("Error: ${response.message}");
  }
}
```

### 3️⃣ **Handling Errors**
```dart
try {
  final response = await apiManager.request("/user", {}, RequestType.get, useToken: true);
  if (!response.success) throw Exception(response.message);
} catch (e) {
  print("API Error: $e");
}
```

## 🛠 Custom Token Management
You can use `SharedPreferences` or any other method to manage tokens in your app:
```dart
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_token");
  }
}
```

## ✅ Contributing
Pull requests are welcome! If you find any issues, please report them.

## 📜 License
MIT License © 2025 CCTech
