import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDesign extends StatelessWidget {
  const UserDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              child: Icon(Icons.notifications),
            ),
            Text(
              "تم قبول طلب العمل الدي ارسلته الى ياسين",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
            ),
            Icon(Icons.check , color: Colors.green,)
          ],
        );
  }
}