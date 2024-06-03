// // main.dart
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/daycare_provider.dart';
// import 'screens/login.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => DaycareProvider(),
//       child: MaterialApp(
//         title: 'Daycare App',
//         theme: ThemeData(
//           hintColor: Color.fromARGB(255, 255, 104, 240),
//           primaryColor: Color(0xFF80E1D1),
//           // canvasColor: Color.fromARGB(255, 91, 193, 237)
//         ),
//         home: LoginScreen(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/daycare_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DaycareProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Daycare App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ThemeData(
            //   colorScheme: ColorScheme(
            //     primary: Color(0xFFB93C5D),
            //     onPrimary: Colors.black,
            //     secondary: Color(0xFFEFF3F3),
            //     onSecondary: Color(0xFF322942),
            //     error: Colors.redAccent,
            //     onError: Colors.white,
            //     background: Color(0xFFE6EBEB),
            //     onBackground: Colors.purple[100],
            //     surface: Color(0xFFFAFBFB),
            //     onSurface: Color(0xFF241E30),
            //     brightness: Brightness.light,
            //   ),
            //   // primaryColor: Color(),
            //   highlightColor: Colors.transparent,
            //   focusColor: Colors.black.withOpacity(0.12),
            //   hintColor: Color(0xFF80E1D1),
            //   // backgroundColor: Color.fromARGB(255, 91, 193, 237),
            //   // scaffoldBackgroundColor: Color(0xFF80E1D1),
            //   textTheme: TextTheme(
            //     headline1: TextStyle(
            //         color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            //     bodyText1: TextStyle(color: Colors.white),
            //   ),
            //   buttonTheme: ButtonThemeData(
            //     buttonColor: Color.fromARGB(255, 255, 104, 240),
            //     textTheme: ButtonTextTheme.primary,
            //   ),
            //   inputDecorationTheme: InputDecorationTheme(
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide(color: Color.fromARGB(255, 91, 193, 237)),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Color.fromARGB(255, 255, 104, 240)),
            //     ),
            //     // labelStyle: TextStyle(color: Colors.white),
            //   ),
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)),
        home: LoginScreen(),
      ),
    );
  }
}
