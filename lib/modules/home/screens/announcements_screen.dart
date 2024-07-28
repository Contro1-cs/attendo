import 'package:attendo/modules/home/widgets/announcement_tile.dart';
import 'package:flutter/material.dart';

import '../models/announcement_model.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  List<AnnouncementModel> announcements = [
    AnnouncementModel(
      title: "Major announcement",
      dateTime: DateTime(2024, 07, 10, 10, 33).toIso8601String(),
      content:
          "Amet et ex magna magna consequat dolor aliqua. Lorem culpa amet in id ut cupidatat deserunt sint commodo aliqua reprehenderit in. Nisi ut est do laborum culpa adipisicing tempor excepteur qui in nisi anim qui. Dolore dolor sit amet laborum. Est laboris nulla commodo cillum sint velit.",
    ),
    AnnouncementModel(
      title: "Quarterly review",
      dateTime: DateTime(2024, 07, 10, 10, 33).toIso8601String(),
      content: "Amet et ex magna magna consequat dolor aliqua.",
    ),
    AnnouncementModel(
      title: "New feature",
      dateTime: DateTime(2024, 07, 10, 10, 33).toIso8601String(),
      content:
          "Amet et ex magna magna consequat dolor aliqua. Lorem culpa amet in id ut cupidatat deserunt sint commodo aliqua reprehenderit in. Nisi ut est do laborum culpa adipisicing tempor excepteur qui in nisi anim qui. Dolore dolor sit amet laborum. Est laboris nulla commodo cillum sint velit.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                },
            ),
            const Text('Announcements'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            return AnnouncementTile(announcement: announcements[index]);
          },
        ),
      ),
    );
  }
}
