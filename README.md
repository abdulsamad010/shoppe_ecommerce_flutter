# 🛍️ Shoppe – Flutter E-Commerce Application

<p align="center">
  <strong>A Modern E-Commerce Experience Built with Flutter, Firebase, BLoC & Clean Architecture</strong>
</p>

<p align="center">
  Discover products, manage your shopping cart, explore categories, and stay updated with notifications.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Framework-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-Language-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-Backend-FFCA28?logo=firebase&logoColor=black" />
  <img src="https://img.shields.io/badge/BLoC-State%20Management-6C63FF" />
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white" />
</p>

---

## 📖 About the Project

**Shoppe** is a Flutter-based e-commerce application developed using Dart, Firebase, and the BLoC state-management pattern.

The application provides an organized shopping experience with features such as product browsing, category filtering, product search, product variations, favourites, cart management, order-related workflows, and user profile management.

Firebase services provide authentication, cloud-based data storage, and push notification capabilities.

The project follows a layered structure that separates data operations, domain components, and presentation logic to support maintainability and future development.

---

## ✨ Key Features

### 🛒 Shopping & Product Discovery

- Browse available products.
- Explore product categories and subcategories.
- View product details.
- Discover new arrivals and top products.
- Explore flash-sale products.
- Filter products by category, subcategory, and gender.
- Search products using text queries.
- Maintain search history.

### 🎨 Product Variations

- Select product quantities.
- Choose available sizes.
- Select product colours.
- Manage temporary product-selection information.

### ❤️ Wishlist & Shopping Cart

- Add products to favourites.
- Remove products from favourites.
- Add products to the shopping cart.
- Update cart information.
- Remove cart items.
- Maintain selected product variations.

### 👤 Authentication & Profile

- Firebase Authentication integration.
- Login and signup workflows.
- Password-related account operations.
- User profile management.
- Profile settings.
- Address and contact information management.

### 📦 Orders & Reviews

- Store and retrieve order information.
- Access order-related information.
- Update product stock when an order is stored.
- Submit product ratings and reviews.
- Manage order receiving and review workflows.

### 🔔 Push Notifications

Integrated **Firebase Cloud Messaging (FCM)** to support notifications across different application states.

| Application State | Notification Handling |
|---|---|
| Foreground | Displays notification information through an in-app SnackBar |
| Background | Supports system notifications |
| Terminated | Supports system notifications when the user opens the app from a notification |

Additional notification functionality:

- Requests notification permission.
- Retrieves the device's FCM registration token.
- Handles foreground messages.
- Registers a background message handler.
- Handles notification interactions.
- Processes initial messages when launching through a notification.

*Note: Background and terminated notification display requires an appropriately configured FCM notification payload and platform configuration. FCM integration alone does not automatically trigger notifications when Firestore data changes.*

### 📤 Product Sharing

- Uses the `share_plus` package.
- Opens the device's native sharing interface.
- Supports sharing product-related information.

---

## 🧰 Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform application development |
| Dart | Programming language |
| Firebase Core | Firebase initialization |
| Firebase Authentication | User authentication |
| Cloud Firestore | Cloud database |
| Firebase Cloud Messaging | Push notifications |
| flutter_bloc | State management |
| flutter_screenutil | Responsive UI sizing |
| google_fonts | Custom typography |
| share_plus | Native sharing functionality |

---

## 🏗️ Project Architecture

Shoppe follows a layered project structure that separates data access, domain components, and presentation logic.

### 1. Data Layer

Located in `lib/data/`.

Responsible for handling application data operations.

Main components:

- **Datasources:** Firebase and other data-access operations.
- **Models:** Application data models.
- **Repositories:** Repository implementations for data operations.

The `FoodData` class handles Firestore-related operations, while `FoodRepositoryImpl` provides the repository implementation.

### 2. Domain Layer

Located in `lib/domain/`.

Provides a dedicated layer for domain-related application components and business logic.

### 3. Presentation Layer

Located in `lib/presentation/`.

Contains the application's UI, state management, reusable widgets, and feature-specific screens.

It includes:

- Core application components.
- BLoC state management.
- Notification service.
- Shared colours and text styles.
- Reusable widgets.
- Feature-specific screens and workflows.

### 4. State Management

