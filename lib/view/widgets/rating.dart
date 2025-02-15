import 'package:flutter/material.dart';
import 'package:services/core/functions/size_func.dart';

// ignore: must_be_immutable
class RatingWidget extends StatelessWidget {
  int ratingNum;
  double si = 18;
  RatingWidget(BuildContext context, {super.key, required this.ratingNum});

  @override
  Widget build(BuildContext context) {
    return ratingNum <= 10
        ? Stars.oneStart(context)
        : ratingNum <= 20
            ? Stars.twoStars()
            : ratingNum <= 30
                ? Stars.threeStars()
                : ratingNum <= 40
                    ? Stars.forStars()
                    : ratingNum <= 50
                        ? Stars.fiveStars()
                        : Stars.oneStart(context);
  }
}

// ignore: must_be_immutable
class CommintRating extends StatelessWidget {
  int ratingNum;
  CommintRating({super.key, required this.ratingNum});

  @override
  Widget build(BuildContext context) {
    return ratingNum == 1
        ? Stars.oneStart(context)
        : ratingNum == 2
            ? Stars.twoStars()
            : ratingNum == 3
                ? Stars.threeStars()
                : ratingNum == 4
                    ? Stars.forStars()
                    : Stars.fiveStars();
  }
}

class Stars {
  static double IconSize = 18;
  static oneStart(BuildContext context) {
    return SizedBox(
      width: screenWidth(context) * 0.40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star_outlined,
            color: Colors.yellow,
            size: IconSize,
          ),
          Icon(
            Icons.star_outlined,
            color: Colors.grey,
            size: IconSize,
          ),
          Icon(
            Icons.star_outlined,
            color: Colors.grey,
            size: IconSize,
          ),
          Icon(
            Icons.star_outlined,
            color: Colors.grey,
            size: IconSize,
          ),
          Icon(
            Icons.star_outlined,
            color: Colors.grey,
            size: IconSize,
          )
        ],
      ),
    );
  }

  static twoStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.grey,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.grey,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.grey,
          size: IconSize,
        )
      ],
    );
  }

  static threeStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.grey,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.grey,
          size: IconSize,
        )
      ],
    );
  }

  static forStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.grey,
          size: IconSize,
        )
      ],
    );
  }

  static fiveStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: IconSize,
        )
      ],
    );
  }
}
