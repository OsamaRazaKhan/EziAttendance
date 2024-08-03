import 'dart:convert';

import 'package:attendence_management_sys/model/user.dart';
import 'package:attendence_management_sys/repository/auth_repository.dart';
import 'package:attendence_management_sys/resources/app_url.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/utils/utils.dart';
import 'package:attendence_management_sys/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _signinloading = false;
  bool get signinloading => _signinloading;

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  setsigninLoading(bool value) {
    _signinloading = value;
    notifyListeners();
  }

  setsignUpLoading(bool value) {
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApi(BuildContext context) async {
    setsigninLoading(true);
    _myRepo.loginApi().then((value) async {
      setsigninLoading(false);
      if (value is Map<String, dynamic>) {
        User u = new User(
            userid: value["userID"],
            username: value["username"],
            password: value["password"],
            fullName: value["fullName"],
            email: value["email"],
            profilePicture: value["profilePicture"],
            role: value["role"]);
        UserViewModel().saveUser(u);
        globaluserid = u.userid;
        setsigninLoading(false);
        Utils.flushBarErrorMessage('Login Successfully', context);

        u.role == "Student"
            ? Navigator.pushReplacementNamed(context, RoutesName.student_home)
            : Navigator.pushReplacementNamed(context, RoutesName.admin_home);

        if (kDebugMode) {
          print(value.toString());
        }
      } else if (value is String) {
        if (value.toString() == 'unauthorized')
          Utils.flushBarErrorMessage('Invalid Email or Password', context);
      } else {
        Utils.flushBarErrorMessage('Unexpected error', context);
      }
    }).onError((error, stackTrace) {
      setsigninLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setsignUpLoading(true);
    _myRepo.SignUpApi(data).then((value) {
      setsignUpLoading(false);
      Utils.showFlushbarAndNavigate(
          context, 'Sign Up Successfully', RoutesName.login);

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setsignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
