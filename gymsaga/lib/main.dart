import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gymsaga/achievement.dart';
import 'package:gymsaga/login.dart';
import 'package:gymsaga/profile.dart';
import 'package:gymsaga/register.dart';
import 'package:gymsaga/homepage.dart';
import 'package:gymsaga/steps.dart';
import 'package:gymsaga/workout.dart';
import 'firebase_options.dart';
import 'loadingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cek apakah Firebase sudah diinisialisasi
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Jersey25',
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoAnimationTransitionBuilder(),
            TargetPlatform.iOS: NoAnimationTransitionBuilder(),
          },
        ),
      ),
      home: const RegisterPage(), // Ubah ke halaman awal yang kamu inginkan
    );
  }
}

// Custom transition builder tanpa animasi
class NoAnimationTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return child;
  }
}