The application uses the BLoC pattern through the `flutter_bloc` package.

It includes:

- `AppBloc` for centralized application-level state management.
- `AuthBloc` for authentication-related operations.
- `ProfileBloc` for profile-related operations.
- `SignupBloc` for signup-related operations.

The application uses `BlocBuilder` and `BlocConsumer` to manage UI updates and respond to state changes.

### Application Workflow

```text
             User Interaction
                    |
                    v
             Presentation Layer
                    |
                    v
               BLoC Events
                    |
                    v
              BLoC Processing
                    |
                    v
             Repository Layer
                    |
                    v
              Data Sources
                    |
                    v
             Firebase / Firestore
                    |
                    v
              Updated State
                    |
                    v
                 UI Update
```

---

## 📁 Project Structure

The following structure reflects the actual source-code organization provided for the project, with generated and local development files excluded.

```text
shoppe_ecommerce_flutter/
│
├── android/
│   └── app/
│       └── src/
│           ├── debug/
│           ├── main/
│           │   ├── java/
│           │   ├── kotlin/
│           │   ├── res/
│           │   └── AndroidManifest.xml
│           └── profile/
│
├── assets/
│   ├── icons/
│   ├── images/
│   └── logo/
│
├── ios/
│
├── lib/
│   │
│   ├── data/
│   │   ├── datasources/
│   │   │   └── food_data.dart
│   │   ├── models/
│   │   └── repositories/
│   │       └── food_repository_impl.dart
│   │
│   ├── domain/
│   │
│   ├── presentation/
│   │   │
│   │   ├── core/
│   │   │   ├── bloc/
│   │   │   │   └── app_bloc/
│   │   │   │       ├── app_bloc.dart
│   │   │   │       ├── app_event.dart
│   │   │   │       └── app_state.dart
│   │   │   │
│   │   │   ├── colors/
│   │   │   │   └── app_colors.dart
│   │   │   │
│   │   │   ├── notification_service/
│   │   │   │   └── notification_service.dart
│   │   │   │
│   │   │   ├── text_styles/
│   │   │   │   └── app_text_styles.dart
│   │   │   │
│   │   │   └── widgets/
│   │   │
│   │   └── features/
│   │       ├── about/
│   │       ├── address/
│   │       ├── bottom_navigation_bar/
│   │       ├── cart/
│   │       ├── categories_filtering/
│   │       ├── hello_card/
│   │       ├── history/
│   │       ├── login_email/
│   │       │   └── bloc/
│   │       ├── login_password/
│   │       ├── my_activity/
│   │       ├── password_recovery/
│   │       ├── product_details/
│   │       ├── product_variations/
│   │       ├── profile/
│   │       │   └── bloc/
│   │       ├── profile_settings/
│   │       ├── ready_card/
│   │       ├── review/
│   │       ├── search/
│   │       ├── see_all/
│   │       ├── settings/
│   │       ├── shop/
│   │       ├── signup/
│   │       │   └── bloc/
│   │       ├── start/
│   │       ├── terms/
│   │       ├── to_receive/
│   │       ├── track/
│   │       ├── voucher/
│   │       └── voucher_payment/
│   │
│   ├── firebase_options.dart
│   └── main.dart
│
├── test/
├── web/
│
├── .gitignore
├── analysis_options.yaml
├── firebase.json
├── LICENSE
├── pubspec.yaml
├── pubspec.lock
├── README.md
└── shoppe_ecommerce_flutter.iml
```

---

## 🔥 Firebase Integration

Shoppe uses Firebase services for authentication, cloud data management, and push notifications.

### Firebase Services

| Service | Usage |
|---|---|
| Firebase Core | Initialize Firebase |
| Firebase Authentication | Manage authentication |
| Cloud Firestore | Store and retrieve application data |
| Firebase Cloud Messaging | Handle push notifications |

### Firestore Collections

The following collection names are referenced in the application's data-access implementation:

| Collection | Purpose |
|---|---|
| `products` | Product records and stock information |
| `users_data` | User profile and shopping-related data |
| `app_events` | Application event information |
| `delivery_methods` | Delivery-method information |
| `voucher` | Voucher information |
| `app_orders` | Order records |

Flash-sale information is accessed through:

```text
app_events/flash_sale
```

User-specific information is accessed through:

