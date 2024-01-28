import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/controller/themes_controller.dart';
import 'package:flutter_schedule_with_sqlite/services/notification_helper.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // ignore: prefer_typing_uninitialized_variables
  var notificationHelper;

  @override
  void initState() {
    super.initState();

    // when start this page initialized the controller getx
    Get.put(ThemeController());

    // initialize NotificationHelper
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // button back
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text("S E T T I N G S"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            // dark mode
            const Text("Dark Mode "),

            // swith button
            GetBuilder<ThemeController>(
              builder: (themeController) {
                return CupertinoSwitch(
                  value: themeController.isDark,
                  onChanged: (value) {
                    themeController.toggleDarkLigthMode(value);

                    // show notification when change themes
                    notificationHelper.displayNotification(
                      title: "Themes changed",
                      body: themeController.isDark
                          ? "Activated dark mode"
                          : "Activated ligth mode",
                    );
                    // Get the current time
                    DateTime now = DateTime.now();

                    // Schedule notification with a 5-second delay
                    DateTime scheduleDate = now.add(Duration(seconds: 5));

                    //notificationHelper.scheduledNotification();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
