import 'package:attendence_management_sys/model/attendence.dart';
import 'package:attendence_management_sys/resources/color.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/view_model/attendence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendenceView extends StatefulWidget {
  @override
  _AttendenceViewState createState() => _AttendenceViewState();
}

class _AttendenceViewState extends State<AttendenceView> {
  @override
  void initState() {
    super.initState();
    _fetchAttendances();
  }

  void _fetchAttendances() {
    final attendViewModel =
        Provider.of<AttendViewModel>(context, listen: false);
    attendViewModel.GetAllAttends(context);
  }

  @override
  Widget build(BuildContext context) {
    final attendViewModel = Provider.of<AttendViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('View Attendance'),
        backgroundColor: AppColors.app_bar,
      ),
      body: attendViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: attendViewModel.attendanceList.length,
              itemBuilder: (context, index) {
                final attendance = attendViewModel.attendanceList[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(attendance.date).toString()}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Status: ${attendance.status}\nLeave Request: ${attendance.leaveRequest ? "Yes" : "No"}',
                      style: TextStyle(fontSize: 16),
                    ),
                    leading: Icon(
                      attendance.status == 'Present'
                          ? Icons.check_circle
                          : attendance.status == 'Absent'
                              ? Icons.cancel
                              : Icons.airplane_ticket,
                      color: attendance.status == 'Present'
                          ? Colors.green
                          : attendance.status == 'Absent'
                              ? Colors.red
                              : Colors.orange,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
