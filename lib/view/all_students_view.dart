import 'package:attendence_management_sys/model/user.dart';
import 'package:attendence_management_sys/resources/color.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UserListView extends StatefulWidget {
  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  void _fetchStudents() {
    final attendViewModel = Provider.of<UserViewModel>(context, listen: false);
    attendViewModel.GetAllStudents(context);
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text('All Students'),
        ),
        backgroundColor: AppColors.app_bar,
      ),
      body: userViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView.builder(
                itemCount: userViewModel.studentList.length,
                itemBuilder: (context, index) {
                  final student = userViewModel.studentList[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: student.profilePicture != null
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(student.profilePicture!),
                            )
                          : CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                      title: Text(
                        student.fullName ?? student.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (student.email != null)
                            Text('User Id: ${student.userid}'),
                          Text(
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              'Email: ${student.email}'),
                          Text('Username: ${student.username}'),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        globaluserid = student.userid;
                        globalstu_fullname = student.fullName!;
                        globalstu_username = student.username;
                        Navigator.pushNamed(
                            context, RoutesName.admin_attendence_view);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
