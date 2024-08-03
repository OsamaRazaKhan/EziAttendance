import 'package:attendence_management_sys/model/leaverequest.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';
import '../view_model/leaveRequest_view_model.dart';

class LeaveRequestsView extends StatefulWidget {
  @override
  _LeaveRequestsViewState createState() => _LeaveRequestsViewState();
}

class _LeaveRequestsViewState extends State<LeaveRequestsView> {
  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
  }

  void _fetchLeaveRequests() {
    final leaveRequestViewModel =
        Provider.of<LeaveRequestViewModel>(context, listen: false);
    leaveRequestViewModel.GetAllLeaveRequests(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Leave Requests'),
        backgroundColor: AppColors.app_bar,
      ),
      body: Consumer<LeaveRequestViewModel>(
        builder: (context, leaveRequestViewModel, child) {
          if (leaveRequestViewModel.loading) {
            return Center(child: CircularProgressIndicator());
          }

          final leaveRequests = leaveRequestViewModel.leaveRequestList;

          return ListView.builder(
            itemCount: leaveRequests.length,
            itemBuilder: (context, index) {
              final leaveRequest = leaveRequests[index];
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User ID: ${leaveRequest.userId}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Request Date: ${DateFormat('yyyy-MM-dd').format(leaveRequest.requestDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Leave Date: ${DateFormat('yyyy-MM-dd').format(leaveRequest.leaveDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Reason: ${leaveRequest.reason}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          globaluserid = leaveRequest.userId;
                          globalLeaveReq = {
                            "leaveRequestID": leaveRequest.leaveRequestId,
                            "userID": leaveRequest.userId,
                            "requestDate": leaveRequest.requestDate.toString(),
                            "leaveDate": leaveRequest.leaveDate.toString(),
                            "reason": leaveRequest.reason,
                            "status": leaveRequest.status,
                          };
                          Navigator.pushNamed(
                              context, RoutesName.leaveReport_view);
                        },
                        child: Text('Check Report'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
