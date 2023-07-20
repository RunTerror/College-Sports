import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_application/utils/Routes/route_names.dart';
import 'package:sports_application/view/complaints/hold_complaint_card.dart';
import 'package:sports_application/view/complaints/spinkit.dart';
import '../../view_model/complaints_provider.dart';

class HoldComplaints extends StatelessWidget {
  const HoldComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ComplaintProvider>(
        builder: (context, complaintObj, child) {
          return StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingKit.spinkit;
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final complaintsList = snapshot.data;
                final List<Complaint> filteredComplaints = [];
                for (Complaint complaint in complaintsList!) {
                  if (complaint.status == 'Hold') {
                    filteredComplaints.add(complaint);
                  }
                }
                if (filteredComplaints.isEmpty) {
                  return const  Center(child: Text("No hold Complaints"));
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final com = filteredComplaints[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.detailedComplaint, arguments: com);
                        },
                        child: HoldComplaintCard(
                          date: com.day!,
                          complaintId: com.complaintId!,
                            status: com.status!,
                            description: com.desciption!,
                            name: com.name!,
                            roll: com.roll!,
                            sport: com.sport!,
                            subject: com.subject!),
                      ),
                    );
                  },
                  itemCount: filteredComplaints.length,
                );
              }
              return const Center(
                child: Text("No Updated Complaints"),
              );
            },
            stream: complaintObj.getComplaints(),
          );
        },
      ),
    );
  }
}
