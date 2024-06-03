import 'package:flutter/material.dart';
import '../models/child.dart';
import '../models/activity.dart';

class ChildActivity extends StatelessWidget {
  final Child child;

  ChildActivity({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${child.name} Activities'),
      ),
      body: ListView.builder(
        itemCount: child.activities.length,
        itemBuilder: (context, index) {
          final activity = child.activities[index];
          return Card(
            color: Theme.of(context).primaryColorLight,
            child: ExpansionTile(
              title: Text(
                '${activity.date.toLocal().toString().split(' ')[0]} | ${activity.condition}',
                // style: TextStyle(color: Colors.white),
              ),
              children: [
                ListTile(
                  title: Text('Arrival Time'),
                  subtitle: Text(activity.arrivalTime.format(context)),
                ),
                ListTile(
                  title: Text('Body Temperature'),
                  subtitle: Text('${activity.bodyTemperature} °C'),
                ),
                ListTile(
                  title: Text('Meal'),
                  subtitle: Text(
                      '${activity.meal.type}: ${activity.meal.food} (${activity.meal.quantity})'),
                ),
                ListTile(
                  title: Text('Toilet'),
                  subtitle: Text(
                      '${activity.toilet.time.format(context)} - ${activity.toilet.type} (${activity.toilet.notes})'),
                ),
                ListTile(
                  title: Text('Nap Time'),
                  subtitle: Text(
                      '${activity.nap.startTime.format(context)} to ${activity.nap.endTime.format(context)}'),
                ),
                ListTile(
                  title: Text('Bottle'),
                  subtitle: Text(
                      '${activity.bottle.time.format(context)} - ${activity.bottle.amount} ml (${activity.bottle.type})'),
                ),
                ListTile(
                  title: Text('Shower Time'),
                  subtitle: Text(activity.other.showerTime.format(context)),
                ),
                ListTile(
                  title: Text('Fun Activities'),
                  subtitle: Text(activity.other.funActivities),
                ),
                ListTile(
                  title: Text('Comments'),
                  subtitle: Text(activity.comments),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
