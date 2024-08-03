import 'dart:io';

import 'package:attendence_management_sys/model/attendence.dart';
import 'package:attendence_management_sys/model/user.dart';
import 'package:attendence_management_sys/repository/user_repository.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  File? _image;
  final _myRepo = UserRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _profilePicLoading = false;
  bool get profilePicLoading => _profilePicLoading;

  setProfilePicLoading(bool value) {
    _profilePicLoading = value;
    notifyListeners();
  }

  List<User> _usersList = [];
  List<User> get studentList => _usersList;

  Future<dynamic> GetAllStudents(BuildContext context) async {
    setLoading(true);
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _myRepo.GetStudentsApi().then((value) async {
      _usersList = value.map<User>((item) => User.fromMap(item)).toList();
      setLoading(false);
      return value;
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<dynamic> UpdateProfilePic(dynamic data, BuildContext context) async {
    setProfilePicLoading(true);
    _myRepo.PutUserApi(data).then((value) {
      if (value is Map<String, dynamic>) {
      } else if (value is String) {
        setLoading(false);
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage('Unexpected Error', context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<bool> saveUser(User user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('userid', user.userid);
    sp.setString('username', user.username.toString());
    sp.setString('email', user.email.toString());
    sp.setString('password', user.password.toString());
    sp.setString('fullName', user.fullName.toString());

    sp.setString('profilePicture', user.profilePicture.toString());
    sp.setString('role', user.role.toString());

    notifyListeners();
    return true;
  }

  Future<dynamic> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final int? userid = sp.getInt('userid');
    if (userid == null) return null;
    final String? username = sp.getString('username');
    final String? email = sp.getString('email');
    final String? password = sp.getString('password');
    final String? fullName = sp.getString('fullName');
    final String? profilePicture = sp.getString('profilePicture');
    final String? role = sp.getString('role');
    return User(
        userid: userid!,
        username: username!,
        password: password!,
        fullName: fullName,
        email: email,
        profilePicture: profilePicture,
        role: role!);
  }

  Future<bool> remvoe() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('userid');
    sp.remove('username');
    sp.remove('email');
    sp.remove('password');
    sp.remove('fullName');
    sp.remove('profilePicture');
    sp.remove('role');
    return true;
  }
}
