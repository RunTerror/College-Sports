import 'package:flutter/material.dart';

class AchievementDetail extends StatelessWidget {
  final Map<String, dynamic> achievementdetail;

  const AchievementDetail({super.key, required this.achievementdetail});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            achievementdetail['event name'],
            style: const TextStyle(fontSize: 20),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel)),
        ),
        body: ListView(
          children: [
            Container(
              width: w,
              height: h / 2.5,
              color: Colors.green,
              child: Image(
                image: achievementdetail['imageUrl'] == null
                    ? const AssetImage('assets/Images/lodig.jpeg')
                        as ImageProvider
                    : NetworkImage(achievementdetail['imageUrl']),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Date:",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${achievementdetail['year']}',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 25),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Team Members",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      height: h / 10,
                      width: w / 1.5,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Center(
                              child: Text(achievementdetail['team'][index]));
                        },
                        itemCount: achievementdetail['team'].length,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(achievementdetail['description'])
                ],
              ),
            )
          ],
        ));
  }
}
