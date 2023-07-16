import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/view_model/admin_controller.dart';
import '../../repositry/firebase_repositry.dart';
import '../../resources/Components/profile_container.dart';
import '../../utils/Routes/route_names.dart';
import '../../view_model/profile_controller.dart';
import '../../view_model/profile_provider.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final obj = Provider.of<ProfileCrontroller>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: h,
          ),
          Container(
            height: h / 2.4,
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          ),
          Positioned(
              left: 0.1 * w / 1.2,
              top: h / 3,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                alignment: Alignment.center,
                width: w / 1.2,
                height: h / 2.5,
                decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileContainer(
                          iconData: Icons.logout,
                          text: "Log Out",
                          function: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text("Log Out"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("cancel")),
                                    TextButton(
                                        onPressed: () async {
                                          context
                                              .read<FirebaseAuthMethods>()
                                              .signOut(context);
                                          Navigator.of(context).pop();
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.clear();
                                        },
                                        child: const Text("yes"))
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        ProfileContainer(
                          iconData: Icons.person,
                          text: "Update",
                          function: () {
                            Navigator.pushNamed(
                                context, RouteNames.amdinProfileform);
                          },
                        ),
                        ProfileContainer(
                          iconData: Icons.change_history,
                          text: "Access",
                          function: () {
                            Navigator.pushNamed(
                                context, RouteNames.accessScreen);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Department",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Consumer<AdminProfileController>(
                          builder: (context, value, child) {
                            return StreamBuilder(
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('loading');
                                } else if (snapshot.hasError) {
                                  return Text(
                                    '${snapshot.error}',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  );
                                } else if (snapshot.hasData) {
                                  final data = snapshot.data;
                                  return snapshot.data!.department == null
                                      ? TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, RouteNames.amdinProfileform);

                                          },
                                          child: const Text("Update"))
                                      : Text(data!.department!);
                                }
                                return const Text('Update');
                              },
                              stream: value.getAdminProfile(),
                            );
                          },
                        )
                      ],
                    ),
                    Divider(
                      height: 2,
                      color: ExternalColors.darkblue,
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const Text(
                          "Position",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Consumer<AdminProfileController>(
                          builder: (context, value, child) {
                            return StreamBuilder(
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('loading');
                                } else if (snapshot.hasError) {
                                  return Text(
                                    '${snapshot.error}',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  );
                                } else if (snapshot.hasData) {
                                  final data = snapshot.data;
                                  return Text(data!.position!);
                                }
                                return const Text('Update');
                              },
                              stream: value.getAdminProfile(),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Positioned(
              left: (2.5 * w) / 7,
              top: h / 15,
              child: InkWell(
                  onTap: () {
                    obj.showD(context);
                  },
                  child: CircleAvatar(
                    radius: w / 7,
                    backgroundColor: theme.colorScheme.secondary,
                    child: Consumer<AdminProfileController>(builder: (context, value, child) {
                      return StreamBuilder(builder: (context, snapshot) {
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return const Center(child: CircularProgressIndicator(color: Colors.white),);
                        }
                        else if(snapshot.hasError){
                          return Text("${snapshot.error}", softWrap: false,overflow: TextOverflow.ellipsis,maxLines: 1,);
                        }
                        final data=snapshot.data;
                        return CircleAvatar(
                      radius: w / 7.5,
                      backgroundColor: theme.colorScheme.primary,
                      backgroundImage: data!.profile==null? null: NetworkImage(data.profile!),
                    );
                      },stream: value.getAdminProfile(),);
                      
                    },)
                  ))),
          Positioned(
            top: 2 * w / 7 + h / 15 + 10,
            child: SizedBox(
              width: w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      Map<String, String>? data = snapshot.data!;
                      return Text(
                        '${data['name']}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    },
                    future: Provider.of<ProfileProvider>(context).getUserData(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('loading');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      Map<String, String> data = snapshot.data!;
                      return Text("${data['email']}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300));
                    },
                    future: Provider.of<ProfileProvider>(context).getUserData(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
