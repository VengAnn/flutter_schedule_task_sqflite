import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/controller/task_controller.dart';
import 'package:flutter_schedule_with_sqlite/models/task_model.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/widgets/my_button.dart';
import 'package:flutter_schedule_with_sqlite/ui/pages/widgets/my_input_fild_reusable.dart';
import 'package:flutter_schedule_with_sqlite/utils/constant.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  // initialize controller we using getx statemanagement
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int selectedIndexColor = 0;

  DateTime _selectedDate = DateTime.now();
  // ignore: prefer_final_fields
  String _endTime = "9:30 PM";
  // ignore: prefer_final_fields
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemider = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None",
    "Dialy",
    "Weekly",
    "Monthly",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.width10),
          child: Column(
            children: [
              MyInputTextFieldReusable(
                title: "Tittle",
                hint: "Enter title here",
                textEditingController: _titleController,
              ),
              MyInputTextFieldReusable(
                title: "Note",
                hint: "Enter note here",
                textEditingController: _noteController,
              ),
              MyInputTextFieldReusable(
                title: "Date",
                // format _selectedDate obj to string MM/DD/YYYY
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    // when click show Date Picker
                    _getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),

              //this Row have two expanded
              Row(
                children: [
                  Expanded(
                    child: MyInputTextFieldReusable(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.timer_rounded),
                      ),
                    ),
                  ),
                  //sizedbox
                  SizedBox(width: Dimensions.width10),
                  Expanded(
                    child: MyInputTextFieldReusable(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(Icons.timer_outlined),
                      ),
                    ),
                  ),
                ],
              ),

              //Remind
              MyInputTextFieldReusable(
                title: "Remind",
                hint: "$_selectedRemider minutes ealy",
                widget: DropdownButton(
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  items: remindList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.toString(),
                          child: Text(
                            e.toString(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemider = int.parse(newValue!);
                    });
                  },
                ),
              ),
              //Repeat
              MyInputTextFieldReusable(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  // loop all element in repeatList one by one to drowDownMenu Items
                  items: repeatList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(height: Dimensions.height20),

              //Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallet(),
                  // button create Task
                  MyButton(
                    label: "Create Task",
                    ontap: () {
                      _validateDate();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // add to database
      _addTaskToDB();

      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.pink,
        backgroundColor: kPrimaryLightColor,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }

  _addTaskToDB() async {
    //add to sqflite
    int value = await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemider,
        repeat: _selectedRepeat,
        color: selectedIndexColor,
        isCompleted: 0,
      ),
    );
    debugPrint("id in db is $value");
  }

  // ColorsPallete select
  _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        //select colors
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              return Padding(
                padding: EdgeInsets.only(right: Dimensions.width5 / 2),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndexColor = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: Dimensions.radius15,
                    backgroundColor: index == 0
                        ? bluishClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: selectedIndexColor == index
                        ? Icon(
                            Icons.done,
                            size: Dimensions.height5 * 2.5,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // getDate From input user
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2121),
    );

    // check
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        debugPrint("picker time's: $_selectedDate");
      });
    } else {
      debugPrint("it's null or something is wrong!");
    }
  }

  // appBar
  PreferredSizeWidget? _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.colorScheme.background,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      //
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Dimensions.width5 * 2),
          child: CircleAvatar(
            radius: Dimensions.radius15,
            backgroundColor: context.theme.colorScheme.primary,
            child: const Icon(
              Icons.person,
              color: kDarkGreyClr,
            ),
          ),
        ),
      ],
    );
  }

  // get Time from user
  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();
    if (pickerTime == null) {
      debugPrint("Time canceld");
    } else {
      // this formate picktime to hh:mm a
      // ignore: use_build_context_synchronously
      String formatedTime = pickerTime.format(context);
      if (isStartTime == true) {
        setState(() {
          _startTime = formatedTime;
        });
      } else if (isStartTime == false) {
        setState(() {
          _endTime = formatedTime;
        });
      }
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        // startTime -> 10:45 AM
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
