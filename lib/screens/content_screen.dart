import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';
import 'package:trials_of_valhalla/widgets/buttons/main_button.dart';
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              FittedBox(
                child: Text(
                  "Trails of Valhalla",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontFamily: defaultFontFamily,
                      ),
                ),
              ),
              MainButton(
                onPressed: () {},
                text: play,
                icon: const Icon(Icons.play_arrow),
              ),
              MainButton(
                onPressed: () {},
                text: settings,
                icon: const Icon(Icons.settings),
              ),
              MainButton(
                onPressed: () {},
                text: leaderboard,
                icon: const Icon(Icons.leaderboard),
              ),
              MainButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                text: logout,
                icon: const Icon(Icons.logout),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
