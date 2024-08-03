import 'package:attendence_management_sys/utils/global.dart';

class AppUrl {
  static String get baseUrl => 'http://192.168.43.134/attendence_sys_api/api/';

  ////for users
  static String get loginEndPoint =>
      '$baseUrl/users/login?email=$globalemail&password=$globalpassword';

  static String get getstudentsEndPoint => '$baseUrl/users/getusers';

  static String get registerApiEndPoint => '$baseUrl/users/postuser';

  static String get putUserApiEndPoint => '$baseUrl/users/putuser';

  ////for Attendence
  static String get postAttendenceApiEndPoint =>
      '$baseUrl/attendance/postattandence';

  static String get getallattendsApiEndPoint =>
      '$baseUrl/attendance/getattendances?id=$globaluserid';

  static String get getreportApiEndPoint => '$baseUrl/attendance/getreport';

  static String get getsingleattendApiEndPoint =>
      '$baseUrl/attendance/getattandence?id=$globalattendenceid';

  static String get putAttendenceApiEndPoint =>
      '$baseUrl/attendance/putattendance?id=$globalattendenceid';

  static String get deleteAttendenceApiEndPoint =>
      '$baseUrl/attendance/deleteattandance?id=$globalattendenceid';

  ////for LeaveRequest
  static String get postLeaveRequestApiEndPoint =>
      '$baseUrl/leaverequests/postleaverequest';

  static String get getLeaveRequestsApiEndPoint =>
      '$baseUrl/leaverequests/getleaverequests';

  static String get putLeaveRequestApiEndPoint =>
      '$baseUrl/leaverequests/putleaverequest';
}
