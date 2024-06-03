// // providers/auth_provider.dart
// import 'package:flutter/material.dart';
// import '../models/user.dart';

// class AuthProvider with ChangeNotifier {
//   User? _currentUser;
//   List<User> _users = [];

//   User? get currentUser => _currentUser;

//   void registerUser(User user) {
//     _users.add(user);
//     notifyListeners();
//   }

//   bool loginUser(String username, String password) {
//     User? user = _users.firstWhere(
//       (user) => user.username == username && user.password == password,
//       orElse: () => User(id: '', username: '', password: '', role: ''),
//     );
//     if (user.id.isNotEmpty) {
//       _currentUser = user;
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }

//   void logout() {
//     _currentUser = null;
//     notifyListeners();
//   }
// }

// providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  List<User> _users = [
    User(id: 'parent1', username: 'parent1', password: '123', role: 'parent'),
    User(
        id: 'caretaker1',
        username: 'caretaker1',
        password: '456',
        role: 'caretaker'),
  ];

  User? get currentUser => _currentUser;

  void registerUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  bool loginUser(String username, String password) {
    User? user = _users.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => User(id: '', username: '', password: '', role: ''),
    );
    if (user.id.isNotEmpty) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
