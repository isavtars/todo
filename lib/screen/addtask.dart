import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:sqllite/utils/sizeconfig.dart';

import '../utils/app_styles.dart';
import 'widgets/customeInpust.dart';
import 'widgets/customebtns.dart';

class AddTaskScreenn extends StatefulWidget {
  const AddTaskScreenn({super.key});

  @override
  State<AddTaskScreenn> createState() => _AddTaskScreennState();
}

class _AddTaskScreennState extends State<AddTaskScreenn> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final dateTimeController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = "10:05 pm";

  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizantal! * 6),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizantal! * 3),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              color: Colors.white,
              height: SizeConfig.blockSizeHorizantal! * 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: SizeConfig.blockSizeHorizantal! * 8,
                    ),
                  ),
                  CircleAvatar(
                    radius: SizeConfig.blockSizeHorizantal! * 5,
                    backgroundColor: kprimarycolor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Text(
              "Add Task",
              style: kQuestrialSemibold.copyWith(
                  color: kprimarycolor,
                  fontWeight: FontWeight.w900,
                  fontSize: SizeConfig.blockSizeHorizantal! * 6),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            CustomeInput(
              titleController: titleController,
              title: "Title",
              hintText: "Go to Gym",
              textinputType: TextInputType.text,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            CustomeInput(
              titleController: noteController,
              title: "Note",
              hintText: "note",
              textinputType: TextInputType.text,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            CustomeInput(
              titleController: dateTimeController,
              title: "Date",
              hintText: DateFormat.yMd().format(_selectedDate),
              textinputType: TextInputType.text,
              isPrefix: true,
              superfixicon: Icons.calendar_today_outlined,
              sufickclassbacl: userDatePickwer,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomeInput(
                    title: "Start Time",
                    hintText: selectedTime.toString(),
                    textinputType: TextInputType.datetime,
                    superfixicon: Icons.access_time_filled_outlined,
                    isPrefix: true,
                    sufickclassbacl: () async {
                      await getTimeFromUser(isStartTime: true);
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CustomeInput(
                    title: "End Time",
                    hintText: endTime,
                    textinputType: TextInputType.datetime,
                    superfixicon: Icons.access_time_filled_outlined,
                    isPrefix: true,
                    sufickclassbacl: () async {
                      await getTimeFromUser(isStartTime: false);
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            //reminder
            CustomeInput(
              titleController: dateTimeController,
              title: "Reminder",
              hintText: "5 minutest",
              textinputType: TextInputType.text,
              isPrefix: true,
              superfixicon: Icons.calendar_today_outlined,
              sufickclassbacl: () {},
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            //reapts
            CustomeInput(
              titleController: dateTimeController,
              title: "Reapete",
              hintText: "None",
              textinputType: TextInputType.text,
              isPrefix: true,
              superfixicon: Icons.calendar_today_outlined,
              sufickclassbacl: () {},
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            //Create task Color
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Colors"),
                  ],
                ),
                CustomeBtn(
                  icons: Icons.create,
                  bthTitles: "Create",
                  onpressed: () {},
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  Future getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await getTimePicker();

    // ignore: use_build_context_synchronously
    String formateTime = DateFormat('hh:mm a').format(pickedTime);

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
    if (pickedTime == null) {
      debugPrint("Time Cancled");
    } else if (isStartTime == true) {
      setState(() {
        startTime = formateTime;
        print(startTime);
      });
    } else if (isStartTime == false) {
      setState(() {
        endTime = formateTime;
        print(endTime);
      });
    }
  }

  getTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: selectedTime
        // initialTime: TimeOfDay(
        //     hour: int.parse(startTime.split(':')[0]),
        //     minute: int.parse(startTime.split(':')[1].split(" ")[0]))
        );
  }

  userDatePickwer() async {
    DateTime? _pickerDate = await showDatePicker(
      // currentDate: DateTime.now(),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2121),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("erroer somthings");
    }
  }
}
