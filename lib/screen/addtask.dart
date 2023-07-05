import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:sqllite/logic/task_controller.dart';
import 'package:sqllite/models/task_models.dart';
import 'package:sqllite/screen/home_screen2.dart';
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

  DateTime _selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = "10:05 pm";
  final List<String> dropedownitems = ["5", "10", "15", "20"];
  final List<String> reapeatlist = ["None", "Daily", "Weekly", "monthly"];
  final List<Color> colorList = [Colors.red, Colors.green, Colors.blue];

  String reminderdropvalue = "seleCted Value";
  String reaptedropvalue = "None";
  int selectecolor = 0;

  TimeOfDay selectedTime = TimeOfDay.now();
  final _task_controller = Get.find<TaskController>();

  //_addTaskToDb
  _addTaskToDb() async {
    if (titleController.text.isNotEmpty || noteController.text.isNotEmpty) {
      int value = await _task_controller.addToTask(
          task: Task(
        title: titleController.text,
        note: noteController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: startTime,
        endTime: endTime,
        reminder: "heloo dailly",
        reapert: reaptedropvalue,
        color: selectecolor,
        isComplited: 0,
      ));

      print("'---------------------- $value --------------------------------");

      Get.to(const HomeScreen2());
    } else {
      Get.snackbar("Required all the feilds", "Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.blockSizeHorizantal! * 1),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizantal! * 3),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
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
                        Icons.keyboard_arrow_left,
                        color: kprimarycolor,
                        size: SizeConfig.blockSizeHorizantal! * 9,
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
                isMuliline: true,
              ),

              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),
              CustomeInput(
                title: "Date",
                hintText: DateFormat.yMd().format(_selectedDate),
                textinputType: TextInputType.text,
                isPrefix: true,
                superfixicon: Icons.calendar_today_outlined,
                sufickcallback: userDatePicker,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),

              //startrime/endtime
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomeInput(
                      title: "Start Time",
                      hintText: startTime,
                      textinputType: TextInputType.datetime,
                      superfixicon: Icons.access_time_filled_outlined,
                      isPrefix: true,
                      sufickcallback: () async {
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
                      sufickcallback: () async {
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
              CustomeInputWithdrop(
                  title: "Reminder",
                  hintText: "$reminderdropvalue minutesearly",
                  // suffixIcon: Icons.keyboard_arrow_down,
                  suffix: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      elevation: 0,
                      iconSize: 32,
                      style: kQuestrialRegular.copyWith(
                          color: kprimarycolor, fontSize: 18),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: kprimarycolor,
                      ),
                      items: dropedownitems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: kQuestrialRegular.copyWith(
                                fontSize: 18, color: kprimarycolor),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          reminderdropvalue = value!;
                        });
                      },
                    ),
                  )),

              SizedBox(
                height: SizeConfig.blockSizeVertical! * 2,
              ),

              //reapts
              CustomeInputWithdrop(
                  title: "Reapate",
                  hintText: reaptedropvalue,
                  // suffixIcon: Icons.keyboard_arrow_down,
                  suffix: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      elevation: 1,
                      iconSize: 32,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: kprimarycolor,
                      ),
                      items: reapeatlist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: kQuestrialRegular.copyWith(
                                fontSize: 18, color: kprimarycolor),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          reaptedropvalue = value!;
                        });
                      },
                    ),
                  )),

              SizedBox(
                height: SizeConfig.blockSizeVertical! * 3,
              ),

              //Create task Color
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                      children: List.generate(3, (int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectecolor = index;
                        });
                      },
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: colorList[index],
                            child: selectecolor == index
                                ? const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : null,
                          )),
                    );
                  })),
                  CustomeBtn(
                    icons: Icons.create,
                    bthTitles: "Create",
                    onpressed: _addTaskToDb,
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 3,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await getTimePicker();

    // ignore: use_build_context_synchronously
    String formateTime = pickedTime.format(context);

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
        // initialTime: selectedTime
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(':')[0]),
            minute: int.parse(startTime.split(':')[1].split(" ")[0])));
  }

  userDatePicker() async {
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
