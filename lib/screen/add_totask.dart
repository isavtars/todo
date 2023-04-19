// import 'package:flutter/material.dart';
// import 'package:sqllite/constant/app_styles.dart';

// class Addtotask extends StatefulWidget {
//   const Addtotask({
//     super.key,
//   });

//   @override
//   State<Addtotask> createState() => _AddtotaskState();
// }

// class _AddtotaskState extends State<Addtotask> {
 
//   bool _validate = false;

//   @override
//   Widget build(BuildContext context) {
//     String? newTextValue;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 228, 223, 223),
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
//       child: Column(children: [
//         const SizedBox(
//           height: 10,
//         ),
//         const CircleAvatar(
//             backgroundColor: ksecondaryColor,
//             maxRadius: 42.0,
//             child: Icon(
//               Icons.list,
//               size: 42.0,
//               color: Color.fromARGB(255, 253, 252, 252),
//             )),
//         const SizedBox(
//           height: 10,
//         ),
//         const Text(
//           "TODO",
//           style: TextStyle(
//               fontSize: 32.0,
//               fontWeight: FontWeight.bold,
//               color: kprimarycolor),
//         ),
//         const SizedBox(
//           height: 10.2,
//         ),
//         const SizedBox(
//           height: 10.2,
//         ),
//         TextField(
//           controller: _text,
//           onEditingComplete: () {},
//           onChanged: (value) {
//             newTextValue = value;
//           },
//           textAlign: TextAlign.center,
//           decoration: InputDecoration(
//               hintText: "add task..",
//               errorText: _validate ? " value cannot be empty" : null,
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(21.0),
//                   borderSide: const BorderSide(
//                     color: kprimarycolor,
//                     width: 2,
//                   )),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(21.0))),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         TextField(
//           maxLines: 3,
//           controller: _desc,
//           onEditingComplete: () {},
//           onChanged: (value) {
//             newTextValue = value;
//           },
//           textAlign: TextAlign.center,
//           decoration: InputDecoration(
//               hintText: "add descriptions",
//               errorText: _validate ? " value cannot be empty" : null,
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(21.0),
//                   borderSide: const BorderSide(
//                     color: kprimarycolor,
//                     width: 2,
//                   )),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(21.0))),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         SizedBox(
//           height: 60,
//           width: 340,
//           child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(backgroundColor: kprimarycolor),
//               child: const Text(
//                 "Add",
//                 style: TextStyle(fontSize: 20.0),
//               )),
//         ),
//         const Spacer(),
//       ]),
//     );
//   }
// }
