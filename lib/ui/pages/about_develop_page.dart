import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/utils/constant.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutDevelopPage extends StatelessWidget {
  const AboutDevelopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kPrimaryLightColor,
          ),
        ),
      ),
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // this profile image
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: Dimensions.radius20 * 4.2,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: Dimensions.radius20 * 4,
                    backgroundImage: const AssetImage("assets/images/ann.jpg"),
                  ),
                ),
              ],
            ),
            // this name
            Text(
              "KUN VENG ANN",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: Dimensions.fontSize20,
                ),
              ),
            ),
            // text description personal
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              child: Text(
                "My name's Veng Ann from Cambodia. This App, i'm develop in 2024 when i'm a student during I'm learing at Thái Nguyên Unitversity of Technology vietnames.",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.cyan,
                    fontSize: Dimensions.fontSize20,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
