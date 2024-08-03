import 'package:attendence_management_sys/resources/color.dart';
import 'package:flutter/material.dart';

class AnnimatedButton extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final bool loading;
  final VoidCallback onPress;

  const AnnimatedButton(
      {Key? key,
      required this.title,
      this.loading = false,
      required this.onPress,
      required this.color,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPress,
      icon: Icon(icon, color: Colors.white),
      label: loading
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              title,
              style: TextStyle(color: AppColors.whiteColor),
            ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
