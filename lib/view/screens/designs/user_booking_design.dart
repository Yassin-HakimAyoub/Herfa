import 'package:flutter/material.dart';
import 'package:services/core/constans/Constans.dart';

// ignore: must_be_immutable
class UserBoolingDesign extends StatelessWidget {
  String name, type;
  UserBoolingDesign({super.key, required this.name, required this.type});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          ),
          title: Text(
            "لقد ارسلت طلب عمل الى $name",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 12),
          ),
          subtitle: Center(
            child: type == FirebaseConst.bookingWait
                ? const Text(
                    "في انتظار الرد ...",
                    style: TextStyle(
                        fontFamily: 'Cairo', fontSize: 13, color: Colors.black),
                  )
                : type == FirebaseConst.bookingOk
                    ? const Text(
                        "تم قبول طلبك",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            color: Colors.green),
                      )
                    : const Text(
                        "تم رفض طلبك",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            color: Colors.red),
                      ),
          ),
          trailing: type == FirebaseConst.bookingWait
              ? const Icon(
                  Icons.watch_later_outlined,
                  size: 20,
                  color: Colors.blue,
                )
              : type == FirebaseConst.bookingOk
                  ? const Icon(
                      Icons.done_all,
                      size: 20,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.clear_rounded,
                      size: 20,
                      color: Colors.red,
                    ),
        ),
      ),
    );
  }
}

bookingDesign(BuildContext context,
    {required String name, required String type}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                    "لقد ارسلت طلب عمل الى $name",
                    style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              type == FirebaseConst.bookingWait
                  ? const Icon(
                      Icons.watch_later_outlined,
                      size: 20,
                      color: Colors.blue,
                    )
                  : type == FirebaseConst.bookingOk
                      ? const Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.clear_rounded,
                          size: 20,
                          color: Colors.red,
                        )
            ],
          ),
          Center(
            child: type == FirebaseConst.bookingWait
                ? const Text(
                    "في انتظار الرد ...",
                    style: TextStyle(
                        fontFamily: 'Cairo', fontSize: 13, color: Colors.black),
                  )
                : type == FirebaseConst.bookingOk
                    ? const Text(
                        "تم قبول الطلب",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            color: Colors.green),
                      )
                    : const Text(
                        "تم رفض الطلب",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13,
                            color: Colors.red),
                      ),
          )
        ],
      ),
    ),
  );
}
