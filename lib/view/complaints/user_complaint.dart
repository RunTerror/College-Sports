import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../resources/Components/user_complaint_card.dart';
import '../../utils/Routes/route_names.dart';
import '../../view_model/complaints_provider.dart';

class UserComplaintScreen extends StatefulWidget {
  const UserComplaintScreen({super.key});

  @override
  State<UserComplaintScreen> createState() => _UserComplaintScreenState();
}

class _UserComplaintScreenState extends State<UserComplaintScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.maxFinite,
          color: theme.colorScheme.primary,
        ),
        Positioned(
            right: 10,
            top: 30,
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.addComplaint);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))),
        Positioned(
            top: h / 8,
            child: SingleChildScrollView(
                child: Container(
              height: 7 * h / 8 - 75,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 30),
              width: w,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Consumer<ComplaintProvider>(
                builder: (context, complaintObj, child) {
                  return StreamBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        var data = snapshot.data;
                        if(data!.isNotEmpty){
                          return ListView.builder(

                            itemBuilder: (context, index) {
                              var com = data[index];

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            RouteNames.detailedComplaint,
                                            arguments: com);
                                      },
                                      child: UserComplaintCard(
                                          day: com.day!,
                                          status: com.status!,
                                          description: com.desciption!,
                                          name: com.name!,
                                          roll: com.roll!,
                                          sport: com.sport!,
                                          subject: com.subject!),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                            itemCount: snapshot.data!.length);
                      }
                      else{
                        return const Center(child: Text("Add Complaints!", style: TextStyle(fontSize: 20, ),),);
                      }

                        }
                        
                      return const Center(
                        child: Text("Complaint Screen"),
                      );
                    },
                    stream: complaintObj.getComplaints(),
                  );
                },
              ),
            )))
      ]),
    );
  }
}
