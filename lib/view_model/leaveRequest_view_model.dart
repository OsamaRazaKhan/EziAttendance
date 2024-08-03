import 'package:attendence_management_sys/model/leaverequest.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/leave_request_repository.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class LeaveRequestViewModel with ChangeNotifier {
  final _myRepo = LeaveRequestRepository();

  List<LeaveRequest> _leaveRequestList = [];
  List<LeaveRequest> get leaveRequestList => _leaveRequestList;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _approveloading = false;
  bool get approveloading => _approveloading;

  setapproveLoading(bool value) {
    _approveloading = value;
    notifyListeners();
  }

  bool _disapproveloading = false;
  bool get disapproveloading => _disapproveloading;

  setdisapproveLoading(bool value) {
    _disapproveloading = value;
    notifyListeners();
  }

  Future<void> PostleaveRequest(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.GetPostLeaveRequestApi(data).then((value) async {
      setLoading(false);
      if (value is Map<String, dynamic>) {
        Utils.showFlushbarAndNavigate(
            context, 'Request Generated Successfully', RoutesName.student_home);
      } else if (value is String) {
        if (value.toString() == 'conflict')
          Utils.showFlushbarAndNavigate(
              context, 'Request Already Generated', RoutesName.student_home);
      } else {
        Utils.showFlushbarAndNavigate(
            context,
            'Something Went Wrong\n please try again later',
            RoutesName.student_home);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> PutLeaveReq(dynamic data, BuildContext context) async {
    if (data['status'] == 'Approved')
      setapproveLoading(true);
    else
      setdisapproveLoading(true);
    _myRepo.GetPutLeaveRequestApi(data).then((value) {
      if (value is Map<String, dynamic>) {
      } else if (value is String) {
        if (data['status'] == 'Approved')
          setapproveLoading(false);
        else
          setdisapproveLoading(false);
        if (value == 'no content')
          Utils.showFlushbarAndNavigate(context,
              'Request Approved Successfully', RoutesName.leaveRequests_view);
        else if (value == 'not acceptable')
          Utils.showFlushbarAndNavigate(
              context, 'Request Disapproved', RoutesName.leaveRequests_view);
        else
          Utils.showFlushbarAndNavigate(
              context,
              'Unexpected error\n please try again later',
              RoutesName.leaveRequests_view);
      } else {
        if (data['status'] == 'Approved')
          setapproveLoading(false);
        else
          setdisapproveLoading(false);
        Utils.showFlushbarAndNavigate(
            context,
            'Unexpected error\n please try again later',
            RoutesName.leaveRequests_view);
      }
    }).onError((error, stackTrace) {
      if (data['status'] == 'Approved')
        setapproveLoading(false);
      else
        setdisapproveLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<dynamic> GetAllLeaveRequests(BuildContext context) async {
    setLoading(true);
    _myRepo.GetAllLeaveRequestsApi().then((value) async {
      _leaveRequestList = value
          .map<LeaveRequest>((item) => LeaveRequest.fromMap(item))
          .toList();
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
}
