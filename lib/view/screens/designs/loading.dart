import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: ListView.builder(itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[200],
            ),
            title: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding:const EdgeInsets.all(5),
                      height: 10,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding:const EdgeInsets.all(5),
                      height: 10,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                  ],
                ))
              ],
            ),
          );
        }));
  }
}
