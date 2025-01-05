import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/step_tracking_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) {
    Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyDr1wiMCGL43c215ZKgh93Qu2qKHi-FMzo",
        authDomain: "stepcounter-76711.firebaseapp.com",
        projectId: "stepcounter-76711",
        storageBucket: "stepcounter-76711.firebasestorage.app",
        messagingSenderId: "967116144636",
        appId: "1:967116144636:web:6ea2e23b86f7851c067c79",
        measurementId: "G-Z5EFTYQLX9"));
  } else{
    Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/stepTracking': (context) => StepTrackingScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}
