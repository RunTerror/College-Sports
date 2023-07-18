import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserComplaintCard extends StatelessWidget {
  final String day;
  final String status;
  final String name;
  final String roll;
  final String sport;
  final String subject;
  final String description;
  const UserComplaintCard(
      {super.key,
      required this.day,
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
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        roll,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Text(
                    day,
                  )
                ],
              ),
              const Divider(
                height: 5,
                color: Colors.grey,
              ),
              SizedBox(
                height: h / 200,
              ),
              Row(
                children: [
                  const Text(
                    "Sport:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      sport,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              // const Divider(height: 4,),
              SizedBox(
                height: h / 1000,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Details:",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    description,
                    softWrap: false,

                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  )),
                ],
              ),
              SizedBox(
                height: h / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: w / 3,
                    height: h / 20,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: const Text(
                      "Status",
                      style: TextStyle(color: Colors.black),
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
