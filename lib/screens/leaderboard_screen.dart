import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trials_of_valhalla/helpers/strings.dart';
import 'package:trials_of_valhalla/screens/complex_screen_base.dart';
import 'package:trials_of_valhalla/widgets/layout/custom_progress_indicator.dart';
import 'package:trials_of_valhalla/widgets/leaderboard/leaderboard_tile.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late final Future<List<Map<String, dynamic>>> _data;

  @override
  void initState() {
    super.initState();
    _data = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    final List<Map<String, dynamic>> docs = [];
    final result = await FirebaseFirestore.instance
        .collection("high_scores")
        .orderBy("score", descending: true)
        .limit(10)
        .get();

    for (final item in result.docs) {
      docs.add(item.data());
    }

    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return ComplexScreenBase(
        divider: 1.25,
        title: leaderboard,
        child: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomProgressIndicator();
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(unknownError),
              );
            }
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Card(
                child: LeaderboardTile(
                  index: index,
                  data: data[index],
                ),
              ),
            );
          },
        ));
  }
}
