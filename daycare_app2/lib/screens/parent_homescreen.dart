import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/daycare_provider.dart';
import '../providers/auth_provider.dart';
import '../models/child.dart';
import 'login.dart';
import 'child_activities.dart';

class ParentHomeScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _sexController = TextEditingController();
  final _ageController = TextEditingController();

  void _addChild(BuildContext context, String parentId) {
    final daycareProvider =
        Provider.of<DaycareProvider>(context, listen: false);
    final child = Child(
      id: DateTime.now().toString(),
      name: _nameController.text,
      sex: _sexController.text,
      age: int.parse(_ageController.text),
      parentId: parentId,
      activities: [],
    );
    daycareProvider.addChild(child);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final daycareProvider = Provider.of<DaycareProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final parentId = authProvider.currentUser!.id;

    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Home'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: daycareProvider.children
                  .where((child) => child.parentId == parentId)
                  .length,
              itemBuilder: (context, index) {
                final child = daycareProvider.children
                    .where((child) => child.parentId == parentId)
                    .toList()[index];
                return ListTile(
                  title: Text(child.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChildActivity(child: child),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add Child'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: _sexController,
                          decoration: InputDecoration(labelText: 'Sex'),
                        ),
                        TextField(
                          controller: _ageController,
                          decoration: InputDecoration(labelText: 'Age'),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => _addChild(context, parentId),
                        child: Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Add My Child'),
          ),
        ],
      ),
    );
  }
}