```text
users_data/{uid}
```

### Firebase Setup

1. Create a Firebase project through the [Firebase Console](https://console.firebase.google.com/).
2. Register your Android application using its configured application ID.
3. Enable Firebase Authentication.
4. Create a Cloud Firestore database.
5. Configure the required collections and documents.
6. Configure Firebase Cloud Messaging.
7. Apply appropriate Firestore Security Rules.

### FlutterFire Configuration

Install FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

Run:

```bash
flutterfire configure
```

This generates or updates the Firebase configuration file:

```text
lib/firebase_options.dart
```

Make sure Firebase is initialized before accessing Firebase services.

---

## ⚙️ Getting Started

### Prerequisites

Install the following tools:

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Android SDK
- Git
- A Firebase project

Verify your Flutter installation:

```bash
flutter doctor
```

### 1. Clone the Repository

```bash
git clone https://github.com/abdulsamad010/shoppe_ecommerce_flutter.git
```

Navigate to the project directory:

```bash
cd shoppe_ecommerce_flutter
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

Follow the Firebase configuration instructions above.

Ensure the Android application is registered with the correct application ID.

### 4. Run the Application

Check connected devices:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

---

## 📱 Build Release APK

Generate a release APK using:

```bash
flutter clean
flutter pub get
flutter build apk --release
```

The generated APK will be available at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

To generate architecture-specific APKs:

```bash
flutter build apk --release --split-per-abi
```

For production distribution, configure Android release signing and keep the keystore and passwords private.

---

## 🔔 Notification Implementation

The notification service is located at:

```text
lib/presentation/core/notification_service/notification_service.dart
```

It handles:

- Requesting notification permissions.
- Retrieving the FCM registration token.
- Listening for foreground messages.
- Registering background message handling.
- Handling notification taps.
- Processing initial messages.

### Notification Behaviour

| App State | Expected Behaviour |
|---|---|
| Foreground | In-app SnackBar |
| Background | System notification |
| Terminated | System notification |

**Important:** Notification delivery requires a valid FCM sending source. Firestore changes do not automatically generate FCM messages without a separate trusted sending mechanism.

---

## 🛡️ Security Considerations

Before deploying the application:

- Configure restrictive Firestore Security Rules.
- Restrict user-specific data to authenticated owners.
- Validate data before allowing cart and order updates.
- Protect sensitive credentials and private configuration files.
- Never expose Firebase service-account private keys in the Flutter application.
- Review database access permissions before production deployment.

---

## 🧪 Troubleshooting

### MissingPluginException

If Flutter cannot find a native plugin implementation, completely stop the application and rebuild:

```bash
flutter clean
flutter pub get
flutter run
```

### Firebase Initialization Problems

Check:

- `firebase_options.dart` exists.
- Firebase initialization happens before Firebase services are used.
- The Android application ID matches Firebase configuration.
- Required Firebase services are enabled.

### Firestore Update Errors

Check whether the target document exists and whether the authenticated user's UID is correct.

### Notification Issues

Check:

- Notification permission is granted.
- FCM is initialized correctly.
- The device has a valid registration token.
- The notification payload is correctly configured.
- Platform-specific notification settings are enabled.

---

## 🚀 Future Improvements

Potential areas for further development include:

- Expanding unit and widget testing.
- Improving loading, error, and empty states.
- Further refining state management.
- Documenting Firestore schemas.
- Strengthening data validation and security rules.
- Integrating a payment gateway.
- Improving product sharing through deep links.
- Preparing the application for production deployment.

These are potential enhancements, not claims of currently implemented functionality.

---

## 🤝 Contributions

Suggestions and contributions are welcome.

When contributing:

1. Maintain consistency with the existing project architecture.
2. Follow the established BLoC event/state pattern.
3. Preserve necessary application state during updates.
4. Keep Firestore field names consistent with the data models.
5. Test affected application workflows after changes.
6. Never commit private credentials or sensitive configuration files.

---

## 📄 License

Refer to the repository's `LICENSE` file for licensing information.

---

<div align="center">

<h2>🛍️ SHOPPE</h2>

  <p>Built with Flutter, Dart, Firebase & BLoC.</p>

  <p><em>Making everyday shopping simpler through technology.</em></p>

</div>