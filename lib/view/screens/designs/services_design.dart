import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';
import 'package:services/core/constans/app_style.dart';
import 'package:services/view/screens/worker/worker_profile.dart';
import 'package:services/view/widgets/circular_image.dart';
import 'package:services/view/widgets/rating.dart';

// ignore: must_be_immutable
class ServicesDesign extends StatelessWidget {
  String name, disc, job, id, token, location, isOnline, workerImage;
  int rating;
  double long, lat;

  ServicesDesign(
      {super.key,
      required this.name,
      required this.disc,
      required this.lat,
      required this.long,
      required this.workerImage,
      required this.job,
      required this.id,
      required this.token,
      required this.isOnline,
      required this.location,
      this.rating = 2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WorkerProfiles(
                worName: name,
                woId: id,
                lat: lat,
                long: long,
                worJob: job,
                woToken: token,
                rat: rating,
                woLocation: location)));
      },
      child: Card(
        elevation: 0.5,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: Align(
                  alignment: Alignment.topRight,
                  child: isOnline == FirebaseConst.onLine
                      ? isActive(text: "نشط الان", color: Colors.green)
                      : isActive(text: "غير نشط", color: Colors.red)),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child:
                        CircleImage(height: 60, width: 60, id: id, radius: 60),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    name,
                    style:
                        AppStyles.textStyleColor(color: Colors.black, size: 14),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    job,
                    style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RatingWidget(
                      context,
                      ratingNum: rating,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  isActive({required String text, required Color color}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: color,
        ),
        Text(
          text,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 10),
        )
      ],
    );
  }
}
