import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_parent.dart';
// Import the ChildActivitiesPage

class ChildInputPage extends StatefulWidget {
  const ChildInputPage({super.key});

  @override
  _ChildInputPageState createState() => _ChildInputPageState();
}

class _ChildInputPageState extends State<ChildInputPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String age = '';
  String sex = '';

  Future<void> submitData() async {
    final url = Uri.parse('https://e7e466ff1ba745979f91354c872c0f5e.api.mockbin.io/'); // Ganti dengan endpoint API Anda
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'age': age,
        'sex': sex,
      }),
    );

    if (response.statusCode == 201) {
      // Jika server mengembalikan kode status 201 Created
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      // Jika server tidak mengembalikan kode status 201
      throw Exception('Failed to create child.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the background behind the app bar
      appBar: AppBar(
        title: const Text(
          'Input Children Data',
          style: TextStyle(fontFamily: 'Piglet', fontSize: 30.0),
        ),
        backgroundColor: Colors.transparent, // Set app bar background to transparent
        elevation: 0, // Remove app bar shadow
      ),
      backgroundColor: Colors.transparent, // Set scaffold background to transparent
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/screenbg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Image.asset(
                        'images/iconroo.png',
                        height: 135,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Add My Child',
                      style: TextStyle(
                        fontFamily: 'Piglet',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.person, color: Colors.blueAccent),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter my child\'s name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Sex',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.transgender, color: Colors.blueAccent),
                      ),
                      validator: (val) => val!.isEmpty ? 'Girl/ Boy' : null,
                      onChanged: (val) {
                        setState(() => sex = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.cake, color: Colors.blueAccent),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter my child\'s age' : null,
                      onChanged: (val) {
                        setState(() => age = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitData();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
