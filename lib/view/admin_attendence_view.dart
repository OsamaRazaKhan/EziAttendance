import 'package:attendence_management_sys/model/attendence.dart';
import 'package:attendence_management_sys/resources/components/round_button.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/view/update_attendence_view.dart';
import 'package:attendence_management_sys/view_model/attendence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';

class AdminAttendanceView extends StatefulWidget {
  @override
  _AdminAttendanceViewState createState() => _AdminAttendanceViewState();
}

class _AdminAttendanceViewState extends State<AdminAttendanceView> {
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

  Future<void> _deleteAttendance(int attendanceId) async {
    final attendViewModel =
        Provider.of<AttendViewModel>(context, listen: false);
    globalattendenceid = attendanceId;
    await attendViewModel.DeleteAttend(context);
  }

  void _generateReport() {
    final attendViewModel =
        Provider.of<AttendViewModel>(context, listen: false);

    int totalPresents = 0;
    int totalAbsents = 0;
    int totalLeaves = 0;

    for (var attendance in attendViewModel.attendanceList) {
      if (attendance.status == 'Present') {
        totalPresents++;
      } else if (attendance.status == 'Absent') {
        totalAbsents++;
      } else if (attendance.status == 'Leave') {
        totalLeaves++;
      }
    }
    Map<String, int> report = {
      'totalPresents': totalPresents,
      'totalAbsents': totalAbsents,
      'totalLeaves': totalLeaves,
    };
    Navigator.pushNamed(
      context,
      RoutesName.singleStudent_report,
      arguments: report,
    );
  }

  @override
  Widget build(BuildContext context) {
    final attendViewModel = Provider.of<AttendViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(globalstu_fullname),
        backgroundColor: AppColors.app_bar,
      ),
      body: attendViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ListView.builder(
                      itemCount: attendViewModel.attendanceList.length,
                      itemBuilder: (context, index) {
                        final attendance =
                            attendViewModel.attendanceList[index];
                        return Card(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              'Date: ${DateFormat('yyyy-MM-dd').format(attendance.date).toString()}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Status: ${attendance.status}\nLeave Request: ${attendance.status == "Leave" ? "Yes" : "No"}',
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.update_attendence_view,
                                      arguments: attendance,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteAttendance(attendance.attendanceId);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RoundButton(
                    title: 'Generate Report',
                    onPress: _generateReport,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(
            context,
            RoutesName.add_attendance,
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Attendance',
      ),
    );
  }
}
