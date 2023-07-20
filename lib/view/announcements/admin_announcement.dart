import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/view_model/announcement_data.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../resources/Colors/colors.dart';

class AdminAnnouncementScreen extends StatefulWidget {
  const AdminAnnouncementScreen({super.key});

  @override
  State<AdminAnnouncementScreen> createState() =>
      _AdminAnnouncementScreenState();
}

class _AdminAnnouncementScreenState extends State<AdminAnnouncementScreen> {
  final spinkit = SpinKitWave(
    color: ExternalColors.lightgreen,
    size: 30,
  );

  final imagespinkit = SpinKitPulsingGrid(color: ExternalColors.lightgreen);

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
                          return Center(child: spinkit);
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
                                            CrossAxisAlignment.center,
                                        children: [
                                          announcementData[index].posterUrl !=
                                                  null
                                              ? SizedBox(
                                                  height: w / 1.1,
                                                  width: w / 1.1,
                                                  child:
                                                      FadeInImage.memoryNetwork(
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              kTransparentImage,
                                                          image:
                                                              announcementData[
                                                                      index]
                                                                  .posterUrl!))
                                              : SizedBox(
                                                  width: w / 1.1,
                                                  height: w / 1.1,
                                                  child: imagespinkit),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                top: (h / 1.8 - h / 3) / 10-10),
                                            child: Text(
                                              announcementData[index]
                                                  .eventName!,
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
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: announcementData.length,
                            );
                          } else {
                            return const Center(
                              child: Text("No Announcements!"),
                            );
                          }
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
