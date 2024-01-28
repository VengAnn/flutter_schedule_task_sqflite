import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.grey,
          ),
        ),
        // ignore: unnecessary_this
        title: Text(
          this.label.toString().split("|")[0],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          width: Dimensions.width10 * 30,
          height: Dimensions.height20 * 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            color: Get.isDarkMode ? Colors.white : Colors.grey[400],
          ),
          child: Center(
            child: Text(
              // this split to get note task form notification pyload
              // ignore: unnecessary_this
              this.label.toString().split("|")[1],
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.black
                    : Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
