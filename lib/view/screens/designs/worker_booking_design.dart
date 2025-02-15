import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:services/core/functions/func.dart';

// ignore: must_be_immutable
class WorkerBookingDesign extends StatelessWidget {
  String name, type, location, problemText, id, senderId, time, services;
  int diBetween;
  WorkerBookingDesign(
      {super.key,
      required this.name,
      required this.type,
      required this.services,
      required this.location,
      required this.diBetween,
      required this.problemText,
      required this.id,
      required this.senderId,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "لقد استلمت طلب عمل",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            ),
            Text(
              "ارسل إليك $name طلب عمل الرجاء الرد على الطلب",textAlign: TextAlign.start,
              style: const TextStyle(
                  fontFamily: 'Cairo', fontSize: 12, color: Colors.black87),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    displayData(context,
                        name: name,
                        id: id,
                        disBetween:diBetween ,
                        ourservices: services,
                        type: type,
                        location: location,
                        senderId: senderId,
                        problemText: problemText);
                  },
                  child: const Text(
                    "عرض تفاصيل الطلب",
                    style: TextStyle(
                        fontFamily: 'Cairo', fontSize: 14, color: Colors.blue),
                  ),
                ),
                Text(
                  Jiffy.parse(time).fromNow(),
                  style: const TextStyle(
                      fontFamily: 'Cairo', fontSize: 12, color: Colors.black54),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
