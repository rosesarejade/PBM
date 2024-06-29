import 'package:flutter/material.dart';
import 'input_children.dart';
import 'child_activities.dart';
import 'input_activity.dart';

class CaretakerHomescreen extends StatelessWidget {
  final List<Map<String, String>> children = [
    {'name': 'Alex Farminghouse', 'image': 'images/iconroo.png'},
    {'name': 'Amanda Gander', 'image': 'images/iconlumpy.png'},
    {'name': 'Aubrey Adams', 'image': 'images/iconlumpy.png'},
    {'name': 'Avery Birch', 'image': 'images/iconeeyore.png'},
    {'name': 'Blake Coleman', 'image': 'images/Pooh_icon.png'},
    {'name': 'Jeffrey Cousins', 'image': 'assets/images/jeffrey.png'},
    {'name': 'Lexi Hobert', 'image': 'assets/images/lexi.png'},
    {'name': 'Lisa Leslie', 'image': 'assets/images/lisa.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caregiver\'s Dashboard',
            style: TextStyle(
                fontFamily: 'Piglet',
                fontSize: 27,
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 183, 228, 249),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/screenbg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(children[index]['image']!),
                      ),
                      title: Text(children[index]['name']!),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ActivityInputPage()),
                          );
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
