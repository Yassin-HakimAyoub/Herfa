import 'package:flutter/material.dart';
import 'package:services/core/constans/data_list.dart';
import 'package:services/core/constans/strings.dart';
import 'package:services/core/functions/size_func.dart';
import 'package:services/view/screens/user/user_start_screen.dart';

class AllServices extends StatelessWidget {
  const AllServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.services,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: screenWidth(context),
        height: screenHeight(context),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemCount: ListData.allser.length,
            itemBuilder: (context, index) {
              return serviceCard(
                context,
                text: ListData.allser[index].getText,
                image: ListData.allser[index].getImage,
                path: ListData.allser[index].path,
              );
            }),
      ),
    );
  }
}
