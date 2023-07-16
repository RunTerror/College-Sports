import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/repositry/firebase_repositry.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/utils/Routes/routes.dart';
import 'package:sports_application/view_model/achievement_provider.dart';
import 'package:sports_application/view_model/admin_controller.dart';
import 'package:sports_application/view_model/announcement_data.dart';
import 'package:sports_application/view_model/complaints_provider.dart';
import 'package:sports_application/view_model/firestore_methos.dart';
import 'package:sports_application/view_model/get_chatrooms.dart';
import 'package:sports_application/view_model/get_members.dart';
import 'package:sports_application/view_model/get_users.dart';
import 'package:sports_application/view_model/profile_controller.dart';
import 'package:sports_application/view_model/profile_provider.dart';
import 'package:sports_application/view_model/selected_members.dart';
import 'package:sports_application/view_model/theme_provider.dart';
import 'package:sports_application/view_model/achievements_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProfileCrontroller()),
          Provider<FirebaseAuthMethods>(
              create: (context) => FirebaseAuthMethods(FirebaseAuth.instance)),
          StreamProvider(
              create: (_) => context.read<FirebaseAuthMethods>().authState,
              initialData: null),
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => AchievementPicker()),
          Provider<FireStoreMethods>(create: (context) => FireStoreMethods()),
          ChangeNotifierProvider(create: (context) => ComplaintProvider()),
          StreamProvider(
              create: (_) => context.read<ComplaintProvider>().getComplaints(),
              initialData: null),
          ChangeNotifierProvider<AchivementProvider>(
              create: (context) => AchivementProvider()),
          ChangeNotifierProvider(create: (context) => AnnouncementProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ChangeNotifierProvider(create: (context) => GetUsers()),
          ChangeNotifierProvider(create: (context) => AdminProfileController()),
          ChangeNotifierProvider(create: (context) => GetMembersProvider()),
          ChangeNotifierProvider(create: (context)=> SelectedMembers()),
          ChangeNotifierProvider(create: (context)=> ChatRoomsProvider())

        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Provider.of<ThemeProvider>(context).theme,
            initialRoute: RouteNames.splash,
            onGenerateRoute: Routes.generateRoute,
          );
        });
  }
}
