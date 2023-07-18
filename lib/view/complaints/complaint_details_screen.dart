import 'package:flutter/material.dart';

import '../../view_model/complaints_provider.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  final Complaint complaintDetails;
  const ComplaintDetailsScreen({super.key, required this.complaintDetails});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    final status = complaintDetails.status!;

    return Scaffold(
      appBar: AppBar(
        title: Text(complaintDetails.sport!),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        // alignment: Alignment.center,
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Subject: ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              complaintDetails.subject!,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "User Details : ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              complaintDetails.name!,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              complaintDetails.roll!,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              complaintDetails.day!,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Complaint : ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              complaintDetails.desciption!,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 20,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Status ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              complaintDetails.status!,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: status == 'waiting'
                    ? Colors.red
                    : status == 'Hold'
                        ? const Color.fromARGB(255, 255, 191, 0)
                        : status == 'Cancel'
                            ? Colors.red
                            : status == 'Done'
                                ? Colors.green
                                : Colors.black,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
