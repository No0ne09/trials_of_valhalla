import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trials_of_valhalla/helpers/firebase_options.dart';
import 'package:trials_of_valhalla/screens/auth_screen.dart';
import 'package:trials_of_valhalla/screens/content_screen.dart';
import 'package:trials_of_valhalla/widgets/layout/custom_progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: CustomProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const AuthScreen();
          }
          return const ContentScreen();
        },
      ),
    );
  }
}
