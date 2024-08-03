import 'package:attendence_management_sys/model/attendence.dart';
import 'package:attendence_management_sys/resources/color.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/view_model/attendence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/attendancesummary.dart';

class SystemReportView extends StatefulWidget {
  @override
  _SystemReportViewState createState() => _SystemReportViewState();
}

class _SystemReportViewState extends State<SystemReportView> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  DateTime? _startDate;
  DateTime? _endDate;
  Future<Map<int, UserAttendanceSummary>>? _userSummariesFuture;

  @override
  void initState() {
    super.initState();
    _fetchAttendances();
  }

  void _fetchAttendances() {
    final attendViewModel =
        Provider.of<AttendViewModel>(context, listen: false);
    attendViewModel.GetReport(context);
  }

  void _pickDate(BuildContext context, bool isStart) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _checkReport() {
    setState(() {
      _userSummariesFuture = _generateUserSummaries();
    });
  }

  Future<Map<int, UserAttendanceSummary>> _generateUserSummaries() async {
    final attendViewModel =
        Provider.of<AttendViewModel>(context, listen: false);
    final List<Attendance> attendanceList = attendViewModel.attendanceList;

    final Map<int, UserAttendanceSummary> summaries = {};

    for (var attendance in attendanceList) {
      if ((_startDate == null ||
              attendance.date
                  .isAfter(_startDate!.subtract(const Duration(days: 1)))) &&
          (_endDate == null ||
              attendance.date
                  .isBefore(_endDate!.add(const Duration(days: 1))))) {
        final userId = attendance.userId;

        if (!summaries.containsKey(userId)) {
          summaries[userId] = UserAttendanceSummary(userId: userId);
        }

        if (attendance.status == 'Present') {
          summaries[userId]!.totalPresents++;
        } else if (attendance.status == 'Absent') {
          summaries[userId]!.totalAbsents++;
        } else if (attendance.status == 'Leave') {
          summaries[userId]!.totalLeaves++;
        }

        // if (attendance.leaveRequest) {
        //   summaries[userId]!.totalLeaves++;
        // }
      }
    }

    return summaries;
  }

  @override
  Widget build(BuildContext context) {
    final attendViewModel = Provider.of<AttendViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('System Attendance Report'),
        backgroundColor: AppColors.app_bar,
      ),
      body: attendViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Select Date Range',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _pickDate(context, true),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _startDate == null
                                  ? 'Select Start Date'
                                  : _dateFormat.format(_startDate!),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _pickDate(context, false),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _endDate == null
                                  ? 'Select End Date'
                                  : _dateFormat.format(_endDate!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _checkReport,
                    child: Text('Check Report'),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: _userSummariesFuture == null
                        ? Center(child: Text(''))
                        : FutureBuilder<Map<int, UserAttendanceSummary>>(
                            future: _userSummariesFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text('No report to display'));
                              } else {
                                final userSummaries = snapshot.data!;
                                return ListView.builder(
                                  itemCount: userSummaries.length,
                                  itemBuilder: (context, index) {
                                    final userSummary =
                                        userSummaries.values.elementAt(index);
                                    return Card(
                                      margin: EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Text(
                                          'User ID: ${userSummary.userId}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Total Presents: ${userSummary.totalPresents}\nTotal Absents: ${userSummary.totalAbsents}\nTotal Leaves: ${userSummary.totalLeaves}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
