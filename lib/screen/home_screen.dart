import 'package:flutter/material.dart';
import 'package:sqllite/sql_lite_helper.dart';
import '../constant/app_styles.dart';

import 'dart:core';

import '../widgets/showsnackbar.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _text = TextEditingController();
  final _desc = TextEditingController();

  List<Map<String, dynamic>> _jornals = [];
  bool isLodading = true;

  void _refersJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _jornals = data;
      isLodading = false;
    });
  }

  @override
  void initState() {
    _refersJournals();
    debugPrint("number of items ${_jornals.length}");
    super.initState();
  }

  Future<void> _addItem() async {
    if (_desc.text.isNotEmpty || _text.text.isNotEmpty) {
      await SQLHelper.createItems(_text.text, _desc.text);
      debugPrint("number of items ${_jornals.length}");
      _refersJournals();
    } else {
      showSnackbar(context, "please enter all the feild");
    }
  }

  Future<void> _deleteItem(int? id) async {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Are sure'),
              content: const Text('Are you wants delete Task'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await SQLHelper.deleteItems(id!);

                    _refersJournals();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  //update items by id
  void _updateItem(int? id) async {
    await SQLHelper.updateItems(id!, _text.text, _desc.text);
    _refersJournals();
  }

  void _showFormModel(int? id) {
    if (id != null) {
      final extianceJournals =
          _jornals.firstWhere((element) => element['id'] == id);

      _text.text = extianceJournals['title'];
      _desc.text = extianceJournals['description'];
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
          color: kprimarycolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 228, 223, 223),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "TODO",
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: kprimarycolor),
            ),
            const SizedBox(
              height: 10.2,
            ),
            const SizedBox(
              height: 10.2,
            ),
            TextField(
              controller: _text,
              onEditingComplete: () {},
              onChanged: (value) {},
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "add task..",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21.0),
                      borderSide: const BorderSide(
                        color: kprimarycolor,
                        width: 2,
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21.0))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 3,
              controller: _desc,
              onEditingComplete: () {},
              onChanged: (value) {},
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "add descriptions",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21.0),
                      borderSide: const BorderSide(
                        color: kprimarycolor,
                        width: 2,
                      )),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21.0))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: 340,
              child: ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await _addItem();
                    }
                    if (id != null) {
                      _updateItem(id);
                    }
                    _text.text = "";
                    _desc.text = "";
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: kprimarycolor),
                  child: Text(
                    id == null ? "Create " : "update",
                    style: const TextStyle(fontSize: 20.0),
                  )),
            ),
            const Spacer(),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kprimarycolor,
            centerTitle: true,
            title: const Text("TODO")),
        body: ListView.builder(
            itemCount: _jornals.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(_jornals[index]['title']),
                  subtitle: Text(_jornals[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(children: [
                      IconButton(
                          onPressed: () {
                            _showFormModel(_jornals[index]['id']);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () async {
                            await _deleteItem(_jornals[index]['id']);
                          },
                          icon: const Icon(Icons.delete))
                    ]),
                  ),
                ),
              );
            }),
        floatingActionButton: SizedBox(
          height: 60,
          child: FloatingActionButton(
            backgroundColor: kprimarycolor,
            onPressed: () => _showFormModel(null),
            child: const Icon(Icons.add),
          ),
        ));
  }
}
