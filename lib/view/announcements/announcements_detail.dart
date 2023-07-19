import 'package:flutter/material.dart';
import 'package:sports_application/view_model/announcement_data.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementDetailScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final appbarheight = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: h - appbarheight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              SizedBox(
                  width: w,
                  height: h / 3,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(announcement.posterUrl!),
                  )),
              const SizedBox(height: 20),
              Text(announcement.eventName!,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text("Date:",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(width: 20),
                Text(announcement.date!)
              ]),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    "Description:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Spacer()
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Text(
                  announcement.note!,
                  softWrap: false,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
