# Currency Converter App

This is a Flutter-based currency converter application that allows users to convert between different currencies. The app fetches real-time currency conversion rates and supports adding multiple converters for different target currencies.

## Features

- Real-time currency conversion rates.
- Add multiple converters to convert to different currencies simultaneously.
- Save and load converter settings using SharedPreferences.
- User-friendly UI with dropdowns for currency selection.

## Architecture

The application follows a simple yet effective architecture that separates concerns and ensures maintainability:

1. **Model**: The `CurrencyData` and `ConverterTileModel` classes represent the data structures used in the app.
2. **Service**: The `CurrencyService` class handles API calls to fetch currency data.
3. **UI**: The main UI components are implemented in the `CurrencyConverterPage` class and custom widgets like `DropdownRow` and `ConverterTile`.
4. **Utilities**: Utility functions and widgets are placed under the `utils` directory for modularity and reusability.

The architecture ensures a clear separation of data handling, business logic, and UI, making the app easier to maintain and extend.
