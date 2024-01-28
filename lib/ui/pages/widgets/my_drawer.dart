import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/setting_page.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.theme.primaryColor,
      child: Column(
        children: [
          // Header Drawer
          const DrawerHeader(
            child: Icon(Icons.person),
          ),

          // home tilte
          Padding(
            padding: EdgeInsets.only(top: Dimensions.height10, left: 15.0),
            child: const ListTile(
              title: Text("home"),
              leading: Icon(Icons.home),
            ),
          ),

          // settings
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const SettingPage());
              },
              child: const ListTile(
                title: Text("settings"),
                leading: Icon(Icons.settings),
              ),
            ),
          )
        ],
      ),
    );
  }
}
