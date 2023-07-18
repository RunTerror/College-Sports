import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/view_model/announcement_data.dart';
import 'package:transparent_image/transparent_image.dart';

class AdminAnnouncementScreen extends StatelessWidget {
  const AdminAnnouncementScreen({super.key});

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
              right: 20,
              top: 30,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.announcementform);
                  },
                  icon: const Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                  ))),
          Positioned(
            top: h / 8,
            child: Container(
                padding: const EdgeInsets.only(bottom: 50),
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
                                      left: 20, right: 20, top: 30, bottom: 10),
                                  child: Container(
                                    height: h / 1.8,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: h / 3,
                                            width: w,
                                            child: announcementData[index]
                                                        .posterUrl ==
                                                    null
                                                ? const Image(
                                                    fit: BoxFit.contain,
                                                    image: AssetImage(
                                                        'assets/Images/loadig.jpeg'))
                                                : FadeInImage.memoryNetwork(
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        kTransparentImage,
                                                    image:
                                                        announcementData[index]
                                                            .posterUrl!)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              top: (h / 1.8 - h / 3) / 10),
                                          child: Text(
                                            announcementData[index].eventName!,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
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
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: announcementData!.length,
                          );
                        }
                        return const Text("No Announcemnts");
                      },
                      stream: announcementInstance.announcementData(),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
