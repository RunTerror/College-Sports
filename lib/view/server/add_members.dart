import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/view/server/create_server.dart';
import 'package:sports_application/view_model/get_members.dart';

class AddMembersScreen extends StatefulWidget {
  const AddMembersScreen({super.key});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final TextEditingController _searchController = TextEditingController();

  String search = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Members"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                "Selected List",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<GetMembersProvider>(
              builder: (context, value, child) {
                return SizedBox(
                  height: h / 3,
                  width: w,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          value.removerMember(value.selectedList[index]);
                        },
                        trailing: const Icon(Icons.cancel),
                        leading: const Icon(Icons.person_outline),
                        title: Text(value.selectedList[index]['name']),
                        subtitle: Text(value.selectedList[index]['email']),
                      );
                    },
                    itemCount: value.selectedList.length,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                  controller: _searchController,
                  decoration: const InputDecoration(
                      hintText: "search", border: OutlineInputBorder()),
                )),
            Consumer<GetMembersProvider>(
              builder: (context, value, child) {
                return StreamBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Map<String, dynamic>> usersList = snapshot.data!;
                      for (Map<String, dynamic> user in usersList) {
                        if (user['email'] ==
                            FirebaseAuth.instance.currentUser!.email) {
                          name = user['name'];
                          break;
                        }
                      }
                      return SizedBox(
                        height: h / 2.5,
                        width: w,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return search == ""
                                ? (usersList[index]['email'] !=
                                        FirebaseAuth
                                            .instance.currentUser!.email)
                                    ? ListTile(
                                        trailing: const Icon(Icons.add_box),
                                        onTap: () {
                                          value.checkIfExtst(usersList[index]);
                                        },
                                        leading: const Icon(
                                          Icons.person_outline,
                                        ),
                                        title: Text(usersList[index]['name']),
                                        subtitle:
                                            Text(usersList[index]['email']),
                                      )
                                    : Container()
                                : usersList[index]['email']
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(search.toLowerCase())
                                    ? ListTile(
                                        trailing: const Icon(Icons.add_box),
                                        onTap: () {
                                          value.checkIfExtst(usersList[index]);
                                        },
                                        leading: const Icon(
                                          Icons.person_outline,
                                        ),
                                        title: Text(usersList[index]['name']),
                                        subtitle:
                                            Text(usersList[index]['email']),
                                      )
                                    : Container();
                          },
                          itemCount: usersList.length,
                        ),
                      );
                    }
                    return const Center(
                      child: Text("No data"),
                    );
                  },
                  stream: value.getMembers(),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: Provider.of<GetMembersProvider>(context)
              .selectedList
              .isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                Provider.of<GetMembersProvider>(context, listen: false)
                    .checkIfExtst({
                  "name": name,
                  "email": FirebaseAuth.instance.currentUser!.email,
                  "uid": FirebaseAuth.instance.currentUser!.uid,
                  "isAdmin": true
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CreateServer(
                    name: name,
                    membersList:
                        Provider.of<GetMembersProvider>(context, listen: false)
                            .selectedList,
                  );
                }));
              },
              child: const Icon(Icons.arrow_forward),
            )
          : null,
    );
  }
}
