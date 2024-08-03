import 'package:attendence_management_sys/resources/color.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/view_model/attendence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SingleStudentReportView extends StatefulWidget {
  final Map<String, int> report;

  SingleStudentReportView({required this.report});

  @override
  _SingleStudentReportViewState createState() =>
      _SingleStudentReportViewState();
}

class _SingleStudentReportViewState extends State<SingleStudentReportView>
    with SingleTickerProviderStateMixin {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  DateTime? _startDate;
  DateTime? _endDate;
  int totalPresents = 0;
  int totalAbsents = 0;
  int totalLeaves = 0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    totalPresents = widget.report['totalPresents'] ?? 0;
    totalAbsents = widget.report['totalAbsents'] ?? 0;
    totalLeaves = widget.report['totalLeaves'] ?? 0;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    final attendViewModel =
        Provider.of<AttendViewModel>(context, listen: false);
    final filteredAttendances =
        attendViewModel.attendanceList.where((attendance) {
      final attendanceDate = attendance.date;
      if (_startDate != null && _endDate != null) {
        return attendanceDate
                .isAfter(_startDate!.subtract(Duration(days: 1))) &&
            attendanceDate.isBefore(_endDate!.add(Duration(days: 1)));
      } else if (_startDate != null) {
        return attendanceDate.isAfter(_startDate!.subtract(Duration(days: 1)));
      } else if (_endDate != null) {
        return attendanceDate.isBefore(_endDate!.add(Duration(days: 1)));
      }
      return true;
    }).toList();

    int presents = 0;
    int absents = 0;
    int leaves = 0;

    for (var attendance in filteredAttendances) {
      if (attendance.status == 'Present') {
        presents++;
      } else if (attendance.status == 'Absent') {
        absents++;
      } else if (attendance.leaveRequest) {
        leaves++;
      }
    }

    setState(() {
      totalPresents = presents;
      totalAbsents = absents;
      totalLeaves = leaves;
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Text('$globalstu_fullname'),
        ),
        backgroundColor: AppColors.app_bar,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16.0, right: 16),
        child: Column(
          children: [
            Text(
              'Select Date Range',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickDate(context, true),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _startDate == null
                            ? 'Select Start Date'
                            : _dateFormat.format(_startDate!),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _pickDate(context, false),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _endDate == null
                            ? 'Select End Date'
                            : _dateFormat.format(_endDate!),
                        style: TextStyle(fontSize: 14),
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
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            ScaleTransition(
              scale: _animation,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    //   backgroundImage: NetworkImage(globalstu_profilePicture),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'User Id: ${globaluserid}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Full Name: ${globalstu_fullname}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 24),
                  _buildReportCard(
                      'Total Presents', totalPresents, Colors.green),
                  _buildReportCard('Total Absents', totalAbsents, Colors.red),
                  _buildReportCard('Total Leaves', totalLeaves, Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: color.withOpacity(0.2),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(
              count.toString(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
