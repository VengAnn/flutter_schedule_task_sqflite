import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/controller/themes_controller.dart';
import 'package:flutter_schedule_with_sqlite/database/db_helper.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/home_page.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/themes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); //this initialize getStorage
  await DBHelper.initDb(); // this initialize sqflite
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //initialize themecontrolle
    final ThemeController themeController = Get.put(ThemeController());
    themeController.loadTheme();

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeCustom.ligthMode, //light
          darkTheme: ThemeCustom.darkMode, //dark
          themeMode: themeController.isDark ? ThemeMode.dark : ThemeMode.light,
          home: const HomePage(),
        );
      },
    );
  }
}
