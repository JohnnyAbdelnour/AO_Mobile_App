# Antoine Online App

This is a Flutter application for Antoine Online, an ecommerce website. The app is built using a clean architecture and communicates with the Magento 2 backend via REST APIs.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- An editor like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/antoine-online-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd antoine-online-app
   ```
3. Install the dependencies:
   ```bash
   flutter pub get
   ```

### Configuration

The app uses a `.env` file to manage environment-specific variables. Create a `.env` file in the root of the project and add the following:

```
MAGENTO_BASE_URL=https://www.antoineonline.com
EN_STORE_CODE=intr/en
FR_STORE_CODE=intr/fr
AR_STORE_CODE=intr/ar
```

### Running the App

To run the app in debug mode, use the following command:

```bash
flutter run
```

## Running Tests

To run the unit and widget tests, use the following command:

```bash
flutter test
```

## Project Structure

The project follows the clean architecture principles, with the code organized into three layers:

- **Data Layer**: This layer is responsible for all communication with the Magento 2 backend. It includes:
    - **API Client**: A `MagentoApiClient` that handles all HTTP requests and responses.
    - **Repositories**: Concrete implementations of the repositories defined in the domain layer.
    - **Data Models**: Plain Dart objects that represent the data structures of the Magento API.

- **Domain Layer**: This layer contains the core business logic of the application. It is independent of any other layer and includes:
    - **Use Cases**: These are the individual business actions that can be performed in the app.
    - **Repository Interfaces**: Abstract classes that define the contract for the data layer.

- **Presentation Layer**: This layer is responsible for the UI and state management. It includes:
    - **Screens**: The different screens of the app.
    - **Widgets**: Reusable UI components.
    - **State Management**: We use [Riverpod](https://riverpod.dev/) for state management. The providers are defined in the `providers` directory.
