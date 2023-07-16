import 'package:flutter/material.dart';
import 'package:sports_application/resources/Components/action_button.dart';

class ComplaintCard extends StatelessWidget {
  final String complaintid;
  final String name;
  final String roll;
  final String sport;
  final String subject;
  final String description;
  const ComplaintCard(
      {super.key,
      required this.complaintid,
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
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                  )
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                TextButton(onPressed: (){
                  showDialog(context: context, builder: (context) {
                    return  AlertDialog(
                      content:const Text("Update Status"),
                      actions: [
                        ActionButton( status: "Done", icon: Icons.done,compalintId: complaintid),
                        ActionButton( status: "Hold", icon: Icons.stop,compalintId: complaintid,),
                        ActionButton( status: "Cancel", icon: Icons.cancel,compalintId: complaintid,)
                      ],
                    );
                  },);
                }, child:const Text("Respond"))
              ],)
            ],
          ),
        ),
      ],
    );
  }
}
