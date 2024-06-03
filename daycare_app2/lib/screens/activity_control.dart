// screens/caretaker_child_activity_update_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/child.dart';
import '../models/activity.dart';
import '../providers/daycare_provider.dart';

class ActivityUpdate extends StatelessWidget {
  final Child child;
  final Activity activity;

  ActivityUpdate({required this.child, required this.activity});

  void _editActivity(BuildContext context, Activity activity) {
    final _conditionController =
        TextEditingController(text: activity.condition);
    final _mealTypeController = TextEditingController(text: activity.meal.type);
    final _mealFoodController = TextEditingController(text: activity.meal.food);
    final _mealQuantityController =
        TextEditingController(text: activity.meal.quantity);
    final _toiletTimeController =
        TextEditingController(text: activity.toilet.time.format(context));
    final _toiletTypeController =
        TextEditingController(text: activity.toilet.type);
    final _toiletNotesController =
        TextEditingController(text: activity.toilet.notes);
    final _napStartTimeController =
        TextEditingController(text: activity.nap.startTime.format(context));
    final _napEndTimeController =
        TextEditingController(text: activity.nap.endTime.format(context));
    final _bottleTimeController =
        TextEditingController(text: activity.bottle.time.format(context));
    final _bottleAmountController =
        TextEditingController(text: activity.bottle.amount.toString());
    final _bottleTypeController =
        TextEditingController(text: activity.bottle.type);
    final _showerTimeController =
        TextEditingController(text: activity.other.showerTime.format(context));
    final _funActivitiesController =
        TextEditingController(text: activity.other.funActivities);
    final _commentsController = TextEditingController(text: activity.comments);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Activity'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _conditionController,
                  decoration: InputDecoration(labelText: 'Condition'),
                ),
                TextField(
                  controller: _mealTypeController,
                  decoration: InputDecoration(labelText: 'Meal Type'),
                ),
                TextField(
                  controller: _mealFoodController,
                  decoration: InputDecoration(labelText: 'Meal Food'),
                ),
                TextField(
                  controller: _mealQuantityController,
                  decoration: InputDecoration(labelText: 'Meal Quantity'),
                ),
                TextField(
                  controller: _toiletTimeController,
                  decoration: InputDecoration(labelText: 'Toilet Time'),
                ),
                TextField(
                  controller: _toiletTypeController,
                  decoration: InputDecoration(labelText: 'Toilet Type'),
                ),
                TextField(
                  controller: _toiletNotesController,
                  decoration: InputDecoration(labelText: 'Toilet Notes'),
                ),
                TextField(
                  controller: _napStartTimeController,
                  decoration: InputDecoration(labelText: 'Nap Start Time'),
                ),
                TextField(
                  controller: _napEndTimeController,
                  decoration: InputDecoration(labelText: 'Nap End Time'),
                ),
                TextField(
                  controller: _bottleTimeController,
                  decoration: InputDecoration(labelText: 'Bottle Time'),
                ),
                TextField(
                  controller: _bottleAmountController,
                  decoration: InputDecoration(labelText: 'Bottle Amount'),
                ),
                TextField(
                  controller: _bottleTypeController,
                  decoration: InputDecoration(labelText: 'Bottle Type'),
                ),
                TextField(
                  controller: _showerTimeController,
                  decoration: InputDecoration(labelText: 'Shower Time'),
                ),
                TextField(
                  controller: _funActivitiesController,
                  decoration: InputDecoration(labelText: 'Fun Activities'),
                ),
                TextField(
                  controller: _commentsController,
                  decoration: InputDecoration(labelText: 'Comments'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                activity.condition = _conditionController.text;
                activity.meal.type = _mealTypeController.text;
                activity.meal.food = _mealFoodController.text;
                activity.meal.quantity = _mealQuantityController.text;
                activity.toilet.time = TimeOfDay(
                  hour: int.parse(_toiletTimeController.text.split(":")[0]),
                  minute: int.parse(_toiletTimeController.text.split(":")[1]),
                );
                activity.toilet.type = _toiletTypeController.text;
                activity.toilet.notes = _toiletNotesController.text;
                activity.nap.startTime = TimeOfDay(
                  hour: int.parse(_napStartTimeController.text.split(":")[0]),
                  minute: int.parse(_napStartTimeController.text.split(":")[1]),
                );
                activity.nap.endTime = TimeOfDay(
                  hour: int.parse(_napEndTimeController.text.split(":")[0]),
                  minute: int.parse(_napEndTimeController.text.split(":")[1]),
                );
                activity.bottle.time = TimeOfDay(
                  hour: int.parse(_bottleTimeController.text.split(":")[0]),
                  minute: int.parse(_bottleTimeController.text.split(":")[1]),
                );
                activity.bottle.amount =
                    double.parse(_bottleAmountController.text);
                activity.bottle.type = _bottleTypeController.text;
                activity.other.showerTime = TimeOfDay(
                  hour: int.parse(_showerTimeController.text.split(":")[0]),
                  minute: int.parse(_showerTimeController.text.split(":")[1]),
                );
                activity.other.funActivities = _funActivitiesController.text;
                activity.comments = _commentsController.text;

                Provider.of<DaycareProvider>(context, listen: false)
                    .updateActivity(
                        // child.id,
                        activity);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${child.name}\'s Activities')),
      body: ListView.builder(
        itemCount: child.activities.length,
        itemBuilder: (context, index) {
          final activity = child.activities[index];
          return Card(
            child: ListTile(
              title: Text(
                  '${activity.date.toLocal().toString().split(' ')[0]} - ${activity.condition}'),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                onPressed: () => _editActivity(context, activity),
              ),
            ),
          );
        },
      ),
    );
  }
}
