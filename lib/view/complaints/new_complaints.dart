import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/Routes/route_names.dart';

import '../../resources/Components/admin_complaint_card.dart';
import '../../view_model/complaints_provider.dart';

class NewComplaints extends StatelessWidget {
  const NewComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.only(top: 20),
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
                List<Complaint> waitingComplaints = [];
                for (Complaint doc in data!) {
                  if (doc.status == 'waiting') {
                    waitingComplaints.add(doc);
                  }
                }
                if (waitingComplaints.isEmpty) {
                  return const Center(
                    child: Text("No new Complaints"),
                  );
                }
                return ListView.builder(
                    itemBuilder: (context, index) {
                      var com = waitingComplaints[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.detailedComplaint, arguments: com);
                          },
                          child: AdminComplaintCard(
                            date: com.day!,
                              complaintid: com.complaintId!,
                              description: com.desciption!,
                              name: com.name!,
                              roll: com.roll!,
                              sport: com.sport!,
                              subject: com.subject!),
                        ),
                      );
                    },
                    itemCount: waitingComplaints.length);
              }
              return const Center(
                child: Text("Complaint Screen"),
              );
            },
            stream: complaintObj.getComplaints(),
          );
        },
      ),
    );
  }
}
