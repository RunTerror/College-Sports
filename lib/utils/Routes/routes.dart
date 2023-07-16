import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/view/access_screen.dart';
import 'package:sports_application/view/achievement/achievement_detail.dart';
import 'package:sports_application/view/achievement/add_achievement.dart';
import 'package:sports_application/view/adminprofile/admin_profile_form.dart';
import 'package:sports_application/view/complaints/add_complaint.dart';
import 'package:sports_application/view/announcements/announcement_form.dart';
import 'package:sports_application/view/auth/Landing/landing_screen.dart';
import 'package:sports_application/view/auth/Login/email_login.dart';
import 'package:sports_application/view/auth/Login/phone_login.dart';
import 'package:sports_application/view/home_screen.dart';
import 'package:sports_application/view/adminprofile/preview_screen.dart';
import 'package:sports_application/view/userprofile/profile_user.dart';
import 'package:sports_application/view/settings.dart';
import 'package:sports_application/view/auth/splash/splash_screen.dart';
import 'package:sports_application/view/achievement/sports_achievements.dart';
import 'package:sports_application/view/userprofile/user_profile.dart';import 'package:sports_application/view_model/wrapper/wrapper.dart';
import '../../view/auth/Register/register_screen.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name){
      case RouteNames.emaillogin:
           return MaterialPageRoute(builder: (BuildContext context)=>const EmailLoginScreen());
      case RouteNames.phonelogin:
           return MaterialPageRoute(builder: (BuildContext context)=>const PhoneLogin());
      case RouteNames.register:
           return MaterialPageRoute(builder: (context)=>const  RegisterScreen());
      case RouteNames.landing:
           return MaterialPageRoute(builder: (context)=>const LandingScreen());
      case RouteNames.homescreen:
           return MaterialPageRoute(builder: (context)=> const HomeScreen());
      case RouteNames.wrapper:
           return MaterialPageRoute(builder: (context)=>const Wrapper());
      case RouteNames.splash:
           return MaterialPageRoute(builder: (context)=>const SplashScreen());
      // case RouteNames.addAchievements:
      //      return MaterialPageRoute(builder: (context)=>const AddAchievemen());
      // case RouteNames.sportsAchievements:
      //      return MaterialPageRoute(builder: (context)=>const SportsAchievements());
      // case RouteNames.previewScreen:
      //      return MaterialPageRoute(builder: (context)=>const PreViewScreen());
      case RouteNames.profileUser:
           return MaterialPageRoute(builder: (context)=> const ProfileUser());
      case RouteNames.settings:
           return MaterialPageRoute(builder: (context)=> const SettingsPage());
       case RouteNames.addComplaint:
           return MaterialPageRoute(builder: (context)=> const AddComplaint());
      case RouteNames.userProfile:
           return MaterialPageRoute(builder: (context)=> const UserProfile());
       case RouteNames.announcementform:
           return MaterialPageRoute(builder: (context)=> const AnnouncementForm());
      case RouteNames.amdinProfileform:
           return MaterialPageRoute(builder: (context)=> const AdminProfileForm());
      case RouteNames.accessScreen:
           return MaterialPageRoute(builder: (context)=> const ManageAcess());
     
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
    
    
  }
   
}