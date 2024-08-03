import 'package:attendence_management_sys/resources/color.dart';
import 'package:attendence_management_sys/resources/components/round_button.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/view_model/attendence_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/attendence.dart';
import '../resources/components/custom_dropdown.dart';

class UpdateAttendanceView extends StatefulWidget {
  final Attendance attendance;

  UpdateAttendanceView({required this.attendance});

  @override
  _UpdateAttendanceViewState createState() => _UpdateAttendanceViewState();
}

class _UpdateAttendanceViewState extends State<UpdateAttendanceView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  late DateTime _selectedDate;
  late String _selectedStatus;
  late bool _leaveRequest;
  bool _isDateSelected = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.attendance.date;
    _selectedStatus = widget.attendance.status;
    _leaveRequest = widget.attendance.leaveRequest;

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _isDateSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendViewModel = Provider.of<AttendViewModel>(context);
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
        padding: const EdgeInsets.only(
          top: 50,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Update Attendance Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: _isDateSelected
                          ? Colors.blue.shade100
                          : Colors.transparent,
                    ),
                    child: Text(
                      'Date: ${_dateFormat.format(_selectedDate)}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                CustomDropdownButton(
                  items: ['Present', 'Absent', 'Leave'],
                  selectedItem: 'Present',
                  onChanged: (value) {
                    _selectedStatus = value;
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: RoundButton(
                      title: " Update ",
                      loading: attendViewModel.loading,
                      onPress: () {
                        globalattendenceid = widget.attendance.attendanceId;

                        Map data = {
                          "attendanceID": widget.attendance.attendanceId,
                          "userID": widget.attendance.userId,
                          "Date": _selectedDate.toString(),
                          "Status": _selectedStatus,
                          "leaveRequest": _selectedStatus == "Leave" ? 1 : 0,
                        };
                        attendViewModel.PutAttend(data, context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
