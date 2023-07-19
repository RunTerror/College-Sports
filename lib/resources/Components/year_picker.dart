import 'package:flutter/material.dart';

class YearPicker{

 static Future flutterYearPicker(BuildContext context) async{
  
  return showDialog(
    context: context,
    builder: (context) {
      final Size size = MediaQuery.of(context).size;
      return AlertDialog(
        title:const Column(
          children:  [
            Text('Select a Year', style: TextStyle(color: Colors.black),),
            Divider(thickness: 1,)
          ],
        ),
        contentPadding: const EdgeInsets.all(10),
        content: SizedBox(
          height: size.height / 3,
          width: size.width,
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 3,
            children: [
              ...List.generate(
                123,
                    (index) => InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 0),
                    child: Chip(
                      label: Container(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          (2022 - index).toString(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}