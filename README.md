# 📰 Flutter News App - Professional News Mobile Application

<p align="center">
  <b>A secure, high-performance, and cross-platform news application built with Flutter and Dart, strictly following Clean Architecture principles.</b>
</p>

---

## 📱 About the Project
**Flutter News App** is a modern mobile solution designed to deliver a seamless news-reading experience. It emphasizes scalable code architecture, advanced network logging, secure environment management, and optimized UI performance.

---

## ✨ Key Features
* **Clean Architecture:** Strictly separated layers (Data, Domain, Presentation) for high maintainability, testability, and long-term scalability.
* **Advanced Networking:** Powered by **Dio** for robust HTTP requests, custom interceptors, and error handling.
* **Request Monitoring & Logging:** Integrated **PrettyDioLogger** for clear, structured debugging of API requests and responses in the console.
* **Secure Configuration:** Uses `flutter_dotenv` to securely manage sensitive environment variables and API keys.
* **Smooth Pagination & Data Loading:** Efficient handling of large datasets, asynchronous operations, and seamless scrolling.
* **Optimized Image Caching:** Utilizes `cached_network_image` for fast caching and smooth UI performance.

---

## 🛠️ Tech Stack & Dependencies
* **[Flutter](https://flutter.dev/)** - The framework for building multi-platform applications.
* **[Dart](https://dart.dev/)** - The programming language powering the app logic.
* **Dio (`dio`)** - Powerful HTTP client for Dart and Flutter.
* **Pretty Dio Logger (`pretty_dio_logger`)** - Dio interceptor for logging network requests.
* **Flutter Dotenv (`flutter_dotenv`)** - Load secret configuration from a .env file.
* **Cached Network Image (`cached_network_image`)** - Flutter library to load and cache network images.

---

## 📂 Project Structure
```text
lib/
│
├── core/                  # Core configurations, network clients, and utilities
├── data/                  # Data layer (Models, repositories implementation, data sources)
├── domain/                # Domain layer (Entities, use cases, repository contracts)
├── presentation/          # Presentation layer (UI screens, widgets, and state management)
└── main.dart              # Application entry point
