import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/utils/constant.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';
import 'package:get/get.dart';

class MyInputTextFieldReusable extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? textEditingController;
  final Widget? widget;
  const MyInputTextFieldReusable({
    super.key,
    required this.title,
    required this.hint,
    this.textEditingController,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          SizedBox(height: Dimensions.height5),
          // Container
          Container(
            height: Dimensions.height20 * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // if widget is null set readOnly is false otherwise true
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                    controller: textEditingController,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: subTitleStyle,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width10,
                      ),
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
