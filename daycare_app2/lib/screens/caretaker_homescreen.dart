import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/daycare_provider.dart';
import '../models/child.dart';
import 'login.dart';
import 'activity_control.dart';

class CaretakerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caretaker Home'),
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
      body: Consumer<DaycareProvider>(
        builder: (context, daycareProvider, child) {
          final children = daycareProvider.children;
          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index];
              return ExpansionTile(
                title: Text(child.name),
                children: child.activities.map((activity) {
                  return ListTile(
                    title: Text(
                      '${activity.date.toLocal().toString().split(' ')[0]} - ${activity.condition}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityUpdate(
                              child: child,
                              activity: activity,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
