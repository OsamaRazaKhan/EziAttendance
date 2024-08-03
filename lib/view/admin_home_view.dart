import 'package:attendence_management_sys/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:attendence_management_sys/view_model/user_view_model.dart';
import 'package:attendence_management_sys/model/user.dart';
import 'package:provider/provider.dart';

import '../resources/color.dart';

class AdminHomeView extends StatefulWidget {
  @override
  _AdminHomeViewState createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  User? admin;

  @override
  void initState() {
    super.initState();
    _loadAdminData();
  }

  Future<void> _loadAdminData() async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    User user = await userViewModel.getUser();
    setState(() {
      admin = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              admin?.fullName ?? 'Loading...',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 219, 212, 212)),
            ),
            Icon(
              Icons.notifications,
            )
          ],
        ),
        //  automaticallyImplyLeading: false,
        backgroundColor: AppColors.app_bar,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                _buildCard(
                  context,
                  icon: Icons.person,
                  title: 'Student Report',
                  subtitle: 'View attendance and report',
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.all_students_view);
                  },
                ),
                SizedBox(height: 16),
                _buildCard(
                  context,
                  icon: Icons.report,
                  title: 'System Report',
                  subtitle: 'View complete system report',
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.system_report_view);
                  },
                ),
                SizedBox(height: 16),
                _buildCard(
                  context,
                  icon: Icons.request_page,
                  title: 'Leave Requests',
                  subtitle: 'Approve or disapprove',
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.leaveRequests_view);
                  },
                ),
                SizedBox(height: 16),
                _buildCard(
                  context,
                  icon: Icons.grade,
                  title: 'Grading System',
                  subtitle: 'Manage grading system',
                  onTap: () {
                    // Navigate to grading system screen
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
        child: Icon(Icons.logout),
        tooltip: 'Logout',
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: admin?.profilePicture != null
                            ? NetworkImage(admin!.profilePicture!)
                            : AssetImage('assets/profile_picture.png')
                                as ImageProvider,
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  admin?.fullName ?? 'Loading...',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                admin?.username ?? 'Loading...',
                              ),
                              Text(
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                admin?.email ?? 'Loading...',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 134, 82, 177),
              ),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                }),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Account Setting'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
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

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
