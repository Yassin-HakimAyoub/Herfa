import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorkerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black38,
      highlightColor: Colors.grey,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      height: 10,
                      width: 70,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      height: 10,
                      width: 70,
                      color: Colors.white,
                    )
                  ],
                ))
              ],
            );
          }),
    );
  }
}
