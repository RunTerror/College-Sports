import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_application/resources/Colors/colors.dart';

class ChatRoomScreen extends StatefulWidget {
  final String groupName, groupChatid;
  const ChatRoomScreen(
      {super.key, required this.groupChatid, required this.groupName});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ScrollController _controller = ScrollController();

  onSendMessage() {
    if (_message.text.isNotEmpty) {
     final Map<String, dynamic> messageData = {
        "email": FirebaseAuth.instance.currentUser!.email,
        "sendBy": FirebaseAuth.instance.currentUser!.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      _message.clear();

      FirebaseFirestore.instance
          .collection('groups')
          .doc(widget.groupChatid)
          .collection('chats')
          .add(messageData);
    }
  }

  final TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('groups')
                  .doc(widget.groupChatid)
                  .collection('chats')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    controller: _controller,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> chatMap = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;

                      return messageTile(MediaQuery.of(context).size, chatMap);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Container(
            height: h / 10,
            width: w,
            alignment: Alignment.center,
            child: SizedBox(
              height: h / 12,
              width: w / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h / 17,
                    width: w / 1.3,
                    child: TextField(
                      controller: _message,
                      decoration: InputDecoration(
                          hintText: "Send Message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                  IconButton(
                      icon: CircleAvatar(
                        radius: 50,
                        backgroundColor: ExternalColors.lightgreen,
                        child: Icon(
                          Icons.send,
                          color: ExternalColors.darkblue,
                        ),
                      ),
                      onPressed: () {
                        onSendMessage();
                        _controller.animateTo(
                            _controller.position.maxScrollExtent,
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeOut);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messageTile(Size size, Map<String, dynamic> chatMap) {
    return Builder(builder: (_) {
      if (chatMap['type'] == "text") {
        if ((chatMap['sendBy'] ==
                FirebaseAuth.instance.currentUser!.displayName &&
            chatMap['email'] == FirebaseAuth.instance.currentUser!.email)) {
          return Container(
            width: size.width,
            alignment: Alignment.centerRight,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ExternalColors.darkblue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatMap['message'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
          );
        } else {
          return Container(
            width: size.width,
            alignment: Alignment.centerLeft,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ExternalColors.darkblue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatMap['sendBy'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 200,
                    ),
                    Text(
                      chatMap['message'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
          );
        }
      } else if (chatMap['type'] == "notify") {
        return Container(
          width: size.width,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              chatMap['message'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ExternalColors.darkblue,
              ),
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
