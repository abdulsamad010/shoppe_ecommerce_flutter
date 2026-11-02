# SHOPPE — Flutter E-Commerce Application

A modern Flutter e-commerce application built with Firebase and the BLoC state-management pattern. Shoppe brings product discovery, category browsing, search, product variations, favourites, cart management, and other shopping-related workflows together in a mobile shopping experience.

> **Project note:** This README describes implementation details confirmed for `shoppe_ecommerce_flutter`. It does not claim unverified integrations such as a specific online payment gateway, shipment-tracking provider, or production deployment.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Implemented Functionality](#implemented-functionality)
3. [Technology Stack](#technology-stack)
4. [Application Architecture](#application-architecture)
5. [State Management](#state-management)
6. [Firebase and Firestore](#firebase-and-firestore)
7. [Getting Started](#getting-started)
8. [Firebase Configuration](#firebase-configuration)
9. [Run the Application](#run-the-application)
10. [Build a Release APK](#build-a-release-apk)
11. [Important Implementation Notes](#important-implementation-notes)
12. [Project Structure](#project-structure)
13. [Troubleshooting](#troubleshooting)
14. [Future Improvements](#future-improvements)
15. [Contributions](#contributions)

---

## Project Overview

**Shoppe** is a Flutter-based e-commerce application that uses Firebase services as its backend and BLoC for application state management.

The application includes shopping workflows such as:

- Browsing products and categories.
- Exploring product details and available variations.
- Searching for products and maintaining search history.
- Managing favourite products.
- Selecting product quantity, size, and colour.
- Adding and updating products in the shopping cart.
- Accessing shopping-related information such as flash sales, vouchers, and delivery methods.
- Managing user-related information and order data through Firebase.

The interface is built with Flutter's widget system and uses responsive sizing and custom typography packages.

---

## Implemented Functionality

The following functionality reflects the application code and Firebase operations confirmed during development.

### 1. Product Browsing

- Retrieves product data from the Cloud Firestore `products` collection.
- Displays product information such as name, image, price, available quantity, sizes, and colours.
- Supports product discovery through the shop interface.
- Includes product sections such as new arrivals, top products, and flash-sale products.
- Provides product-detail and product-variation workflows.

### 2. Categories and Filtering

- Supports product categories and subcategories.
- Includes category, subcategory, and gender-based filtering.
- Provides category-oriented product browsing.

### 3. Product Search

- Allows users to search for products using text.
- Uses the BLoC event/state flow to process search requests and update displayed results.
- Maintains search-history data.
- Displays a no-matching-product message when a search returns no results.

### 4. Product Variations

The product-variation workflow supports selection of:

- Quantity.
- Size.
- Colour.

The selected values are maintained in the application's `cartProgress` state and are used as part of the cart workflow.

**Important distinction:** A product's Firestore `quantity` represents its available stock, while `cartProgress['quantity']` represents the quantity selected by the user. These are separate values.

### 5. Shopping Cart

The cart workflow supports:

- Adding products to the cart.
- Updating cart information.
- Removing cart items.
- Maintaining product variation information such as size and colour.
- Retrieving user cart data from Firestore.

Cart-related data is associated with the signed-in user's record in `users_data`.

### 6. Favourites

- Supports adding products to favourites.
- Supports removing products from favourites.
- Retrieves and updates favourite-product data through the Firebase data layer.

### 7. Flash Sales and Product Sections

- Retrieves flash-sale information from Firestore.
- Supports product sections such as top products, new arrivals, and flash sales.
- Includes See All navigation for these product sections.

### 8. Vouchers and Delivery Information

The Firebase data layer includes operations for:

- Retrieving voucher information.
- Retrieving delivery methods.

The availability and presentation of these options depend on the corresponding application screens and data.

### 9. Orders and Reviews

The data layer includes operations for:

- Storing order information.
- Retrieving order-related data.
- Updating product stock when an order is stored.
- Managing product reviews and ratings.

A particular payment gateway or third-party shipment-tracking integration is not specified here because it has not been confirmed.

### 10. User Account and Profile

The application uses Firebase Authentication for authentication-related operations, including access to the current user and account email/password workflows.

The Firebase data layer also contains operations related to:

- User profile information.
- Address and contact information.
- Account deletion.

Email changes may require the user to complete Firebase's email-verification process.

### 11. Share Functionality

The application uses the `share_plus` package to open the platform's native sharing interface and share text.

A product name, price, or product URL can be included in the shared text when available.

---

## Technology Stack

| Technology / Package | Purpose |
|---|---|
| Flutter | Cross-platform application development |
| Dart | Application programming language |
| Firebase Core | Firebase initialization |
| Firebase Authentication | User authentication |
| Cloud Firestore | Cloud database and application data |
| flutter_bloc | BLoC-based state management |
| flutter_screenutil | Responsive sizing |
| google_fonts | Typography and font styling |
| share_plus | Native platform sharing |

Exact package versions are maintained in `pubspec.yaml`.

---

## Application Architecture

The application follows a feature-oriented Flutter structure with a central BLoC state-management layer and a Firebase data-access layer.

### Presentation Layer

The presentation layer contains UI screens and reusable widgets.

Examples confirmed in the application include:

- `SearchScreen`
- `ShopScreen`
- `ProductVariationsScreen`
- `NewItemsCard`

### BLoC Layer

The central application BLoC coordinates application events, state updates, and data operations.

The main BLoC-related files include:

- `app_bloc.dart`
- `app_event.dart`
- `app_state.dart`

The application uses:

- `AppBloc` to handle application events.
- `AppEvent` classes to represent user actions and requested operations.
- `AppState` to expose current application data to the UI.
- `BlocBuilder` and `BlocConsumer` to rebuild UI and respond to state changes.

### Firebase Data Layer

The `FoodData` data-access class contains Firestore operations for products and other application data.

This separation allows UI screens to dispatch events rather than directly performing every database operation.

---

## State Management

Shoppe uses the BLoC pattern through the `flutter_bloc` package.

A typical interaction follows this sequence:

1. The user performs an action in the UI.
2. The UI dispatches an event to `AppBloc`.
3. `AppBloc` processes the event and performs the required data operation.
4. The BLoC emits an updated `AppState`.
5. Widgets listening to the BLoC rebuild using the updated state.

The central `AppState` maintains application data including:

- Products.
- Categories and subcategories.
- Cart items.
- Temporary cart-selection progress.
- Favourite products.
- Search results and search history.
- Flash-sale information.
- Orders.
- Delivery information.
- Vouchers.
- User and profile-related information.

### State Preservation Consideration

When creating a new `AppState` inside a BLoC event handler, existing state fields that should remain available must be passed into the new state.

For example, an event that updates an unrelated field should preserve `cartProgress` if the current product-selection workflow must remain active:

```dart
emit(AppState(
  // Preserve the other required state fields.
  cartProgress: state.cartProgress,
  // Include the remaining state values.
));
```

If `cartProgress` is omitted, the `AppState` constructor's default values are used. In the current implementation, those defaults contain null values for `productId`, `quantity`, `size`, and `color`.

This is important when debugging product-variation and cart-quantity behaviour.

---

## Firebase and Firestore

Shoppe uses Firebase as its backend.

### Firebase Services

- **Firebase Authentication:** Handles authentication-related operations.
- **Cloud Firestore:** Stores and retrieves product, user, shopping, and other application data.
- **Firebase Core:** Initializes Firebase in the Flutter application.

### Firestore Collections Used

The following collection names are referenced by the application's data-access implementation:

| Collection | Purpose |
|---|---|
| `products` | Product records and stock information |
| `users_data` | User-related shopping and profile data |
| `app_events` | Application event data, including flash-sale information |
| `delivery_methods` | Delivery-method information |
| `voucher` | Voucher information |
| `app_orders` | Order records |

Flash-sale data is accessed through the `app_events/flash_sale` document path.

The user's cart and related data are accessed through the corresponding `users_data/{uid}` document.

### Product Data

Product records are read from the `products` collection. The product model and UI use fields such as product name, image URL, price, quantity, sizes, and colours.

Make sure Firestore document field names and value types match the fields expected by the application's product model.

### User Data

User-specific information is associated with the authenticated user's Firebase UID.

Some update operations require the relevant `users_data/{uid}` document to exist. If the document has not been created, a Firestore `.update()` operation can fail. Create or initialize the user document as part of the appropriate account setup flow, or use a write operation that creates the document when that is intended.

### Security

Before deploying the application:

- Configure Firestore Security Rules.
- Restrict user-specific documents to their authenticated owner.
- Validate data before allowing users to update products, cart items, or orders.
- Do not use unrestricted test rules in a production application.
- Never commit private service-account credentials or secret keys to a public repository.

---

## Getting Started

### Prerequisites

Install the following tools:

- Flutter SDK.
- Dart SDK (included with Flutter).
- Android Studio or Visual Studio Code.
- Android SDK and an Android emulator, or a physical Android device.
- A Firebase project.
- Git.

Verify your Flutter installation:

```bash
flutter doctor
```

### Clone the Repository

Replace the placeholder with the actual repository URL:

```bash
git clone <YOUR_REPOSITORY_URL>
```

Open the project directory:

```bash
cd shoppe_ecommerce_flutter
```

### Install Dependencies

```bash
flutter pub get
```

---

## Firebase Configuration

The project uses Firebase configuration generated for the Flutter application.

### 1. Create a Firebase Project

1. Open the Firebase Console: https://console.firebase.google.com/
2. Create a Firebase project or select an existing project.
3. Add the Android application using the Android application ID configured in the project.
4. Enable the Firebase services required by the application.

### 2. Configure FlutterFire

If FlutterFire CLI is not configured on your development machine, install it:

```bash
dart pub global activate flutterfire_cli
```

Run the configuration command from the project root:

```bash
flutterfire configure
```

Select the Firebase project and the platforms required by your application.

This process generates or updates the Firebase configuration file, commonly:

```text
lib/firebase_options.dart
```

The application should initialize Firebase with the generated configuration before using Firebase services.

### 3. Enable Firebase Services

In the Firebase Console:

- Enable **Authentication** and configure the sign-in providers used by the application.
- Create a **Cloud Firestore** database.
- Add the required collections and documents.
- Configure Firestore Security Rules for authenticated access.

Collection names and document fields must match the application's data-access code.

---

## Run the Application

Start an Android emulator or connect a physical device.

Check connected devices:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

For development, hot reload can be used after code changes by pressing `r` in the running Flutter terminal.

---

## Build a Release APK

To generate a standard release APK:

```bash
flutter clean
flutter pub get
flutter build apk --release
```

After a successful build, the APK is generated at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

### Split APKs by Architecture

To generate separate APKs for supported Android CPU architectures:

```bash
flutter build apk --release --split-per-abi
```

The generated APK files are placed in:

```text
build/app/outputs/flutter-apk/
```

### Release Signing

For distribution outside local testing, configure Android release signing with your own keystore and keep the keystore and passwords private. Do not commit signing credentials to GitHub.

---

## Important Implementation Notes

### Product Stock vs. Selected Cart Quantity

These two values have different meanings:

- `product.quantity`: available stock for a product.
- `cartProgress['quantity']`: quantity currently selected by the user.

A product can have valid stock in Firestore while the temporary cart-selection quantity is still null if it has not been initialized or if a newly emitted `AppState` resets `cartProgress`.

### Product Variations

The variation screen relies on the selected product's available sizes and colours. Make sure the relevant lists are populated before accessing their first elements or building list items.

The item count for a size list must be based on the product's `sizes` list, not its `colors` list.

### User Document Updates

Firestore `.update()` requires an existing document. If user-specific data is missing, initialize the document before attempting to update it.

### Email Verification

Firebase's `verifyBeforeUpdateEmail()` flow sends a verification request. The email address change is not necessarily complete immediately after calling the method.

### Native Plugins

After adding a native Flutter plugin such as `share_plus`, fully stop and rebuild the application. Hot reload alone does not register a newly added native plugin.

For example:

```bash
flutter clean
flutter pub get
flutter run
```

---

## Project Structure

The following is a high-level guide to confirmed areas of the project. Refer to the actual repository for the complete directory and file layout.

```text
shoppe_ecommerce_flutter/
|
├── android/
├── ios/
├── lib/
│   |
│   ├── core/
│   │   ├── bloc/
│   │   │   └── app_bloc/
│   │   │       ├── app_bloc.dart
│   │   │       ├── app_event.dart
│   │   │       └── app_state.dart
│   │   ├── colors/
│   │   └── text_styles/
│   │
│   ├── presentation/
│   │   ├── core/
│   │   │   └── widgets/
│   │   │       └── new_items_card.dart
│   │   └── features/
│   │       └── shop/
│   │           └── shop_screen.dart
│   │
│   └── firebase_options.dart
│
├── assets/
├── test/
├── pubspec.yaml
└── README.md
```

This is an illustrative overview of known project areas, not a complete generated directory listing. Keep this section synchronized with the actual repository when adding or moving files.

---

## Troubleshooting

### 1. MissingPluginException

Example:

```text
MissingPluginException(
  No implementation found for method share
)
```

**Possible solution:**

```bash
flutter clean
flutter pub get
flutter run
```

Fully stop the application before running it again.

### 2. Firestore Document Not Found During Update

An `.update()` call fails when the target document does not exist.

**Check:**

- Whether the authenticated user's UID is correct.
- Whether `users_data/{uid}` exists.
- Whether the account initialization flow creates the required document.

### 3. Null Cart Selection Values

If a comparison involving `cartProgress['quantity']` fails because the value is null, inspect the state lifecycle.

**Check:**

- Whether the selection is initialized when opening the product details or variation screen.
- Whether another BLoC event emits a new `AppState` without preserving `cartProgress`.
- Whether the product's size and colour lists contain valid values.

### 4. Firebase Initialization Issues

**Check:**

- Whether `firebase_options.dart` exists and is up to date.
- Whether Firebase is initialized before Firebase services are used.
- Whether the Android application ID matches the Firebase Android app configuration.
- Whether the required Firebase services are enabled.

### 5. Release APK Build Issues

Run:

```bash
flutter doctor
flutter clean
flutter pub get
flutter build apk --release
```

Read the first actual build error in the terminal output; later errors may be consequences of the initial failure.

---

## Future Improvements

Potential areas for further development include:

- Improving form validation and error handling.
- Adding automated unit and widget tests.
- Improving loading, empty, and error states.
- Reviewing Firestore Security Rules and data validation.
- Improving cart-state consistency across BLoC events.
- Adding product deep links for sharing.
- Completing release signing and deployment preparation.
- Adding documentation for the exact Firestore document schemas.

These are suggestions for future work, not claims that the features are already implemented.

---

## Contributions

Before submitting changes:

1. Keep the existing BLoC architecture consistent.
2. Preserve required `AppState` fields when emitting new states.
3. Keep Firestore field names aligned with the data models.
4. Test product browsing, search, variations, favourites, and cart workflows after making related changes.
5. Avoid committing Firebase secrets, signing keys, or private credentials.

---

## License

Add the appropriate license information for this repository before redistributing or publishing the project.

---

**Built with Flutter, Dart, Firebase, and BLoC.**
