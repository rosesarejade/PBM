import 'package:flutter/material.dart';
import 'input_children.dart';
import 'child_activities.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> children = [
    {'name': 'Hillary Farminghouse', 'image': 'images/iconroo.png'},
    {'name': 'Amanda Gander', 'image': 'images/iconlumpy.png'},
    {'name': 'Aubrey Adams', 'image': 'images/iconlumpy.png'},
    {'name': 'Avery Birch', 'image': 'images/iconeeyore.png'},
    {'name': 'Blake Coleman', 'image': 'images/Pooh_icon.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parent\'s Dashboard',
          style: TextStyle(
            fontFamily: 'Piglet',
            fontSize: 27,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 183, 228, 249),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/screenbg2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Color.fromARGB(150, 183, 228,
                  249), // Optional: Add a semi-transparent overlay
            ),
          ),
          ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(children[index]['image']!),
                ),
                title: Text(children[index]['name']!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChildActivitiesPage(
                        childName: children[index]['name']!,
                        childAge:
                            8, // Replace with actual age data if available
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChildInputPage()),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
