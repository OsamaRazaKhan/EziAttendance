import 'package:attendence_management_sys/model/attendence.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/view/admin_attendence_view.dart';
import 'package:attendence_management_sys/view/admin_home_view.dart';
import 'package:attendence_management_sys/view/all_students_view.dart';
import 'package:attendence_management_sys/view/studentAttendence_view.dart';
import 'package:attendence_management_sys/view/leaveReport_view.dart';
import 'package:attendence_management_sys/view/login_view.dart';
import 'package:attendence_management_sys/view/signup_view.dart';
import 'package:attendence_management_sys/view/singleStudent_report.dart';
import 'package:attendence_management_sys/view/splash_view.dart';
import 'package:attendence_management_sys/view/student_home_view.dart';
import 'package:attendence_management_sys/view/system_report_view.dart';
import 'package:attendence_management_sys/view/update_attendence_view.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../view/add_attendence_view.dart';
import '../../view/generateLeaveRequest_view.dart';
import '../../view/leaverequests_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashView());

      case RoutesName.student_home:
        return MaterialPageRoute(
            builder: (BuildContext context) => StudentHomeView());

      case RoutesName.admin_home:
        return MaterialPageRoute(
            builder: (BuildContext context) => AdminHomeView());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpView());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LogInView());

      case RoutesName.studentAttendence_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => AttendenceView());

      case RoutesName.admin_attendence_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => AdminAttendanceView());

      case RoutesName.all_students_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserListView());

      case RoutesName.add_attendance:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddAttendanceView());

      case RoutesName.system_report_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => SystemReportView());

      case RoutesName.generateLeaveRequest_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => GenerateLeaveRequestView());

      case RoutesName.leaveReport_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => LeaveReportView());

      case RoutesName.leaveRequests_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => LeaveRequestsView());

      case RoutesName.singleStudent_report:
        final report = settings.arguments as Map<String, int>;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                SingleStudentReportView(report: report));

      case RoutesName.update_attendence_view:
        final attend = settings.arguments as Attendance;
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                UpdateAttendanceView(attendance: attend));

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No Route defined'),
            ),
          );
        });
    }
  }
}
