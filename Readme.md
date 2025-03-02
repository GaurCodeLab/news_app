# News App

A Flutter-based news application that fetches top headlines using GetX for state management and follows the MVVM architecture. The app supports search functionality, pull-to-refresh, animations, and web compatibility.

## Features

- **MVVM Architecture**: Ensures separation of concerns and maintainability.
- **GetX for State Management**: Efficient state management without unnecessary rebuilds.
- **News API Integration**: Fetches real-time news using an external API.
- **Search Functionality**: Allows users to search articles dynamically.
- **Pull-to-Refresh**: Provides a smooth refresh experience.
- **Web Support**: Fully functional on web platforms.
- **Animations & UI Enhancements**: Includes a splash screen and smooth UI interactions.

## Screenshots

![Home Screen](screenshots/home.png)
![Search Feature](screenshots/search.png)
![Article Details](screenshots/details.png)

## Installation

### Prerequisites
Ensure you have Flutter installed. You can check by running:
```sh
flutter --version
```

### Clone the Repository
```sh
git clone https://github.com/yourusername/news_app.git
cd news_app
```

### Install Dependencies
```sh
flutter pub get
```

### Run the App
For mobile:
```sh
flutter run
```
For web:
```sh
flutter run -d chrome
```

## Environment Variables
This project requires an API key. Since `flutter_dotenv` is not used, manually add your API key inside `news_service.dart`:
```dart
final String _apiKey = 'YOUR_API_KEY_HERE';
```
For production, consider using a secure method like Firebase Remote Config or a backend proxy.

## Folder Structure
```
lib/
│── main.dart                 # Entry point of the application
│── models/
│   ├── news_article.dart      # Model for news article
│── services/
│   ├── news_service.dart      # Handles API requests
│── viewmodels/
│   ├── news_view_model.dart   # Manages app logic using GetX
│── views/
│   ├── home_view.dart         # Home screen with news list
│   ├── details_view.dart      # Article details page
│── routes/
│   ├── app_routes.dart        # Manages navigation
```

## Known Issues
- CORS issues on web (use a proxy server for proper API calls).
- Ensure API key is valid before running.

## Contributing
Feel free to fork and submit pull requests to enhance this project!

## License
This project is licensed under the MIT License.

---

### Contact
If you have any questions, reach out to me at [gaurcodelab@gmail.com].
