import 'dart:typed_data';

class User {
  final int userid;
  final String username;
  final String password;
  final String? fullName;
  final String? email;
  final String? profilePicture;
  final String role;

  User({
    required this.userid,
    required this.username,
    required this.password,
    required this.fullName,
    required this.email,
    required this.profilePicture,
    required this.role,
  });

  // Factory method to create a User from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userid: map['userID'],
      username: map['username'],
      password: map['password'],
      fullName: map['fullName'],
      email: map['email'],
      profilePicture: map['profilePicture'],
      role: map['role'],
    );
  }

  // Method to convert User to a Map
  Map<String, dynamic> toMap() {
    return {
      'Username': username,
      'Password': password,
      'FullName': fullName,
      'Email': email,
      'ProfilePicture': profilePicture,
      'Role': role,
    };
  }
}
