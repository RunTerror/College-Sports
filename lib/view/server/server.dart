import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/view/server/add_members.dart';
import 'package:sports_application/view/server/chat_room_screen.dart';
import 'package:sports_application/view_model/get_chatrooms.dart';

class ServerSceen extends StatelessWidget {
  const ServerSceen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Server Screen")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ChatRoomsProvider>(
              builder: (context, value, child) {
                return StreamBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Create your own server "),
                      );
                    }
                    final rooms = snapshot.data!;
                    if (rooms.isNotEmpty) {
                      return SizedBox(
                        width: w,
                        height: h / 1.3,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                  return ChatRoomScreen(
                                      groupChatid: rooms[index]['id'],
                                      groupName: rooms[index]['name']);
                                }));
                              },
                              title: Text(rooms[index]['name']),
                              leading: const Icon(Icons.group),
                            );
                          },
                          itemCount: rooms.length,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: h/2.2,),
                          const Center(
                              child:  Text(
                            "Create your own server 💬",
                            style: TextStyle(fontSize: 20),
                          )),
                        ],
                      );
                    }
                  },
                  stream: value.getChatrooms(),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddMembersScreen();
            },
          ));
        },
        child: const Icon(Icons.group),
      ),
    );
  }
}
