import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/controller/task_controller.dart';
import 'package:flutter_schedule_with_sqlite/controller/themes_controller.dart';
import 'package:flutter_schedule_with_sqlite/models/task_model.dart';
import 'package:flutter_schedule_with_sqlite/services/notification_helper.dart';
import 'package:flutter_schedule_with_sqlite/ui/add_task_page.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/widgets/my_button.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/widgets/my_drawer.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/widgets/task_tile.dart';
import 'package:flutter_schedule_with_sqlite/utils/constant.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var notificationHelper;

  // Declare and initialize
  DateTime selectedDate = DateTime.now();

  // initialize controller we using getx statemanagement
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();

    // initialize
    notificationHelper = NotificationHelper();
    notificationHelper.initializeNotification();
    notificationHelper.requestIOSPermissions();

    //when app start call
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    final themController = Get.put(ThemeController());

    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : kPrimaryLightColor,
      //appBar
      appBar: _appBar(themController),
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      body: Column(
        children: [
          // add task
          _addTask(),
          //Date picker timeLine
          _addDateBar(),
          //
          SizedBox(height: Dimensions.height10),
          //show tasks
          _showTasks(),
        ],
      ),
    );
  }

  //show tasks
  _showTasks() {
    return Expanded(
      child: GetBuilder<TaskController>(
        builder: (taskController) {
          return ListView.builder(
            itemCount: taskController.taskList.length,
            itemBuilder: (context, index) {
              Task task = taskController.taskList[index];
              //print(task.toJson());
              // check is repeat Dialy alert noti all day
              if (task.repeat == 'Dialy') {
                DateTime date = DateFormat("h:mm a").parse(
                  task.startTime.toString().trim(),
                );
                var myTime = DateFormat("HH:mm").format(date);

                notificationHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task,
                );
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (task.repeat == "None") {
                DateTime date = DateFormat("h:mm a").parse(
                  task.startTime.toString().trim(),
                );
                var myTime = DateFormat("HH:mm").format(date);

                notificationHelper.scheduleSingleNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  task,
                );
              }
              // task date date set in task equal to selectedDate
              if (task.date == DateFormat.yMd().format(selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  //bottomSheet
  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: Dimensions.height5),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? kDarkGreyClr : kPrimaryLightColor,
        child: Column(
          children: [
            Container(
              height: Dimensions.height5,
              width: Dimensions.width20 * 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const Spacer(),
            // if task completed = 1
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    lable: "Task Completed",
                    context: context,
                    clr: Colors.amber,
                    isClose: false,
                    ontap: () {
                      debugPrint("isCompleted");
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                  ),
            _bottomSheetButton(
              lable: "Delete Task",
              context: context,
              clr: Colors.red,
              isClose: false,
              ontap: () {
                debugPrint("delele");
                _taskController.delele(task);

                Get.back();
              },
            ),
            SizedBox(height: Dimensions.height10),
            _bottomSheetButton(
              lable: "Close",
              context: context,
              clr: Colors.amber,
              isClose: true,
              ontap: () {
                Get.back();
              },
            ),
            SizedBox(height: Dimensions.height10),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String lable,
    required Function()? ontap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.height5),
        height: Dimensions.height10 * 5,
        width: Dimensions.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            lable,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  //picker time Line
  Widget _addDateBar() {
    // ignore: avoid_unnecessary_containers
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width5 * 2),
      child: DatePicker(
        DateTime.now(), //parameter start is dateTime now
        height: Dimensions.height20 * 5,
        width: Dimensions.width10 * 8, //width80
        initialSelectedDate: DateTime.now(),
        selectionColor: kPrimaryColor,
        selectedTextColor: kPrimaryLightColor,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: Dimensions.fontSize15,
            fontWeight: FontWeight.w600,
            color: kDarkGreyClr,
          ),
        ),
        //month
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: Dimensions.fontSize15,
            fontWeight: FontWeight.w600,
            color: kDarkGreyClr,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }

  // appBar
  PreferredSizeWidget? _appBar(ThemeController themController) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      title: const Text("Task Schedule APP"),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Dimensions.width5 * 2),
          child: CircleAvatar(
            radius: Dimensions.radius15,
            backgroundColor:
                themController.isDark ? kPrimaryColor : kPrimaryLightColor,
            child: const Icon(
              Icons.person,
              color: kDarkGreyClr,
            ),
          ),
        ),
      ],
    );
  }

  // this part is for add Task
  Widget _addTask() {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.width10,
        right: Dimensions.width10,
        top: Dimensions.width10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DatTime format
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          //Button add task
          MyButton(
            label: "Add Task",
            ontap: () async {
              // we await to getTask list sqflite when go to Add Task page and back we call getTasks()
              await Get.to(() => const AddTaskPage());
              _taskController.getTasks();
            },
          ),
        ],
      ),
    );
  }
}
