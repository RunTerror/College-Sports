import 'package:flutter/material.dart';
import 'package:sports_application/view_model/achievement_provider.dart';

class AchievementDetail extends StatelessWidget {
  final AchievementModel achievementDetails;
  const AchievementDetail({super.key, required this.achievementDetails});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                achievementDetails.eventName!,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '(${achievementDetails.year})',
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              width: w,
              height: h / 2.5,
              color: Colors.green,
              child: Image(
                image: NetworkImage(achievementDetails.imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ));
  }
}
