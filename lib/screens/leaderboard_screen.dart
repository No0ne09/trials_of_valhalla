import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/widgets/layout/complex_screen_base.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late final _data;

  @override
  void initState() {
    super.initState();
    _data = _fetchData();
  }

  Future<int> _fetchData() async {
    final test = await FirebaseFirestore.instance
        .collection("high_scores")
        .orderBy("score", descending: true)
        .limit(10)
        .get();
    print(test.docs.length);
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return ComplexScreenBase(
        title: leaderboard,
        child: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            return Placeholder();
          },
        ));
  }
}
