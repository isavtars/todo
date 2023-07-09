import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'package:sqllite/utils/sizeconfig.dart';
import '../logic/task_controller.dart';
import '../logic/themchanger.dart';
import '../models/task_models.dart';
import '../notifaction/notifications_hepler.dart';
import '../utils/app_styles.dart';

import 'addtask.dart';
import 'widgets/customebtns.dart';
import 'widgets/datetime.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});
  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

bool changevalue = false;
var logger = Logger();

class _HomeScreen2State extends State<HomeScreen2> {
  DateTime selecteddate = DateTime.now();
  DateTime currentdate = DateTime.now();

  NotificationHelper notiFiHelper = NotificationHelper();
  @override
  void initState() {
    getsTask();
    super.initState();
    notiFiHelper.initilizationsNotifications();
    notiFiHelper.requestAndroidPermissions();
  }

  final changeThemes = Get.find<ThemModeChange>();
  final _taskController = Get.find<TaskController>();

  getsTask() async {
    await _taskController.getTasks();
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

          DatePicker(
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
          const SizedBox(
            height: 8,
          ),
          //fetch the data of databases

          Expanded(child: Obx(() {
            return ListView.builder(
                itemCount: _taskController.taskList.length,
                itemBuilder: (context, index) {
                  logger.d(
                      "${_taskController.taskList.length.toString()} kkkkss");

                  Task tasked = _taskController.taskList[index];

                  if (tasked.reapert == "Daily") {
                    DateTime mydate =
                        DateFormat.jm().parse(tasked.startTime.toString());

                    var myTime = DateFormat("HH:mm").format(mydate);
                    notiFiHelper.scheduledNotification(
                        int.parse(myTime.toString().split(":")[0]),
                        int.parse(myTime.toString().split(":")[1]),
                        tasked);

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              bottomsheet(context, index);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: 1,
                                        offset: Offset(5, 3),
                                        blurRadius: 7)
                                  ],
                                  color: Color.fromARGB(255, 214, 226, 235),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              margin: const EdgeInsets.all(7),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                children: [
                                  //left
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _taskController.taskList[index].title
                                              .toString(),
                                          style: kQuestrialBold.copyWith(
                                              color: front3, fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.access_time_rounded,
                                              size: 18,
                                              color: Color.fromARGB(
                                                  255, 3, 41, 53),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              _taskController
                                                  .taskList[index].startTime
                                                  .toString(),
                                              style: kQuestrialBold.copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 3, 41, 53),
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                _taskController
                                                    .taskList[index].endTime
                                                    .toString(),
                                                style:
                                                    kQuestrialSemibold.copyWith(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 3, 41, 53),
                                                        fontSize: 16)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            _taskController.taskList[index].note
                                                .toString(),
                                            style: kQuestrialRegular.copyWith(
                                                color: const Color.fromARGB(
                                                    255, 3, 41, 53),
                                                fontSize: 17)),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 50,
                                    child: Divider(
                                      height: 10,
                                    ),
                                  ),
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                        " ${_taskController.taskList[index].isComplited == 1 ? "Completed" : "Todo"}",
                                        style: kQuestrialMedium.copyWith(
                                          fontSize: 16,
                                          color: _taskController.taskList[index]
                                                      .isComplited ==
                                                  1
                                              ? Colors.green
                                              : Colors.red,
                                        )),
                                  )
                                ],
                                //right
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (tasked.date == DateFormat.yMd().format(selecteddate)) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              bottomsheet(context, index);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: 1,
                                        offset: Offset(5, 3),
                                        blurRadius: 7)
                                  ],
                                  color: Color.fromARGB(255, 214, 226, 235),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              margin: const EdgeInsets.all(7),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Row(
                                children: [
                                  //left
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _taskController.taskList[index].title
                                              .toString(),
                                          style: kQuestrialBold.copyWith(
                                              color: front3, fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.access_time_rounded,
                                              size: 18,
                                              color: Color.fromARGB(
                                                  255, 3, 41, 53),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              _taskController
                                                  .taskList[index].startTime
                                                  .toString(),
                                              style: kQuestrialBold.copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 3, 41, 53),
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                _taskController
                                                    .taskList[index].endTime
                                                    .toString(),
                                                style:
                                                    kQuestrialSemibold.copyWith(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 3, 41, 53),
                                                        fontSize: 16)),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            _taskController.taskList[index].note
                                                .toString(),
                                            style: kQuestrialRegular.copyWith(
                                                color: const Color.fromARGB(
                                                    255, 3, 41, 53),
                                                fontSize: 17)),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 50,
                                    child: Divider(
                                      height: 10,
                                    ),
                                  ),
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                        " ${_taskController.taskList[index].isComplited == 1 ? "Completed" : "Todo"}",
                                        style: kQuestrialMedium.copyWith(
                                          fontSize: 16,
                                          color: _taskController.taskList[index]
                                                      .isComplited ==
                                                  1
                                              ? Colors.green
                                              : Colors.red,
                                        )),
                                  )
                                ],
                                //right
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          })),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> bottomsheet(
      BuildContext context, int index) {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(20),
              height: 330,
              width: double.infinity,
              child: Column(
                children: [
                  _taskController.taskList[index].isComplited == 1
                      ? Container()
                      : CustomeBtn(
                          width: double.infinity,
                          color: Colors.purple,
                          icons: Icons.done,
                          bthTitles: "Task Completed",
                          onpressed: () {
                            _taskController.makeTaskCompleted(
                                _taskController.taskList[index].id!);
                            _taskController.getTasks();
                            Get.back();
                          }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeBtn(
                      color: Colors.red,
                      width: double.infinity,
                      icons: Icons.delete,
                      bthTitles: "Delete",
                      onpressed: () {
                        _taskController
                            .deleteTask(_taskController.taskList[index]);
                        _taskController.getTasks();
                        Navigator.pop(context);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeBtn(
                      width: double.infinity,
                      icons: Icons.update,
                      bthTitles: "Update",
                      onpressed: () {
                        Get.to(const AddTaskScreenn());
                        // _taskController.getTasks();
                        // Navigator.pop(context);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomeBtn(
                      width: double.infinity,
                      color: Colors.blue,
                      icons: Icons.close,
                      bthTitles: "close",
                      onpressed: () {
                        _taskController.getTasks();
                        Navigator.pop(context);
                      })
                ],
              ));
        });
  }

//header
  SizedBox header({required IconData icon}) {
    return SizedBox(
      height: SizeConfig.blockSizeHorizantal! * 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              logger.d(changeThemes.isDarkMode(context));

              notiFiHelper.displayNotfications(
                  title: "ThemeChange",
                  body: changeThemes.isDarkMode(context) != true
                      ? "Activited DarkMode"
                      : "Activited whiteMode");

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
  SizedBox _addtask() {
    return SizedBox(
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
                  "${formatDate(currentdate.toString())}",
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
                      builder: (context) => const AddTaskScreenn()),
                );
                _taskController.getTasks();
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
