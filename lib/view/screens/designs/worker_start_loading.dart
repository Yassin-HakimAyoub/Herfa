import 'package:flutter/material.dart';
import 'package:services/core/functions/size_func.dart';

class WorkerStartLoading extends StatelessWidget {
  const WorkerStartLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: screenHeight(context) * 0.20,
            decoration: const BoxDecoration(),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: 70,
                      height: 10,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                    Container(
                      width: 70,
                      height: 10,
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                width: screenWidth(context) / 2 - 10,
                height: 50,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                width: screenWidth(context) / 2 - 10,
                height: 50,
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
