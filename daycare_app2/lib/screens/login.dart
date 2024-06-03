// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'parent_homescreen.dart';
import 'caretaker_homescreen.dart';
import 'register.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[100],
          title: Text(
            'Daycare App',
            style: TextStyle(
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _register(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your registered credentials to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final authProvider =
                Provider.of<AuthProvider>(context, listen: false);
            bool success = authProvider.loginUser(
              _usernameController.text,
              _passwordController.text,
            );

            if (success) {
              if (authProvider.currentUser!.role == 'parent') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ParentHomeScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CaretakerHomeScreen()),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Invalid credentials'),
              ));
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  _register(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Create an account?"),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            child: const Text(
              "Register Here",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
