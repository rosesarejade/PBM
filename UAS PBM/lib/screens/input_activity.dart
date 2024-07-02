import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityInputPage extends StatefulWidget {
  const ActivityInputPage({super.key});

  @override
  _ActivityInputPageState createState() => _ActivityInputPageState();
}

class _ActivityInputPageState extends State<ActivityInputPage> {
  final _formKey = GlobalKey<FormState>();
  String childName = '';
  String childAge = '';
  String childTemperature = '';
  String childCondition = '';
  String otherFeeling = '';
  String otherItemNeeded = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay bathroomTime = TimeOfDay.now();
  TimeOfDay dropOffTime = TimeOfDay.now();

  String toiletType = 'Potty';
  String toiletCondition = 'Wet';

  Map<String, Map<String, String>> meals = {
    'breakfast': {'food': '', 'quantity': 'none', 'comments': ''},
    'lunch': {'food': '', 'quantity': 'none', 'comments': ''},
    'dinner': {'food': '', 'quantity': 'none', 'comments': ''},
    'fluids': {'food': '', 'quantity': 'none', 'comments': ''},
    'other': {'food': '', 'quantity': 'none', 'comments': ''},
  };

  String showerTime = '';
  String activityDescription = '';
  String parentNote = '';

  Map<String, bool> feelings = {
    'Sad': false,
    'Happy': false,
    'Confident': false,
    'Naughty': false,
    'Shy': false,
    'Sociable': false,
    'Other': false,
  };

  Map<String, bool> itemsNeeded = {
    'Diapers': false,
    'Towel': false,
    'Hand Towel': false,
    'Soap': false,
    'Shampoo': false,
    'Cream': false,
    'Milk': false,
    'Clothes': false,
    'Tooth Paste': false,
    'Other': false,
  };

  Widget buildOtherFeelingTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Other feelings',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (val) {
        setState(() {
          otherItemNeeded = val;
        });
      },
    );
  }

  Widget buildOtherItemNeededTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Other Items',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (val) {
        setState(() {
          otherItemNeeded = val;
        });
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  _selectTime(BuildContext context, TimeOfDay initialTime,
      Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        onTimeSelected(picked);
      });
    }
  }

  _selectBathroomTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: bathroomTime,
    );
    if (picked != null) {
      setState(() {
        bathroomTime = picked;
      });
    }
  }

  void _updateMealQuantity(String mealType, String quantity) {
    setState(() {
      meals[mealType]!['quantity'] = quantity;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Buat map untuk menyimpan data yang akan dikirim ke API
      Map<String, dynamic> formData = {
        'childName': childName,
        'childAge': childAge,
        'childTemperature': childTemperature,
        'childCondition': childCondition,
        'selectedDate': selectedDate.toIso8601String(),
        'dropOffTime': dropOffTime.format(context),
        'meals': meals,
        'bathroomTime': bathroomTime.format(context),
        'toiletType': toiletType,
        'toiletCondition': toiletCondition,
        'activityDescription': activityDescription,
        'parentNote': parentNote,
        'feelings': feelings.map((key, value) => MapEntry(key, value.toString())),
        'itemsNeeded': itemsNeeded.map((key, value) => MapEntry(key, value.toString())),
        'otherFeeling': otherFeeling,
        'otherItemNeeded': otherItemNeeded,
      };

// Kirim data ke API menggunakan HTTP POST
      final response = await http.post(
        Uri.parse('https://e7e466ff1ba745979f91354c872c0f5e.api.mockbin.io/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Children's activities have been saved")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Child Input Activity',
            style: TextStyle(
                fontFamily: 'Piglet',
                fontSize: 30,
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(255, 183, 228, 249),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/screenbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Child Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Child Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Input The Child\'s Name' : null,
                    onChanged: (val) {
                      setState(() => childName = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Age of Child',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter your child\'s age' : null,
                    onChanged: (val) {
                      setState(() => childAge = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Body Temperature (°C)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter your child\'s temperature' : null,
                    onChanged: (val) {
                      setState(() => childTemperature = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Child Condition',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? 'Enter your child\'s condition' : null,
                    onChanged: (val) {
                      setState(() => childCondition = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    onTap: () => _selectDate(context),
                  ),
                  ListTile(
                    title: Text("Drop-off Date : ${selectedDate}"),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Drop-off Time',
                    style: TextStyle(fontSize: 18),
                  ),
                  ListTile(
                    title: Text('Selected Time: ${selectedTime.format(context)}'),
                    trailing: const Icon(Icons.access_time),
                    onTap: () => _selectTime(context, selectedTime, (picked) {
                      selectedTime = picked;
                    }),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Meal Times',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Breakfast',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        meals['breakfast']!['food'] = val;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Lunch',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        meals['lunch']!['food'] = val;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Dinner',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        meals['dinner']!['food'] = val;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Fluids',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        meals['fluids']!['food'] = val;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Shower Time',
                    style: TextStyle(fontSize: 18),
                  ),
                  ListTile(
                    title: Text('Selected Time: $showerTime'),
                    trailing: const Icon(Icons.access_time),
                    onTap: () => _selectTime(context, TimeOfDay.now(), (picked) {
                      setState(() {
                        showerTime = picked.format(context);
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Activity Description',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Activity Description',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => activityDescription = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Feelings',
                    style: TextStyle(fontSize: 18),
                  ),
                  Column(
                    children: feelings.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: feelings[key],
                        onChanged: (bool? value) {
                          setState(() {
                            feelings[key] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  feelings['Other']! ? buildOtherFeelingTextField() : Container(),
                  const SizedBox(height: 10),
                  const Text(
                    'Items Needed',
                    style: TextStyle(fontSize: 18),
                  ),
                  Column(
                    children: itemsNeeded.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: itemsNeeded[key],
                        onChanged: (bool? value) {
                          setState(() {
                            itemsNeeded[key] = value!;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  itemsNeeded['Other']! ? buildOtherItemNeededTextField() : Container(),
                  const SizedBox(height: 10),
                  const Text(
                    'Parent Notes',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Parent Notes',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => parentNote = val);
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}