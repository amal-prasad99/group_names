import 'package:flutter/material.dart';

class NameInputPage extends StatefulWidget {
  const NameInputPage({super.key});

  @override
  State<NameInputPage> createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  TextEditingController _inputName = TextEditingController();

  List<String> namesList = [];

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
                  },
                  child: const Text('Enter'),
                ),
                SizedBox(
                  width: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    groupNames();
                    print(namesList);
                  },
                  child: const Text('Group'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
