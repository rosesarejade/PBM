import 'package:flutter/material.dart';
// import 'package:flutter_circular_text/flutter_circular_text.dart';

class LoginSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/team.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const SizedBox(height: 20.0),
                const Text(
                  'Hundred Acre Woods Daycare',
                  style: TextStyle(
                    fontFamily: 'Piglet',
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 204, 27, 33),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 210.0),
                _buildElevatedButton(context, 'Caregiver'),
                const SizedBox(height: 20.0),
                _buildElevatedButton(context, 'Parents'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context, String userType) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shadowColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                userType,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login', arguments: userType);
              },
            ),
          ),
        );
      },
    );
  }
}
