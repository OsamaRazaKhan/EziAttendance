import 'package:attendence_management_sys/model/attendence.dart';
import 'package:attendence_management_sys/utils/routes/routes.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/view/student_home_view.dart';
import 'package:attendence_management_sys/view/add_attendence_view.dart';
import 'package:attendence_management_sys/view/admin_attendence_view.dart';
import 'package:attendence_management_sys/view/admin_home_view.dart';
import 'package:attendence_management_sys/view/all_students_view.dart';
import 'package:attendence_management_sys/view/studentAttendence_view.dart';
import 'package:attendence_management_sys/view/allStudents_report_view.dart';
import 'package:attendence_management_sys/view/gradingSystem_view.dart';
import 'package:attendence_management_sys/view/generateLeaveRequest_view.dart';
import 'package:attendence_management_sys/view/leaveRequests_view.dart';
import 'package:attendence_management_sys/view/login_view.dart';
import 'package:attendence_management_sys/view/signup_view.dart';
import 'package:attendence_management_sys/view/singleStudent_report.dart';
import 'package:attendence_management_sys/view/update_attendence_view.dart';
import 'package:attendence_management_sys/view_model/attendence_view_model.dart';
import 'package:attendence_management_sys/view_model/auth_view_model.dart';
import 'package:attendence_management_sys/view_model/leaveRequest_view_model.dart';
import 'package:attendence_management_sys/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => AttendViewModel()),
        ChangeNotifierProvider(create: (_) => LeaveRequestViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
