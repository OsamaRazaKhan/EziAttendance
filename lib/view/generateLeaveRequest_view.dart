import 'package:attendence_management_sys/resources/components/round_button.dart';
import 'package:attendence_management_sys/view_model/leaveRequest_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/color.dart';
import '../utils/global.dart';

class GenerateLeaveRequestView extends StatefulWidget {
  @override
  _GenerateLeaveRequestViewState createState() =>
      _GenerateLeaveRequestViewState();
}

class _GenerateLeaveRequestViewState extends State<GenerateLeaveRequestView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _leaveDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  DateTime? _selectedDate;

  FocusNode _dateFocusNode = FocusNode();
  FocusNode _reasonFocusNode = FocusNode();

  double _opacity = 0.0;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });

    _dateFocusNode.addListener(() {
      setState(() {
        _scale = _dateFocusNode.hasFocus ? 1.1 : 1.0;
      });
    });

    _reasonFocusNode.addListener(() {
      setState(() {
        _scale = _reasonFocusNode.hasFocus ? 1.1 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    _leaveDateController.dispose();
    _reasonController.dispose();
    _dateFocusNode.dispose();
    _reasonFocusNode.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _leaveDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final leaveRequestViewModel = Provider.of<LeaveRequestViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Request Leave'),
        backgroundColor: AppColors.app_bar,
      ),
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                AnimatedScale(
                  scale: _dateFocusNode.hasFocus ? 1.1 : 1.0,
                  duration: Duration(milliseconds: 200),
                  child: TextFormField(
                    controller: _leaveDateController,
                    readOnly: true,
                    focusNode: _dateFocusNode,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      labelText: 'Leave Date',
                      hintText: 'Select a date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                AnimatedScale(
                  scale: _reasonFocusNode.hasFocus ? 1.1 : 1.0,
                  duration: Duration(milliseconds: 200),
                  child: TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    focusNode: _reasonFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Reason',
                      hintText: 'Enter reason for leave',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a reason';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                RoundButton(
                    title: 'Submit Request',
                    loading: leaveRequestViewModel.loading,
                    onPress: () async {
                      String currentDate = DateFormat('yyyy-MM-dd')
                          .format(DateTime.now())
                          .toString();
                      String leaveDate = DateFormat('yyyy-MM-dd')
                          .format(_selectedDate!)
                          .toString();
                      final SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      int userid = sp.getInt('userid')!;

                      Map data = {
                        "userId": userid,
                        "requestDate": currentDate,
                        "leaveDate": leaveDate,
                        "reason": _reasonController.text,
                        "status": "pending"
                      };

                      leaveRequestViewModel.PostleaveRequest(data, context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
