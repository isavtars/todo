import 'package:flutter/material.dart';
import 'package:sqllite/utils/app_styles.dart';

class CustomeBtn extends StatelessWidget {
  const CustomeBtn(
      {super.key,
      required this.icons,
      required this.bthTitles,
      this.height = 50.0,
      this.width = 100.0,
      this.color = kprimarycolor,
      required this.onpressed});

  final IconData icons;
  final String bthTitles;
  final double height;
  final double width;
  final VoidCallback onpressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(22)),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                size: 22,
                color: Colors.white,
              ),
              Text(
                bthTitles,
                style: kQuestrialMedium.copyWith(
                    color: Colors.white, fontSize: 18),
              )
            ]),
      ),
    );
  }
}
