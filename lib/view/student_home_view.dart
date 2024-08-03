import 'dart:convert';
import 'dart:io';

import 'package:attendence_management_sys/model/user.dart';
import 'package:attendence_management_sys/resources/app_url.dart';
import 'package:attendence_management_sys/resources/color.dart';
import 'package:attendence_management_sys/utils/global.dart';
import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:attendence_management_sys/view_model/attendence_view_model.dart';
import 'package:attendence_management_sys/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomeView extends StatefulWidget {
  @override
  _StudentHomeViewState createState() => _StudentHomeViewState();
}

class _StudentHomeViewState extends State<StudentHomeView>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  User? _user;

  File? _image;

  pickImage() async {
    XFile? picked_image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked_image != null) {
      _image = File(picked_image.path);
      List<int> imageBytes = await _image!.readAsBytes();
      globalProfilePic = base64Encode(imageBytes);
      setState(() {});
    }
  }

  uploadImage(UserViewModel userpref) async {
    User user = await userpref.getUser();
    Map data = {
      "UserID": user.userid,
      "Username": user.username,
      "Password": user.password,
      "FullName": user.fullName,
      "Email": user.email,
      "ProfilePicture": globalProfilePic,
      "Role": user.role
    };
    userpref.UpdateProfilePic(data, context);
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    UserViewModel userViewModel = UserViewModel();
    User user = await userViewModel.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    final attendViewModel = Provider.of<AttendViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _user?.fullName ?? 'Loading...',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 219, 212, 212)),
            ),
            const Icon(
              Icons.notifications,
            )
          ],
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: AppColors.app_bar,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildAnimatedButton(
                  context: context,
                  title: 'Mark Attendance',
                  icon: Icons.check_circle,
                  onTap: () async {
                    final SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    int userid = sp.getInt('userid')!;
                    String dateTime = DateFormat('yyyy-MM-dd')
                        .format(DateTime.now())
                        .toString();
                    Map data = {
                      "userId": userid,
                      "Date": dateTime,
                      "Status": "Present",
                      "LeaveRequest": false
                    };

                    attendViewModel.PostAttend(data, context);
                  },
                ),
                const SizedBox(height: 20),
                _buildAnimatedButton(
                  context: context,
                  title: 'View Attendance',
                  icon: Icons.view_list,
                  onTap: () async {
                    final SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    globaluserid = sp.getInt('userid')!;
                    Navigator.pushNamed(
                        context, RoutesName.studentAttendence_view);
                    //  attendViewModel.GetAllAttends(context);
                  },
                ),
                const SizedBox(height: 20),
                _buildAnimatedButton(
                  context: context,
                  title: 'Send Leave Request',
                  icon: Icons.send,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.generateLeaveRequest_view,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await userPreferences.remvoe();
          Navigator.pushNamed(context, RoutesName.login);
        },
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 134, 82, 177),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            pickImage();
                            uploadImage(userPreferences);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.memory(
                                base64Decode(_image != null
                                    ? globalProfilePic
                                    : _user!.profilePicture!),
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ))),
                      const SizedBox(width: 10),
                      Container(
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  _user?.fullName ?? 'Loading...',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                _user?.username ?? 'Loading...',
                              ),
                              Text(
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                _user?.email ?? 'Loading...',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Account Setting'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await userPreferences.remvoe();
                Navigator.pushNamed(context, RoutesName.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isVisible = false;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isVisible = true;
        });
        Future.delayed(const Duration(milliseconds: 200), onTap);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isVisible
              ? [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
