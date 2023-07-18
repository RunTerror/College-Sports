import 'package:flutter/material.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/view/adminprofile/admin_profile_form.dart';
import 'package:sports_application/view/announcements/announcements_detail.dart';
import 'package:sports_application/view/complaints/add_complaint.dart';
import 'package:sports_application/view/announcements/announcement_form.dart';
import 'package:sports_application/view/auth/Landing/landing_screen.dart';
import 'package:sports_application/view/auth/Login/email_login.dart';
import 'package:sports_application/view/auth/Login/phone_login.dart';
import 'package:sports_application/view/complaints/complaint_details_screen.dart';
import 'package:sports_application/view/complaints/user_complaint.dart';
import 'package:sports_application/view/home_screen.dart';
import 'package:sports_application/view/server/server.dart';
import 'package:sports_application/view/userprofile/profile_user.dart';
import 'package:sports_application/view/settings.dart';
import 'package:sports_application/view/auth/splash/splash_screen.dart';
import 'package:sports_application/view/userprofile/user_profile.dart';
import 'package:sports_application/view_model/announcement_data.dart';
import 'package:sports_application/view_model/complaints_provider.dart';
import 'package:sports_application/view_model/wrapper/wrapper.dart';
import '../../view/access_screen.dart';
import '../../view/auth/Register/register_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteNames.emaillogin:
        return MaterialPageRoute(
            builder: (BuildContext context) => const EmailLoginScreen());
      case RouteNames.phonelogin:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PhoneLogin());
      case RouteNames.register:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case RouteNames.landing:
        return MaterialPageRoute(builder: (context) => const LandingScreen());
      case RouteNames.homescreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteNames.wrapper:
        return MaterialPageRoute(builder: (context) => const Wrapper());
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.profileUser:
        return MaterialPageRoute(builder: (context) => const ProfileUser());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (context) => const SettingsPage());
      case RouteNames.addComplaint:
        return MaterialPageRoute(builder: (context) => const AddComplaint());
      case RouteNames.userProfile:
        return MaterialPageRoute(builder: (context) => const UserProfile());
      case RouteNames.announcementform:
        return MaterialPageRoute(
            builder: (context) => const AnnouncementForm());
      case RouteNames.amdinProfileform:
        return MaterialPageRoute(
            builder: (context) => const AdminProfileForm());
      case RouteNames.accessScreen:
        return MaterialPageRoute(builder: (context) => const ManageAcess());
      case RouteNames.userComplaint:
        return MaterialPageRoute(
            builder: (context) => const UserComplaintScreen());
      case RouteNames.server:
        return MaterialPageRoute(builder: (context) => const ServerSceen());
      case RouteNames.detailedComplaint:
        if (arguments is Complaint) {
          return MaterialPageRoute(
              builder: (context) => ComplaintDetailsScreen(
                    complaintDetails: arguments,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) =>
                  const Center(child: Text("No route definded")));
        }
      case RouteNames.announcementdetail:
        if (arguments is Announcement) {
          return MaterialPageRoute(
              builder: (context) => AnnouncementDetailScreen(
                    announcement: arguments,
                  ));
        } else {
          return MaterialPageRoute(
            builder: (context) {
              return const Scaffold(
                body: Center(child: Text("No routes defined")),
              );
            },
          );
        }

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
