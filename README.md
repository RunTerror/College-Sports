# Sports Hub - Flutter Firebase Application

Sports Hub is a Flutter application that serves as a sports community platform for college students of the Institute of Engineering and Technology (IET), Lucknow. It allows users with college email IDs ending with "@ietlucknow.ac.in" to access the app and assigns them roles of either admin or user based on their email ID. The application is backed by Firebase for seamless authentication, real-time database management, and cloud storage.

## Features

🔐 **Login and Role-Based Access:**
- Users can sign in using their college email IDs (ending with "@ietlucknow.ac.in").
- Role-based access: Admin privileges will be granted to users with specific email IDs, giving them additional features beyond regular users.

📢 **Announcements:**
- Admins can create and post announcements related to sports events, tournaments, or any important updates.
- Users can view these announcements on their dashboard.

📋 **Complaints:**
- Users can submit complaints or feedback related to the sports facilities, events, or any other issues they encounter.
- Admins can manage and respond to these complaints to ensure a smooth sports experience for everyone.

💬 **Group Chat:**
- Users can join sports-specific groups based on their interests or participate in group chats related to sports events.
- Admins have the ability to create, edit, and delete groups as needed.

🏆 **Achievement Section:**
- Admins can add achievements and milestones related to sports achievements, academic accomplishments, or any other recognition.
- Users can view these achievements to celebrate and motivate each other's successes.

👤 **User Profiles:**
- Each user will have a personalized profile where they can view their information and track their sports-related activities and achievements.

## Technical Details

The application is developed using the Flutter framework, which ensures cross-platform compatibility for Android and iOS devices. Firebase is used as the backend, providing secure and scalable solutions for user authentication, real-time database management with Firestore, and cloud storage for media assets.

- Firebase Authentication ensures that only users with valid "@ietlucknow.ac.in" email IDs can access the application.
- Firestore, the real-time NoSQL database provided by Firebase, is used to store and manage data related to announcements, complaints, group chats, achievements, and user profiles.
- Cloud Storage is utilized for storing media files associated with achievements or group chat messages.


## Preview

# Six Images in One Row





<table>
  <tr>
    <td>
      <img src="https://github.com/RunTerror/Sports-Hub/assets/113206442/d95111d8-6a00-4212-9cc0-2dd9fa38646d" alt="Image 1">
    </td>
    <td>
      <img src="https://github.com/RunTerror/Sports-Hub/assets/113206442/6cd3cbf1-3988-40d4-bffd-4260cdd3c5f4" alt="Image 2">
    </td>
    <td>
      <img src="https://github.com/RunTerror/Sports-Hub/assets/113206442/e8697819-147c-433e-b4d0-c2f07555786f" alt="Image 3">
    </td>
    <td>
      <img src="https://github.com/RunTerror/Sports-Hub/assets/113206442/4f8373c0-26b3-4fc2-b405-3e3d38c32958" alt="Image 4">
    </td>
    <td>
      <img src="https://github.com/RunTerror/Sports-Hub/assets/113206442/69f7a41e-665d-4a83-90af-cfc2b56361f9" alt="Image 5">
    </td>
    <td>
      <img src="https://github.com/RunTerror/Sports-Hub/assets/113206442/3b43511f-7c8a-48b3-bd1b-bcb6ec8cb45e" alt="Image 6">
    </td>
  </tr>
</table>


## 📲 Installation


Follow the steps below to set up and run the Sports Hub application on your local machine:

1. **Clone the Repository:**
   Clone the Sports Hub repository from GitHub to your local machine:


Replace `YourUsername` with your GitHub username in the URL.

2. **Install Flutter and Dart:**
Ensure you have Flutter and Dart SDK installed on your system. If not, download and set them up from the [Flutter website](https://flutter.dev/docs/get-started/install).

3. **Set Up Firebase:**
- Create a new project on the [Firebase Console](https://console.firebase.google.com/).
- Enable Firebase Authentication, Firestore, and Cloud Storage services for your project.
- Obtain the configuration files (google-services.json for Android and GoogleService-Info.plist for iOS) and place them in the respective project directories (android/app and ios/Runner).

4. **Install Dependencies:**
Navigate to the project directory and install the required dependencies:


5. **Run the App:**
Connect your Android or iOS device to your computer and run the following command:


This command will build and install the Sports Hub app on your device.

6. **Explore the App:**
Now you can enjoy the Sports Hub application on your device and experience the exciting world of college sports!

## 🤝 Contribution

Contributions to Sports Hub are welcome! If you find any bugs, want to suggest enhancements, or contribute new features, please open an issue or create a pull request in the GitHub repository.

## 📜 License

Sports Hub is open-source and released under the MIT License.

---
Replace `[GitHub Repository URL]` in the Clone the Repository step with the actual URL of your application's repository. Feel free to customize the installation process and add more details as per your application's specific setup.
