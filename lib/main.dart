import 'package:FarmXpert/auth/signup.dart';
import 'package:FarmXpert/home/home.dart';
import 'package:FarmXpert/misc/config.dart' as misc;
import 'package:FarmXpert/models/user_model.dart';
import 'package:FarmXpert/splash/splash.dart';
import 'package:FarmXpert/auth/login.dart';
import 'package:FarmXpert/firebase_options.dart';
import 'package:FarmXpert/store/main_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // You may set the permission requests to "provisional" which allows the user to choose what type
// of notifications they would like to receive once the user receives a notification.
  await FirebaseMessaging.instance.requestPermission();

  final navigatorKey = GlobalKey<NavigatorState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null && notification.body != null) {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: Text(
            notification.title ?? "New Notification",
            style: const TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(notification.body!),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  });

  // Initialize Config
  misc.config = misc.ConfigConstructor(
    navigatorKey: navigatorKey,
    scaffoldKey: scaffoldKey,
  );

  // TODO: Load it in a preloader screen
  misc.config.user = await getUser(FirebaseAuth.instance.currentUser!.uid);

  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    scaffoldMessengerKey: scaffoldKey,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: misc.config.chosenTheme.primaryColor,
      ),
      fontFamily: "SF Pro Display",
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const InitialScreen(),
      '/splash': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignupScreen(),
      '/home': (context) => const HomeScreen(),
      '/store': (context) => const StoreScreen(),
    },
  ));
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (FirebaseAuth.instance.currentUser == null) {
            return const SplashScreen();
          }
          return const HomeScreen();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
