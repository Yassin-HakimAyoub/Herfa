import 'package:flutter/material.dart';
import 'package:services/core/constans/enums.dart';

// ignore: must_be_immutable
class ManageDesign extends StatelessWidget {
  String text, path;
  ManageType type;
  IconData icon;
  ManageDesign(
      {super.key,
      required this.text,
      required this.path,
      required this.type,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ControlPanal(
                    ))); */
      },
      child: Card(
        elevation: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
