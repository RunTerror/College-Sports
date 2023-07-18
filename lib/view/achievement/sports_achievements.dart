import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view/achievement/achievement_detail.dart';
import 'package:sports_application/view/achievement/add_achievement.dart';
import 'package:sports_application/view_model/achievement_provider.dart';
import 'package:sports_application/view_model/profile_provider.dart';

class SportsAchievements extends StatefulWidget {
  final String title;
  const SportsAchievements({super.key, required this.title});

  @override
  State<SportsAchievements> createState() => _SportsAchievementsState();
}

class _SportsAchievementsState extends State<SportsAchievements> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final provider =
        Provider.of<AchivementProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: theme.colorScheme.secondary,
        ),
        body: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No Achivemnets"),
              );
            } else if (snapshot.hasData) {
              final snapshotdata = snapshot.data;
              return Center(
                child: SizedBox(
                  width: w / 1.2,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: h / 1.8,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: h / 3,
                                  width: w,
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          snapshotdata[index].imageUrl!))),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: (h / 1.8 - h / 3) / 10),
                                child: Text(
                                  snapshotdata[index].eventName!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, top: (h / 1.8 - h / 3) / 20),
                                  child: Text(snapshotdata[index].year!,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10,
                                      top: (h / 1.8 - h / 3) / 20,
                                      right: 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Position🏆"),
                                      Text(snapshotdata[index].position!)
                                    ],
                                  )),
                              SizedBox(
                                height: (h / 1.8 - h / 3) / 15,
                              ),
                              const Divider(
                                height: 4,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AchievementDetail(
                                            achievementDetails:
                                                snapshotdata[index],
                                          );
                                        }));
                                      },
                                      child: const Text(
                                        "View More",
                                        style: TextStyle(color: Colors.black87),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshotdata!.length,
                  ),
                ),
              );
            }
            return const Text("Null");
          },
          stream: provider.getAchievement(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            isLoading = true;
            final position =
                await Provider.of<ProfileProvider>(context, listen: false)
                    .getPosition();
            if (position == 'user') {
              isLoading = false;
              Utils.toastMessage("You don't have access");
            } else {
              if (mounted) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return AddAchievement(sport: widget.title);
                }));
              }
            }
          },
          child: isLoading == true
              ? const CircularProgressIndicator()
              : const Icon(Icons.add),
        ));
  }
}
