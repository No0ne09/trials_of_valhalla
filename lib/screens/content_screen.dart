import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trials_of_valhalla/widgets/layout/background.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.play_arrow),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.settings),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.leaderboard),
            ),
          ],
        ),
      ),
    );
  }
}
