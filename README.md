<h1> Sports Hub - Flutter Firebase Application</h1>

Sports Hub is a Flutter application that serves as a sports community platform for college students of the Institute of Engineering and Technology (IET), Lucknow. It allows users with college email IDs ending with "@ietlucknow.ac.in" to access the app and assigns them roles of either admin or user based on their email ID. The application is backed by Firebase for seamless authentication, real-time database management, and cloud storage.

Features
Login and Role-Based Access:

Users can sign in using their college email IDs (ending with "@ietlucknow.ac.in").
Role-based access: Admin privileges will be granted to users with specific email IDs, giving them additional features beyond regular users.
Announcements:

Admins can create and post announcements related to sports events, tournaments, or any important updates.
Users can view these announcements on their dashboard.
Complaints:

Users can submit complaints or feedback related to the sports facilities, events, or any other issues they encounter.
Admins can manage and respond to these complaints to ensure a smooth sports experience for everyone.
Group Chat:

Users can join sports-specific groups based on their interests or participate in group chats related to sports events.
Admins have the ability to create, edit, and delete groups as needed.
Achievement Section:

Admins can add achievements and milestones related to sports achievements, academic accomplishments, or any other recognition.
Users can view these achievements to celebrate and motivate each other's successes.
User Profiles:

Each user will have a personalized profile where they can view their information and track their sports-related activities and achievements.
Technical Details
The application is developed using the Flutter framework, which ensures cross-platform compatibility for Android and iOS devices.
Firebase is used as the backend, providing secure and scalable solutions for user authentication, real-time database management with Firestore, and cloud storage for media assets.
Firebase Authentication ensures that only users with valid "@ietlucknow.ac.in" email IDs can access the application.
Firestore, the real-time NoSQL database provided by Firebase, is used to store and manage data related to announcements, complaints, group chats, achievements, and user profiles.
Cloud Storage is utilized for storing media files associated with achievements or group chat messages.
Installation
Clone the repository from [GitHub Repository URL].
Install Flutter and Dart on your development machine if you haven't already.
Set up a Firebase project and enable Firebase Authentication, Firestore, and Cloud Storage services.
Add the Firebase configuration files to the Flutter project as per the Firebase documentation.
Run the application on an Android emulator or iOS simulator using flutter run command.
Contribution
Contributions to Sports Hub are welcome! If you find any bugs, want to suggest enhancements, or contribute new features, please open an issue or create a pull request in the GitHub repository.

License
Sports Hub is open-source and released under the MIT License.
