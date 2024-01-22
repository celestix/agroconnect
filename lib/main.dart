import 'package:FarmXpert/auth/signup.dart';
import 'package:FarmXpert/home/home.dart';
import 'package:FarmXpert/misc/config.dart' as misc;
import 'package:FarmXpert/splash/splash.dart';
import 'package:FarmXpert/auth/login.dart';
import 'package:FarmXpert/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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

  final navigatorKey = GlobalKey<NavigatorState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // Initialize Config
  misc.config = misc.ConfigConstructor(
    navigatorKey: navigatorKey,
    scaffoldKey: scaffoldKey,
  );
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
