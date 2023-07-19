import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view_model/profile_provider.dart';

import '../../utils/Routes/route_names.dart';
import '../../view_model/announcement_data.dart';

class UserAnnouncementScreen extends StatefulWidget {
  const UserAnnouncementScreen({super.key});

  @override
  State<UserAnnouncementScreen> createState() => _UserAnnouncementScreenState();
}

class _UserAnnouncementScreenState extends State<UserAnnouncementScreen> {
  List<String> sports = [
    "Badmintion",
    "Football",
    "VolleryBall",
    "BasketBall",
    "Atletics",
    "Javelin Throw",
    "Taikondo"
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: h,
            color: theme.colorScheme.primary,
          ),
          Positioned(
              right: 10,
              top: 30,
              child: IconButton(
                  onPressed: () async {
                    final position = await Provider.of<ProfileProvider>(context,
                            listen: false)
                        .getPosition();
                    if (position == 'user') {
                      Utils.toastMessage("You don't have acess");
                    } else {
                      if (mounted) {
                        Navigator.pushNamed(
                            context, RouteNames.announcementform);
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                  ))),
          Positioned(
            top: h / 8,
            child: Container(
                padding: const EdgeInsets.only(bottom: 50, top: 40),
                height: h / 1.2,
                width: w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Consumer<AnnouncementProvider>(
                  builder: (context, announcementInstance, child) {
                    return StreamBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final announcementData = snapshot.data;
                          if (announcementData!.isNotEmpty) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.announcementdetail,
                                        arguments: announcementData[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 30,
                                        bottom: 10),
                                    child: Container(
                                      height: h / 1.8,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.black),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: h / 3,
                                              width: w,
                                              child: Image(
                                                  fit: BoxFit.cover,
                                                  image: announcementData[index]
                                                              .posterUrl !=
                                                          null
                                                      ? NetworkImage(
                                                          announcementData[
                                                                  index]
                                                              .posterUrl!)
                                                      : const AssetImage(
                                                              'assets/Images/loadig.jpeg')
                                                          as ImageProvider)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                top: (h / 1.8 - h / 3) / 10),
                                            child: Text(
                                              announcementData[index]
                                                  .eventName!,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  top: (h / 1.8 - h / 3) / 20),
                                              child: Text(
                                                  announcementData[index].date!,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey))),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  top: (h / 1.8 - h / 3) / 20,
                                                  right: 50),
                                              child: Text(
                                                announcementData[index].note!,
                                                softWrap: true,
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: announcementData.length,
                            );
                          } else {
                            return Center(
                                child: Text("No Announcements!", style: TextStyle(fontSize: 20, color: ExternalColors.darkblue),));
                          }
                        }
                        return const Center(child: Text("No Announcemnts!"));
                      },
                      stream: announcementInstance.announcementData(),
                    );
                  },
                )),
          ),
          Positioned(
              left: (w - w / 1.3) / 2,
              top: h / 8 + 10,
              child: Text(
                "Announcement Screen",
                style: TextStyle(
                    color: ExternalColors.darkblue,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              )),
        ],
      ),
    );
  }
}
