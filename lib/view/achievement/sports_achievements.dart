import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/utils/utils.dart';
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
                if(snapshotdata!.isNotEmpty){
                 return ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.sportsDetail, arguments: snapshotdata[index]);
                        },
                        child: Container(
                          height: h / 2.2,
                          width: w / 1.2,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              border: Border.all(width: 1)),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius:const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                child: Image(
                                  width: w/1.2,
                                  height: h / 3.5,
                                  image: snapshotdata[index]['imageUrl']==null?const AssetImage('assets/Images/loadig.jpeg')as ImageProvider:
                                      NetworkImage(snapshotdata[index]['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: w / 1.2,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            const Spacer(),
                                            const Text("Positioin", style: TextStyle(fontWeight: FontWeight.w400),),
                                            const Spacer(),
                                            Text('${snapshotdata[index]['position']}🏆')
                                       ],
                                     ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshotdata[index]['description'],
                                      softWrap: false,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    )
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
                }
                else{
                  return const Center(child: Text("No data!", style: TextStyle(fontSize: 20),),);
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
