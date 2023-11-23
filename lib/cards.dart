import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final List<List<String>> dividedLists;
  const Cards({Key? key, required this.dividedLists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade300,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
            const SizedBox(
              height: 30,
            ),
            // ========== cards start

            Expanded(
              child: ListView.builder(
                itemCount: dividedLists.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 20,
                    color: Colors.blue.shade300,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: dividedLists[index]
                                .map((names) => Text(names))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // ========== cards end
          ],
        ),
      ),
    );
  }
}









// Row(
//               children: [
//                 Wrap(
//                   children: [
//                     Card(
//                       elevation: 20,
//                       color: Colors.blue.shade300,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: dividedLists.length > 3
//                               ? dividedLists[3]
//                                   .map((names) => Text(names))
//                                   .toList()
//                               : const [Text('Empty')],
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),