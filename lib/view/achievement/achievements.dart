import 'package:flutter/material.dart';
import 'package:sports_application/view/achievement/sports_achievements.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  List<String> sports = [
    "Badmintion",
    "Football",
    "VolleyBall",
    "BasketBall",
    "Atletics",
    "Javelin Throw",
    "Taikondo",
    "Lawn Tennis",
    "Table Tennis",
    "Chess"
  ];
  final data = "name";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: [
        Container(
          height: double.maxFinite,
          color: theme.colorScheme.primary,
        ),
        Positioned(
            top: h / 8,
            child: SingleChildScrollView(
                child: Container(
              height: 7 * h / 8 - 75,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 30),
              width: w,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child:  GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SportsAchievements(
                        title: sports[index],
                      );
                    }));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(sports[index]),
                  ),
                );
              },
              itemCount: sports.length),
        ),
      ),)
      ]),);
  }
}


