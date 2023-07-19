import 'package:flutter/material.dart';
import 'package:sports_application/resources/Components/action_button.dart';

// ignore: must_be_immutable
class HoldComplaintCard extends StatelessWidget {
  String date;
  String complaintId;
  String status;
  String name;
  String roll;
  String sport;
  String subject;
  String description;
  HoldComplaintCard(
      {super.key,
      required this.date,
      required this.complaintId,
      required this.status,
      required this.description,
      required this.name,
      required this.roll,
      required this.sport,
      required this.subject});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          height: h / 3,
          width: w,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        roll,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Text(date)
                ],
              ),
              SizedBox(
                height: h / 50,
              ),
              const Divider(
                height: 5,
                color: Colors.grey,
              ),
              SizedBox(
                height: h / 100,
              ),
              Row(
                children: [
                  Text(
                    sport,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '($subject)',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h / 100,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    description,
                    softWrap: false,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
              SizedBox(
                height: h / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        return  AlertDialog(
                          content:const  Text("Update Status"),
                          actions: [
                            ActionButton(status: "Done", icon: Icons.done, compalintId: complaintId),
                            ActionButton(status: "Cancel", icon: Icons.cancel_outlined, compalintId: complaintId)
                          ],
                        );
                      },);

                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: w / 3,
                      height: h / 20,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: const Text(
                        "Update status",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: w / 3,
                    height: h / 20,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        border: Border.all(
                          color: status == "Done" ? Colors.green : Colors.red,
                          width: 1,
                        )),
                    child: Text(
                      status,
                      style: TextStyle(
                          color: status == "Done" ? Colors.green : Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
