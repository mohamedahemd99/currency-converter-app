# currency_converter

#### A cross platform app using the flutter framework that utilizes the freeecurrencyapi to display available currencies, convert between them, and display only one last day because api for the last 7 days historical data is in paid plan.

## How to build & Run

    - You need to obtain your api key from [freecurrencyapi](https://app.freecurrencyapi.com/)
    - Clone the github repository
    - create the file .env.dev and the apikey like <APIKEY=your api key> 
    - flutter pub get 
    - Run `flutter run .

## App architecture

    - Adapts clean architecture for its structure.
    -Justification for Choosing Clean Architecture(Scalability,Maintainability,Testability,Separation of Concerns,Dependency Injection and Flexibility in Frameworks)
    - Uses the Repository pattern as a coordinator between the various data sources
    - flutter_bloc is used for managing the app state.
    - get_it is used as the Dependency Injection library. It creates and manages all dependencies across all layers.
    - BlocProviders are used to provide widget tree scoped cubits and make use of their mechanism of closing the cubits. 

## Local Storage

    - SharedPreferences is used for storing simple currencies data securely, such as settings and preferences. .
    - I chose SharedPreferences because it is straightforward, lightweight, and widely supported across platforms.
    - SharedPreferences provided a more suitable balance for storing small, non-complex data, which meets the app's needs efficiently.
    - I used realm becuase it the next best database from speed and efficiency points of view.
    -  SharedPreferences allows easy access and is faster for storing and retrieving small amounts of data..

## Images

    - I used Flagcdn for the flags, which provides an efficient way to get country flags via URLs. For displaying these flags.
    -I used CachedNetworkImage instead of flutter_svg or jovial_svg. The reason for this is that CachedNetworkImage handles caching and displaying images from URLs effectively,ensuring better performance.
    - This approach also improves the app's user experience by reducing loading times for images, especially when there are multiple flag images being displayed at once.

## Unit Testing

    - You need to run `flutter pub run realm install` before running the tests.
    - the UI Managers (Bloc) are unit tested
    - I avoided testing classes and functions that just forward calls to their dependencies
    - Repository is tested with mocked dependencies.
 
## Getting Started with Flutter

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
