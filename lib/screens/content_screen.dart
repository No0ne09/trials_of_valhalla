import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trials_of_valhalla/helpers/functions.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/helpers/theme.dart';
import 'package:trials_of_valhalla/screens/game_screen.dart';
import 'package:trials_of_valhalla/screens/leaderboard_screen.dart';
import 'package:trials_of_valhalla/screens/settings_screen.dart';
import 'package:trials_of_valhalla/widgets/buttons/main_button.dart';
import 'package:trials_of_valhalla/widgets/layout/background.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  void _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));
  }

  void _showOfflineWarning() async {
    final status = await checkConnection();
    if (status || !mounted) return;
    await showInfoPopup(
      context,
      noConnectionPopUpInfo,
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _showOfflineWarning(),
    );
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
                  "Trials of Valhalla",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontFamily: defaultFontFamily,
                      ),
                ),
              ),
              MainButton(
                onPressed: () {
                  _navigate(const GameScreen());
                },
                text: play,
                icon: const Icon(Icons.play_arrow),
              ),
              MainButton(
                onPressed: () {
                  _navigate(const SettingsScreen());
                },
                text: settings,
                icon: const Icon(Icons.settings),
              ),
              MainButton(
                onPressed: () {
                  _navigate(const LeaderboardScreen());
                },
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
