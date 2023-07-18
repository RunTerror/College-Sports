import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/view_model/get_users.dart';

class ManageAcess extends StatefulWidget {
  const ManageAcess({super.key});

  @override
  State<ManageAcess> createState() => _ManageAcessState();
}

class _ManageAcessState extends State<ManageAcess> {
  String name = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ExternalColors.lightgreen,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                controller: searchController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter name"),
              ),
            ),
            Consumer<GetUsers>(
              builder: (context, userinstance, child) {
                return StreamBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<UserModel> models = snapshot.data!;
                      List<UserModel> userModels = [];
                      for (UserModel model in models) {
                        if (model.email![0] == '2') {
                          userModels.add(model);
                        }
                      }
                      if (userModels.isEmpty) {
                        return const Center(child: Text("No User exist"));
                      } else {
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return (name == "")
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                            width: 1,
                                          )),
                                          child: ListTile(
                                            subtitle: Text(
                                              userModels[index].email!,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                        "change position"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              "Cancel")),
                                                      TextButton(
                                                          onPressed: () async {
                                                            QuerySnapshot
                                                                querySnapshot =
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Users')
                                                                    .where(
                                                                        "email",
                                                                        isEqualTo:
                                                                            userModels[index].email)
                                                                    .get();
                                                            if (querySnapshot
                                                                    .size >
                                                                0) {
                                                              DocumentReference
                                                                  documentReference =
                                                                  querySnapshot
                                                                      .docs[0]
                                                                      .reference;
                                                              await documentReference
                                                                  .update({
                                                                'position':
                                                                    userModels[index].position ==
                                                                            'user'
                                                                        ? 'admin'
                                                                        : 'user'
                                                              }).then((value) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            }
                                                          },
                                                          child: userModels[
                                                                          index]
                                                                      .position ==
                                                                  'user'
                                                              ? const Text(
                                                                  "Make admin")
                                                              : const Text(
                                                                  "Make User"))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            title:
                                                Text(userModels[index].name!),
                                            trailing: Text(
                                                userModels[index].position!),
                                          )),
                                    )
                                  : (userModels[index]
                                          .name!
                                          .toLowerCase()
                                          .startsWith(name.toLowerCase()))
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                width: 1,
                                              )),
                                              child: ListTile(
                                                subtitle: Text(
                                                  userModels[index].email!,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: const Text(
                                                            "change position"),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                  "Cancel")),
                                                          TextButton(
                                                              onPressed:
                                                                  () async {
                                                                QuerySnapshot
                                                                    querySnapshot =
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Users')
                                                                        .where(
                                                                            "email",
                                                                            isEqualTo:
                                                                                userModels[index].email)
                                                                        .get();
                                                                if (querySnapshot
                                                                        .size >
                                                                    0) {
                                                                  DocumentReference
                                                                      documentReference =
                                                                      querySnapshot
                                                                          .docs[
                                                                              0]
                                                                          .reference;
                                                                  await documentReference
                                                                      .update({
                                                                    'position': userModels[index].position ==
                                                                            'user'
                                                                        ? 'admin'
                                                                        : 'user'
                                                                  }).then((value) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                }
                                                              },
                                                              child: userModels[
                                                                              index]
                                                                          .position ==
                                                                      'user'
                                                                  ? const Text(
                                                                      "Make admin")
                                                                  : const Text(
                                                                      "Make User"))
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                title: Text(
                                                    userModels[index].name!),
                                                trailing: Text(userModels[index]
                                                    .position!),
                                              )),
                                        )
                                      : const Center(
                                          child: Text("No user exist"),
                                        );
                            },
                            itemCount: userModels.length,
                          ),
                        );
                      }
                    }
                    return const Text("No data");
                  },
                  stream: userinstance.getUsers(),
                );
              },
            ),
          ],
        ));
  }
}
