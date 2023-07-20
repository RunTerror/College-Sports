# sports_application

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Welcome to the Flutter Firebase Application!

This Flutter application is designed to have two sides: the user side and the admin side. The user side allows users to log in with their college email IDs that end with "@ietlucknow.ac.in." The admin side, on the other hand, provides additional functionalities such as adding announcements, complaints, groups, and achievements. Admins can also promote users to become admins, granting them access to all features of uploading.

Here is a brief overview of the key features and functionalities of the application:

User Side:

Login: Users can log in to the application using their college email IDs that end with "@ietlucknow.ac.in."
Access Limited Features: Once logged in, users can access specific functionalities designed for users, such as viewing announcements and joining groups.
Admin Side:

Login: Admins log in with their respective admin accounts.
Access Full Features: Admins have access to additional features beyond what regular users can do.
Add Announcements: Admins can post announcements, which will be visible to all users.
Add Complaints: Admins can manage user complaints and respond to them appropriately.
Manage Groups: Admins have control over groups, allowing them to create, edit, and delete groups.
Add Achievements: Admins can add achievements that will be displayed to all users.
Promote Users to Admins:

Admins have the ability to promote regular users to become admins.
Promoted admins will gain access to all admin features, including adding announcements, complaints, groups, and achievements.
Technical Details:

The application is built using the Flutter framework, allowing for cross-platform compatibility (Android and iOS).
Firebase is used as the backend for authentication, database management, and storage of user-related data.
User authentication is handled securely using Firebase Auth, ensuring that only users with valid "@ietlucknow.ac.in" email IDs can access the application.
Firestore, the real-time NoSQL database provided by Firebase, is used to store and manage data related to announcements, complaints, groups, achievements, user information, and admin privileges.
Cloud Storage is used for storing files and media, such as images or documents related to achievements or group content.
Please note that this is a basic overview of the application's functionalities. Depending on the specific requirements and design, the implementation may vary. If you have any further questions or need additional details, feel free to ask!
