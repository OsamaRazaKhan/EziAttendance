import 'package:attendence_management_sys/model/attendence.dart';
import 'package:attendence_management_sys/repository/attendence_repository.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendViewModel with ChangeNotifier {
  final _myRepo = AttendenceRepository();

  List<Attendance> _attendanceList = [];
  List<Attendance> get attendanceList => _attendanceList;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<dynamic> GetAllAttends(BuildContext context) async {
    setLoading(true);
    _myRepo.GetAllAttendsApi().then((value) async {
      _attendanceList =
          value.map<Attendance>((item) => Attendance.fromMap(item)).toList();
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

  Future<dynamic> GetReport(BuildContext context) async {
    setLoading(true);
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _myRepo.GetReportApi().then((value) async {
      _attendanceList =
          value.map<Attendance>((item) => Attendance.fromMap(item)).toList();
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

  Future<void> PostAttend(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.GetPostAttendenceApi(data).then((value) async {
      setLoading(false);
      final SharedPreferences sp = await SharedPreferences.getInstance();
      if (value is Map<String, dynamic>) {
        if (sp.getString('role') == 'Student')
          Utils.flushBarErrorMessage('Attendence Marked Successfully', context);
        else {
          Utils.showFlushbarAndNavigate(
              context,
              'Attendence Added Successfully',
              RoutesName.admin_attendence_view);
        }
        if (kDebugMode) {
          print(value.toString());
        }
        print('Received JSON response: $value');
      } else if (value is String) {
        if (value.toString() == 'conflict')
          Utils.flushBarErrorMessage('Attendence Already Marked', context);
        print('Received String response: $value');
      } else {
        Utils.flushBarErrorMessage('Unexpected error', context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> PutAttend(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.GetPutAttendenceApi(data).then((value) {
      if (value is Map<String, dynamic>) {
        setLoading(false);
        Utils.showFlushbarAndNavigate(
            context,
            'Attendence Updated Successfully',
            RoutesName.admin_attendence_view);
        if (kDebugMode) {
          print(value.toString());
        }
        print('Received JSON response: $value');
      } else if (value is String) {
        setLoading(false);
        Utils.showFlushbarAndNavigate(
            context,
            'Attendence Updated Successfully',
            RoutesName.admin_attendence_view);
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

  Future<void> GetSingleAttend(BuildContext context) async {}

  Future<void> DeleteAttend(BuildContext context) async {
    setLoading(true);
    _myRepo.GetDeleteAttendApi().then((value) async {
      setLoading(false);
      Utils.showFlushbarAndNavigat(
          context, 'Deleted successfully', RoutesName.admin_attendence_view);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
