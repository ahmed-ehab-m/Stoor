
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
Follow these steps to set up the local server:
Run These Comands in your Terminal
### 1️⃣ Create a Virtual Environment
#### 🖥️ **Windows**
```sh
python -m venv venv
venv\Scripts\activate.bat
Set-ExecutionPolicy Unrestricted -Scope Process
venv\Scripts\Activate.ps1
```
#### 🖥️ **Mac**
```sh
python3 -m venv venv
source venv/bin/activate
```
### 2️⃣ Install the required packages:
```sh
pip install Flask
pip install numpy
pip install scikit-learn==1.3.2
```
### 3️⃣ Run the server:
```sh
python app.py // to host the AI model and access it through your local host on port 5001.
```
### 4️⃣ Check if the server is running:
```sh
http://127.0.0.1:5001
```
### 5️⃣ Send data to the model using the POST method:
```sh
http://10.0.2.2:5001/predict
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

![WhatsApp Image 2025-06-30 at 11 43 24 PM (1)-portrait](https://github.com/user-attachments/assets/e7d0da21-93b2-4e24-8e65-70e814998195)
![WhatsApp Image 2025-06-30 at 11 43 24 PM-portrait](https://github.com/user-attachments/assets/db69003b-1b9a-4e15-88f0-abdd4ac9b0a8)
![WhatsApp Image 2025-07-03 at 1 16 17 AM (2)-portrait](https://github.com/user-attachments/assets/f0ea6542-edb9-4904-8741-c5242882d7bf)
![WhatsApp Image 2025-07-03 at 1 16 17 AM (3)-portrait](https://github.com/user-attachments/assets/0fd2bfbd-56fc-4b03-b8a5-adefdac1730c)
![WhatsApp Image 2025-07-03 at 1 16 18 AM (2)-portrait](https://github.com/user-attachments/assets/7a958ff1-6d0e-4173-8b91-3e1ca6844450)
![WhatsApp Image 2025-07-03 at 1 16 18 AM-portrait](https://github.com/user-attachments/assets/600f31b5-db75-4609-8d37-32d66b6877c0)
![WhatsApp Image 2025-07-03 at 1 30 30 AM-portrait](https://github.com/user-attachments/assets/a6509e29-2c17-4945-8564-a63e3abbb888)

![Stoor](https://github.com/user-attachments/assets/d0230fc7-64e1-465c-a159-d91287cb44ee)


## Demo Video
https://github.com/user-attachments/assets/9ddd4164-3d5c-4c98-a830-40814e2d52ba
