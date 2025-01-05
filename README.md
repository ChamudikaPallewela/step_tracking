## 🏃‍♂️ Step Tracking App  

A simple and visually appealing step-tracking application built with Flutter. This app tracks daily steps using device sensors, stores the data in Firebase, and visualizes progress through interactive charts.  

---

### 🚀 Features  
- **Real-time Step Tracking** – Tracks steps using device sensors (pedometer).  
- **Firebase Integration** – Stores daily step counts in Firestore.  
- **Dashboard Visualization** – Displays step trends with beautiful line charts (powered by `fl_chart`).  
- **Goal Setting** – Users can set daily/weekly step goals and receive notifications upon achievement.  
- **History Log** – View previous step data in a clean and organized format.  
- **Responsive UI** – Smooth and interactive UI designed with Flutter best practices.  
- **Splash & Loading Screens** – Animated splash and loading screens enhance the user experience.  
- **Walking Animation** – Walking icons animate during step tracking for a fun touch.  

---

### 🛠️ Installation  
#### 1. Clone the repository:  
```bash
git clone https://github.com/your-username/step_tracking.git
cd step_tracking
```  
#### 2. Install dependencies:  
```bash
flutter pub get
```  
#### 3. Configure Firebase:  
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).  
2. Download the `google-services.json` and place it in `android/app/`.  
3. Enable Firestore and set up basic rules for access.  

#### 4. Run the application:  
```bash
flutter run
```  

---

### ⚙️ Firebase Setup  
1. **Create Firestore Collection**:  
- Collection Name: `steps`  
- Document Fields:  
  - `steps`: (int) - Number of steps  
  - `date`: (timestamp) - Date of step entry  

2. **Enable Firestore in Firebase Console**:  
- Go to Firestore Database -> Create database -> Start in test mode.  

---

### 📂 Project Structure  
```bash
step_tracking/
│
├── lib/
│   ├── main.dart                   # Main entry point  
│   ├── screens/                    # App screens  
│   │   ├── splash_screen.dart      # Splash screen  
│   │   ├── loading_screen.dart     # Loading screen  
│   │   ├── step_tracking_screen.dart  # Step tracker  
│   │   └── dashboard_screen.dart   # Dashboard for visualization  
│   ├── services/                   # Firebase and pedometer services  
│   └── utils/                      # Utility functions and constants  
│
├── assets/  
│   ├── images/                     # App images (splash, icons, etc.)  
│   │   └── splash_image.png        
│   └── screenshots/                # Screenshots for README  
│
├── pubspec.yaml                    # Flutter dependencies  
├── android/                        # Android-specific configurations  
└── README.md                       # Project documentation  
```  

---

### 📋 Requirements  
- **Flutter** 3.0+  
- **Dart** 3.0+  
- **Android Studio** (or VS Code with Flutter extension)  
- **Firebase Account**  

---

### 📈 Future Improvements  
- 🛎️ Push Notifications for Goal Completion  
- 🌐 Apple Health/Google Fit Integration  
- 🎯 Gamification with Leaderboards  
- 📊 More Charts and Visualizations  

---

### 🤝 Contributing  
Pull requests are welcome! For significant changes, please open an issue first to discuss the proposed changes.  
