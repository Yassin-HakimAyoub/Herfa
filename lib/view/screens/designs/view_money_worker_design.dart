import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:services/core/constans/app_style.dart';

// ignore: must_be_immutable
class ViewMoneyWorkerDesign extends StatelessWidget {
  String userId, time, username;
  Function() click;
  ViewMoneyWorkerDesign(
      {super.key,
      required this.click,
      required this.userId,
      required this.time,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "لقد ارسلت فاتورة عمل الى $username",
                    style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  )
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  Jiffy.parse(time).fromNow(),
                  style:
                      AppStyles.textStyleColor(color: Colors.black, size: 10),
                ),
                SizedBox(
                  width: 10,
                ),
                const Text(
                  "في انتظار قبول الفاتورة و تقييم عملك",
                  style: TextStyle(
                      fontFamily: 'Cairo', fontSize: 10, color: Colors.black87),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            )
          ],
        ),
      ),
    );
  }
}
