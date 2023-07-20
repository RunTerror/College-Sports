import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view/achievement/add_achievement.dart';
import 'package:sports_application/view/complaints/spinkit.dart';
import 'package:sports_application/view_model/achievement_provider.dart';
import 'package:sports_application/view_model/profile_provider.dart';

class SportsAchievements extends StatefulWidget {
  final String title;
  const SportsAchievements({super.key, required this.title});

  @override
  State<SportsAchievements> createState() => _SportsAchievementsState();
}

class _SportsAchievementsState extends State<SportsAchievements> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final provider = Provider.of<AchivementProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: theme.colorScheme.secondary,
        ),
        body: Container(
          width: w,
          height: h,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: LoadingKit.spinkit);
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
                if (snapshotdata!.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.sportsDetail,
                                arguments: snapshotdata[index]);
                          },
                          child: Container(
                            height: h / 1.8,
                            width: w / 1.2,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                border: Border.all(width: 1)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child:snapshotdata[index]['imageUrl']!=null? Image(
                                    width: w / 1.1,
                                    height: w/1.1,
                                    image: NetworkImage(
                                        snapshotdata[index]['imageUrl']),
                                    fit: BoxFit.cover,
                                  ): SizedBox(width: w/1.1, height: w/1.1,child: LoadingKit.imagespinkit),
                                ),
                                Container(
                                  width: w / 1.2,
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                      left: 10,right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${snapshotdata[index]['event name']}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              '${snapshotdata[index]['year']}',
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: snapshotdata!.length,
                  );
                } else {
                  return const Center(
                    child: Text(
                      "No data!",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
              }
              return const Text("No Data");
            },
            stream: provider.getAchievement(widget.title),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final position =
                await Provider.of<ProfileProvider>(context, listen: false)
                    .getPosition();
            if (position == 'user') {
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
          child: const Icon(Icons.add),
        ));
  }
}
