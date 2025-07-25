import 'package:anti_inflammatory_app/Controllers/homevm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Controllers/authVm.dart';
import 'Utils/colors.dart';
import 'Views/UI/Auth/Login.dart';
import 'Views/UI/Auth/SignUp.dart';
import 'Views/UI/Auth/forgot_password.dart';
import 'Views/UI/Home/HomePage/Meal_diary/meal_diary.dart';
import 'Views/UI/Home/HomePage/home_screen.dart';
import 'Views/UI/Home/Goals/goals_screen.dart';
import 'Views/UI/Home/Settings/settings_screen.dart';
import 'Views/UI/Splash/splash.dart';

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    
  } else {
    print('User declined or has not granted permission');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Message received: ${message.notification?.title}');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthVm()),
        ChangeNotifierProvider(create: (context) => HomeVm()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InflamEase',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.3)),
            textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ),
      initialRoute: '/splash', // Starting with Splash Screen
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/forgot_password', page: () => const ForgotPasswordScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/goals', page: () => const GoalsScreen()),
        GetPage(name: '/settings', page: () => const SettingsScreen()),
        GetPage(name: '/meal', page: () => const MealDiaryScreen()), // Added Settings Screen Route
      ],
    );
  }
}
