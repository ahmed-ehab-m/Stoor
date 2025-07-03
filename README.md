# Stoor
📚 Stoor is a smart Book Store App that offers a vast collection of books with real-time browsing, including book summaries, ratings, and personalized recommendations, along with a curated reading list.

🤖 The app integrates an AI-powered Gemini Bot to help users discover the perfect book based on their preferences, making your reading journey easier and more enjoyable!

## Table of contents
- ### [Setting Up The Local Server =>](#setting-up-the-local-server)
- ### [main packages used =>](#main-packages-used)
- ### [Folder structure =>](#folder-structure)
- ### [Screenshots =>](#screenshots)
- ### [Demo video =>](#demo-video)


## Setting Up The Local Server
Follow these steps to set up and run the PHP Laravel API on your local machine:
Run These Comands in your Terminal

### 1️⃣ Download and Install XAMPP
#### 🧰 Download XAMPP for your OS (Windows/macOS/Linux).
During installation, make sure Apache and MySQL are selected.
After installation, start both services from the XAMPP Control Panel.

### 2️⃣ Add PHP to System Environment Variables (Windows):
To make PHP accessible from the terminal:
```sh
Control Panel → System → Advanced system settings → Environment Variables
```
In the Path variable (under System Variables), add:
```sh
C:\xampp\php
```
### 3️⃣ Install Composer:
Download Composer and install it
Make sure it's added to your system PATH automatically during installation.
You can verify by running:
```sh
composer --version
```
### 4️⃣ Add the API Project Files:
Place the bookstore_api project folder inside:
```sh
\xampp\htdocs\
```
### 5️⃣ Link Storage for Images:
Place the bookstore_api project folder inside:
```sh
php artisan storage:link
```
### 6️⃣ Run Laravel Migrations:
in bookstoreapi folder cmd/ 
```sh
php artisan migrate
```
This will host your API at:
```sh
http://127.0.0.1:8000
```
## Main packages used

-[cached_network_image] (https://pub.dev/packages/cached_network_image) for efficiently loading and caching images from the network

-[cloud_firestore] (https://pub.dev/packages/cloud_firestore) for real-time database access using Firebase Cloud Firestore

-[cupertino_icons] (https://pub.dev/packages/cupertino_icons) for using iOS-style Cupertino icons

-[dartz] (https://pub.dev/packages/dartz) for functional programming tools like Either and Option

-[equatable] (https://pub.dev/packages/equatable) for making Dart objects comparable, useful in Bloc

-[firebase_auth] (https://pub.dev/packages/firebase_auth) for Firebase authentication like email & Google sign-in

-[firebase_core] (https://pub.dev/packages/firebase_core) for initializing Firebase in your Flutter app

-[flutter_bloc] (https://pub.dev/packages/flutter_bloc) for implementing Bloc state management pattern

-[flutter_gemini] (https://pub.dev/packages/flutter_gemini) for integrating Google Gemini AI API (text/image gen)

-[get_it] (https://pub.dev/packages/get_it) for dependency injection using a service locator

-[go_router] (https://pub.dev/packages/go_router) for managing routing and deep linking in Flutter

-[google_sign_in] (https://pub.dev/packages/google_sign_in) for Google login integration

-[hugeicons] (https://pub.dev/packages/hugeicons) for a collection of beautifully designed icons

-[image_picker] (https://pub.dev/packages/image_picker) for picking images/videos from gallery or camera

-[lottie] (https://pub.dev/packages/lottie) for rendering animations from Lottie JSON files

-[path_provider] (https://pub.dev/packages/path_provider) to access temp & documents directory

-[permission_handler] (https://pub.dev/packages/permission_handler) for requesting runtime permissions

-[shared_preferences] (https://pub.dev/packages/shared_preferences) for storing key-value pairs locally

-[skeletonizer] (https://pub.dev/packages/skeletonizer) for showing skeleton screens while loading

-[smooth_page_indicator] (https://pub.dev/packages/smooth_page_indicator) for animated page indicators

-[url_launcher] (https://pub.dev/packages/url_launcher) for opening URLs, phone, SMS, and email apps

-[webview_flutter] (https://pub.dev/packages/webview_flutter) for displaying web pages inside your app

-[email_validator] (https://pub.dev/packages/email_validator) for validating email addresses

-[flutter_staggered_grid_view] (https://pub.dev/packages/flutter_staggered_grid_view) for creating staggered grid layouts

-[connectivity_plus] (https://pub.dev/packages/connectivity_plus) for checking network connectivity

-[modal_bottom_sheet] (https://pub.dev/packages/modal_bottom_sheet) for customizable bottom sheet UI

-[flutter_svg] (https://pub.dev/packages/flutter_svg) for rendering SVG images in Flutter

-[carousel_slider] (https://pub.dev/packages/carousel_slider) for image/content sliders

-[dynamic_background] (https://pub.dev/packages/dynamic_background) for animated/live app backgrounds

-[dio] (https://pub.dev/packages/dio) for handling HTTP requests and APIs efficiently

## Folder structure
We have applied clean archeticture ,MVVM (Feature Based)  concept and here is the basic folder structure:

ai_weather
```
├── android
├── assets
├── build
├── ios
├── lib
└── test
```
Here is the folder structure we have been using in this project:

📂 lib Folder
```
├── lib
│   ├── core
│   ├── features
│   └── main.dart
```
### core
This folder contains all services and tools related to the application
```
├── core
│   ├── data
│   ├── errors
│   ├── helper
│   ├── utils
│   ├── widgets              
```
### features
This folder containes everything related to the screen of the application and the business logic of the application specificly state management.
```
presentation
├── auth
├── book marks
├── gemini
├── home
├── search
├── settings
├── splash&onboarding
```

## Screenshots
Here are some screeshots for the application:

![Stoor (1)](https://github.com/user-attachments/assets/4c4d8574-e9a4-45a6-ae3a-1b0940941ab3)
![Stoor (4)](https://github.com/user-attachments/assets/f2157d4e-1217-4dc5-9798-9ab0aaacc0a1)

## Demo Video
https://drive.google.com/file/d/19MtDc0f7H8etIeL6XAgVQUlRelrvDHPa/view?usp=drive_link
