import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sqllite/utils/sizeconfig.dart';

import '../logic/themchanger.dart';
import '../utils/app_styles.dart';

import 'addtask.dart';
import 'widgets/customebtns.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

List<String> dropedown_items = ["5", "10", "15", "20"];
bool changevalue = false;
final changeThemes = Get.find<ThemModeChange>();

class _HomeScreen2State extends State<HomeScreen2> {
  DateTime selecteddate = DateTime.now();
  String dropdownValue = dropedown_items.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizantal! * 8),
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
          Text(DateFormat("hh:mm a").format(selecteddate)),
          const SizedBox(
            height: 10,
          ),
          Text(DateFormat.yMd().format(selecteddate)),
          const SizedBox(
            height: 10,
          ),
          Text(dropdownValue),
          const SizedBox(
            height: 10,
          ),

          DropdownButton<String>(
            value: dropdownValue,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            icon: const Icon(Icons.keyboard_arrow_down),
            items:
                dropedown_items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
          )
        ]),
      ),
    );
  }

//header
  Container header({required IconData icon}) {
    return Container(
      height: SizeConfig.blockSizeHorizantal! * 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              print(changeThemes.isDarkMode(context));
              if (changeThemes.isDarkMode(context) == true) {
                setState(() {
                  changevalue = false;
                });
              } else {
                setState(() {
                  changevalue = true;
                });
              }
              changeThemes.switchTheme(changevalue);
            },
            icon: changeThemes.isDarkMode(context) == true
                ? Icon(
                    Icons.light_mode,
                    color: changevalue == false ? Colors.black : Colors.white,
                    size: SizeConfig.blockSizeHorizantal! * 8,
                  )
                : Icon(
                    Icons.dark_mode,
                    color: changevalue == false ? Colors.black : Colors.white,
                    size: SizeConfig.blockSizeHorizantal! * 8,
                  ),
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
        ),
      ]),
    );
  }
}
