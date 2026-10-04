# Flutter News Reader App

A feature-rich, production-ready news application built with Flutter. This project demonstrates modern Flutter development practices, including a strict Clean Architecture approach, reactive state management, local data persistence, and advanced routing.

## 🚀 Features

* **Real-time News Feed:** Fetches and displays the latest articles using a remote Dio client.
* **Offline Bookmarks:** Save articles for later reading using local storage. 
* **Smart Search:** Search for specific news topics with a persistent recent search history.
* **Architecture:** Feature-first Clean Architecture separating Core, Data, Domain, and Presentation layers.
* **Authentication Flow:** Simulated login/logout functionality protected by GoRouter redirect guards.

## 🛠 Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **State Management:** [Riverpod](https://riverpod.dev/) 
* **Network & API:** [Dio](https://pub.dev/packages/dio) 
* **Local Storage:** [Hive](https://docs.hivedb.dev/) (Local datasources)
* **Routing:** [GoRouter](https://pub.dev/packages/go_router) 
* **Data Modeling:** [Freezed](https://pub.dev/packages/freezed) & JSON Serializable

## 📂 Project Structure

The codebase is strictly organized into four main layers to ensure high scalability and separation of concerns:

### 1. Core Layer
Contains app-wide configurations and utilities.
* `lib/core/constants/` - Application constants and config[cite: 2].
* `lib/core/error/` - Failure models and error-handling logic (`failures.dart`)[cite: 2].
* `lib/core/network/` - API setup and interceptors (`dio_client.dart`)[cite: 2].
* `lib/core/routing/` - GoRouter configuration and guards (`app_router.dart`)[cite: 2].
* `lib/core/theme/` - Global theme definitions (`theme_provider.dart`)[cite: 2].

### 2. Data Layer
Handles all data retrieval and modeling.
* `lib/data/datasources/` - Contains implementations for `local` (Hive) and `remote` (Dio) data fetching[cite: 3].
* `lib/data/models/` - Data models generated using Freezed (`article_model.dart`, `article_model.freezed.dart`, `article_model.g.dart`)[cite: 3].
* `lib/data/repositories/` - Concrete implementations of the domain repository interfaces (`news_repository_impl.dart`)[cite: 3].

### 3. Domain Layer
The core business logic of the application.
* `lib/domain/repositories/` - Abstract repository interfaces defining data operations (`news_repository.dart`)[cite: 4].

### 4. Presentation Layer
Handles the UI and State Management, broken down by feature.
* `lib/presentation/features/auth/` - Authentication screens and user state providers[cite: 4].
* `lib/presentation/features/bookmarks/` - Saved articles screen and bookmark logic[cite: 4].
* `lib/presentation/features/home/` - Main news feed and article detail screens[cite: 5].
* `lib/presentation/features/search/` - Search interface and persistent history logic[cite: 5].
* `lib/presentation/widgets/` - Reusable UI components like `article_card.dart` and `custom_drawer.dart`[cite: 5].

## ⚙️ Getting Started

### Prerequisites
* Flutter SDK (Latest stable version)
* Android Studio / VS Code

### Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/yourusername/flutter_news_app.git](https://github.com/yourusername/flutter_news_app.git)
   cd flutter_news_app
