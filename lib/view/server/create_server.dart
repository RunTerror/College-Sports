import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/resources/Colors/colors.dart';
import 'package:sports_application/utils/utils.dart';
import 'package:sports_application/view_model/get_members.dart';

class CreateServer extends StatefulWidget {
  final List<Map<String, dynamic>> membersList;
  final String name;
  const CreateServer(
      {super.key, required this.membersList, required this.name});

  @override
  State<CreateServer> createState() => _CreateServerState();
}

class _CreateServerState extends State<CreateServer> {
  bool isLoading = false;
  final TextEditingController _createName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final getmembers = Provider.of<GetMembersProvider>(context, listen: false);
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group name"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _createName,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Server name"),
            ),
          ),
          SizedBox(
            height: h / 2,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text('${getmembers.selectedList[index]['name']}'),
                  subtitle: Text('${getmembers.selectedList[index]['email']}'),
                );
              },
              itemCount: getmembers.selectedList.length,
            ),
          ),
          InkWell(
            onTap: () async {
              if (_createName.text.isEmpty) {
                Utils.flushbarErrorMessage("Please add group name", context);
              } else {
                setState(() {
                  isLoading = true;
                });
                await getmembers.createServer(
                    widget.membersList, _createName.text, widget.name);
                setState(() {
                  isLoading = false;
                });
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: h / 20,
              width: w / 1.2,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: ExternalColors.lightgreen),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Create"),
            ),
          )
        ],
      ),
    );
  }
}
