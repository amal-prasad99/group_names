import 'package:flutter/material.dart';
import 'package:group_names/cards.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({super.key});

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  TextEditingController _inputName = TextEditingController();

  List<String> namesList = [];
  List<List<String>> dividedLists = [];
  int batchSize = 5;

  void enterToList(String name) {
    if (!namesList.contains(name)) {
      namesList.add(name);
    } else {
      _showTextPopup(name);
    }
  }

  void groupNames() {
    namesList.shuffle();
  }

  void makeFiveGroups() {
    for (int i = 0; i < namesList.length; i += batchSize) {
      int end =
          (i + batchSize < namesList.length) ? i + batchSize : namesList.length;
      List<String> sublist = namesList.sublist(i, end);
      dividedLists.add(List<String>.from(sublist));
    }
    for (int i = 0; i < dividedLists.length; i++) {
      print("List ${i + 1}: ${dividedLists[i]}");
    }
  }

  void printSublist(int index) {
    if (dividedLists.length > index) {
      print("Second element from dividedLists: ${dividedLists[index]}");
    }
  }

  void _showTextPopup(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entered Name already exist'),
          content: Text(
            name,
            style: const TextStyle(fontSize: 30),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _inputName.clear();
              },
              child: const Text('Return'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Grouping'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _inputName,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.create),
                  border: OutlineInputBorder(),
                  hintText: "Enter Name",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    var name = _inputName.text;
                    // _showTextPopup(name);
                    enterToList(name);
                    print(namesList);
                    _inputName.clear();
                  },
                  child: const Text('Enter'),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // groupNames();
                    makeFiveGroups();
                  },
                  child: const Text('Group'),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Cards(dividedLists: dividedLists)),
                    );
                  },
                  child: const Text('Go to cards'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
