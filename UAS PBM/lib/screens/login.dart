import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  late String role;

  @override
  Widget build(BuildContext context) {
    // Pastikan argumen role diterima dengan benar
    role = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/screenbg.jpg"),
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
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    Image.asset(
                      'images/tiger2.png',
                      height: 200,
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontFamily: 'Piglet',
                            fontWeight: FontWeight.bold,
                            fontSize: 35),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.blueAccent),
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter your registered email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffix: InkWell(
                            onTap: _tooglePasswordView,
                            child: Icon(_isHidden
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.lock, color: Colors.blueAccent),
                      ),
                      obscureText: _isHidden,
                      validator: (val) => val!.length < 6
                          ? 'Input a password at least 6 characters'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Sign In'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Tambahkan log untuk memastikan navigasi dipanggil
                          if (kDebugMode) {
                            print('Navigasi ke halaman sesuai peran: $role');
                          }
                          Navigator.pushReplacementNamed(
                              context,
                              role == 'Caregiver'
                                  ? '/home_caregiver'
                                  : '/home_parent');
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Create an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Register Here',
                              style: TextStyle(color: Color(0XFF2C55A4)),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _tooglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
