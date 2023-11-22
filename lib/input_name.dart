import 'package:flutter/material.dart';

class NameInuptPage extends StatefulWidget {
  const NameInuptPage({super.key});

  @override
  State<NameInuptPage> createState() => _NameInuptPageState();
}

class _NameInuptPageState extends State<NameInuptPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Grouping'),
        ),
        body: Container(
          child: Column(
            children: [
              TextField(),
            ],
          ),
        ),
      ),
    );
  }
}
