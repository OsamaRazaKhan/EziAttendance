import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceReportView extends StatefulWidget {
  @override
  _AttendanceReportViewState createState() => _AttendanceReportViewState();
}

class _AttendanceReportViewState extends State<AttendanceReportView> {
  final _formKey = GlobalKey<FormState>();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  DateTime? _startDate;
  DateTime? _endDate;

  List<Map<String, dynamic>> _reportData = [];

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

  void _generateReport() {
    if (_formKey.currentState!.validate()) {
      // Mock data for demonstration
      List<Map<String, dynamic>> reportData = [
        {
          'username': 'John Doe',
          'totalPresents': 15,
          'totalAbsents': 5,
          'totalLeaves': 2,
        },
        {
          'username': 'Jane Smith',
          'totalPresents': 18,
          'totalAbsents': 2,
          'totalLeaves': 1,
        },
        // Add more mock data as needed
      ];

      setState(() {
        _reportData = reportData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Start Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickDate(context, true),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
              SizedBox(height: 16),
              Text(
                'Select End Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickDate(context, false),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _generateReport,
                  child: Text('Check Report'),
                ),
              ),
              SizedBox(height: 24),
              _reportData.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _reportData.length,
                        itemBuilder: (context, index) {
                          var report = _reportData[index];
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username: ${report['username']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Total Presents: ${report['totalPresents']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Total Absents: ${report['totalAbsents']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Total Leaves: ${report['totalLeaves']}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
