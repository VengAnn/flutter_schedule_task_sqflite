import 'package:flutter/material.dart';
import 'package:flutter_schedule_with_sqlite/utils/constant.dart';
import 'package:flutter_schedule_with_sqlite/utils/dimensions.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? ontap;
  const MyButton({
    required this.label,
    this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: Dimensions.width20 * 5,
        height: Dimensions.height20 * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: kPrimaryColor,
        ),
        child: Center(
          child: Text(label),
        ),
      ),
    );
  }
}
