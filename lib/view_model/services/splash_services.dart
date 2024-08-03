import 'package:attendence_management_sys/model/user.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashServices {
  Future<dynamic> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if (value == null) {
        Future.delayed(Duration(seconds: 3))
            .then((value) => Navigator.pushNamed(context, RoutesName.login));
      } else {
        Future.delayed(Duration(seconds: 3)).then((val) {
          if (value.role == 'Student')
            Navigator.pushNamed(context, RoutesName.student_home);
          else
            Navigator.pushNamed(context, RoutesName.admin_home);
        });
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
