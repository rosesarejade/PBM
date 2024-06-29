import 'package:flutter/material.dart';

class ChildActivitiesPage extends StatelessWidget {
  final String childName;
  final int childAge;

  const ChildActivitiesPage({required this.childName, required this.childAge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$childName\'s Activities Report',
            style: const TextStyle(
                fontFamily: 'Piglet',
                fontSize: 27,
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 183, 228, 249),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/screenbg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 2, 42, 74).withOpacity(0.25),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Image.asset(
                        'images/report_icon.png',
                        height: 155,
                      )),
                ),
                const SizedBox(height: 10.0),
                _buildSection('images/basket.png', 'Child Information', [
                  _buildInfoRow('Name', childName),
                  _buildInfoRow('Age', '$childAge years'),
                  _buildInfoRow(
                      'Drop-off Date', _getFormattedDate(DateTime.now())),
                  _buildInfoRow('Arrival Time', '08:30 AM'), //CHANGE
                  _buildInfoRow('Body Temperature', '36.5°C'),
                  _buildInfoRow('Condition', 'Healthy'),
                ]),
                const SizedBox(height: 20),
                _buildSection('images/meal.png', 'Meal Schedule', [
                  _buildMealInfo('Breakfast', 'Pancakes', 'some', 'Ate well'),
                  _buildMealInfo(
                      'Lunch', 'Pasta', 'lots', 'Finished everything'),
                  _buildMealInfo(
                      'Dinner', 'Chicken soup', 'some', 'Ate slowly'),
                  _buildMealInfo('Fluids', 'Water', 'lots', 'Drank plenty'),
                  _buildMealInfo('Other', 'Fruits', 'some', 'Had a few pieces'),
                ]),
                const SizedBox(height: 20),
                _buildSection('images/potty.gif', 'Toilet Time', [
                  _buildInfoRow('Time', '09:00 AM'),
                  _buildInfoRow('Type', 'Potty'),
                  _buildInfoRow('Dry/Wet/BM', 'Dry'),
                ]),
                const SizedBox(height: 20),
                _buildSection('images/active.gif', 'Child\'s Feelings', [
                  _buildFeelingRow('Sad', false),
                  _buildFeelingRow('Happy', true),
                  _buildFeelingRow('Shy', false),
                  _buildFeelingRow('Confident', true),
                  _buildFeelingRow('Naughty', false),
                ]),
                const SizedBox(height: 20),
                _buildSection('images/needed.png', 'Items Needed', [
                  _buildItemRow('Diapers', false),
                  _buildItemRow('Towel', true),
                  _buildItemRow('Hand Towel', false),
                  _buildItemRow('Soap', true),
                  _buildItemRow('Shampoo', true),
                  _buildItemRow('Cream', false),
                  _buildItemRow('Milk', true),
                  _buildItemRow('Clothes', true),
                  _buildItemRow('Toothpaste', false),
                  _buildItemRow('Other', false),
                ]),
                const SizedBox(height: 20),
                _buildSection('images/naptime.png', 'Others', [
                  _buildInfoRow('Rest Time', '1 hour'),
                  _buildInfoRow('Bathroom Time', '15 minutes'),
                  _buildInfoRow('Shower Time', '10 minutes'),
                  _buildInfoRow(
                      'Activity Description', 'Played with blocks and painted'),
                  _buildInfoRow('Parent Note', '$childName had a great day!'),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String imagePath, String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 7, 34, 55).withOpacity(0.25),
        border: Border.all(color: const Color.fromARGB(255, 2, 42, 74)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 2, 42, 74).withOpacity(0.3),
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 70,
                ),
                const SizedBox(width: 5.0),
                Text(
                  title,
                  style: const TextStyle(
                      fontFamily: 'Piglet',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 163, 216, 240)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Column(children: children),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$label:',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildMealInfo(
      String mealType, String food, String quantity, String comments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          mealType,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 2, 42, 74)),
        ),
        _buildInfoRow('Food', food),
        _buildInfoRow('Quantity', quantity),
        _buildInfoRow('Comments', comments),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildFeelingRow(String feeling, bool isExpressed) {
    return _buildInfoRow(feeling, isExpressed ? 'Yes' : 'No');
  }

  Widget _buildItemRow(String item, bool isNeeded) {
    return _buildInfoRow(item, isNeeded ? 'Yes' : 'No');
  }

  String _getFormattedDate(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }
}
