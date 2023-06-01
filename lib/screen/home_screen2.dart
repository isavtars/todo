import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sqllite/utils/sizeconfig.dart';

import '../utils/app_styles.dart';

import 'addtask.dart';
import 'widgets/customebtns.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  DateTime selecteddate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizantal! * 6),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizantal! * 3),
        child: Column(children: [
          //header
          header(icon: Icons.light),
          SizedBox(
            height: SizeConfig.blockSizeHorizantal! * 1.8,
          ),
          //aadtask
          _addtask(),

          Container(
            // height: SizeConfig.blockSizeHorizantal! * 25,
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 70,
              initialSelectedDate: DateTime.now(),
              selectedTextColor: Colors.white,
              selectionColor: kprimarycolor,
              dateTextStyle: kQuestrialSemibold.copyWith(
                  fontSize: SizeConfig.blockSizeHorizantal! * 5),
              onDateChange: (seldate) {
                setState(() {
                  selecteddate = seldate;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text('${DateFormat("hh:mm a").format(selecteddate)}'),
           Text('${DateFormat.yMd().format(selecteddate)}')
        ]),
      ),
    );
  }

//header
  Container header({required IconData icon}) {
    return Container(
      color: Colors.white,
      height: SizeConfig.blockSizeHorizantal! * 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.dark_mode,
            size: SizeConfig.blockSizeHorizantal! * 8,
          ),
          CircleAvatar(
            radius: SizeConfig.blockSizeHorizantal! * 5,
            backgroundColor: kprimarycolor,
          )
        ],
      ),
    );
  }

  //aadtask
  Container _addtask() {
    return Container(
      height: SizeConfig.blockSizeHorizantal! * 20,
      width: double.maxFinite,
      // color: Colors.red,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "September 19,2021",
                  style: kQuestrialMedium.copyWith(
                      fontSize: SizeConfig.blockSizeHorizantal! * 6),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 1.8,
                ),
                Text("Today",
                    style: kQuestrialBold.copyWith(
                        fontSize: SizeConfig.blockSizeHorizantal! * 6))
              ],
            ),

            //btn
            CustomeBtn(
              icons: Icons.add,
              bthTitles: "Add Task",
              onpressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTaskScreenn()));
              },
              height: SizeConfig.blockSizeVertical! * 7,
              width: SizeConfig.blockSizeHorizantal! * 37,
            ),
          ],
        )
      ]),
    );
  }
}
