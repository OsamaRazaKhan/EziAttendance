import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.all(15),
          message: message,
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(20),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ))
        ..show(context),
    );
  }

  static void showFlushbarAndNavigate(
      BuildContext context, String message, String routeName) {
    // Show the Flushbar message
    Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 2),
        borderRadius: BorderRadius.circular(20),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        )).show(context).then((_) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, routeName);
    });
  }

  static void showFlushbarAndNavigat(
      BuildContext context, String message, String routeName) {
    // Show the Flushbar message
    Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 2),
        borderRadius: BorderRadius.circular(20),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        )).show(context).then((_) {
      Navigator.pop(context);
      Navigator.pushNamed(context, routeName);
    });
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }
}
