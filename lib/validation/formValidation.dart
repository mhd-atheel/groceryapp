
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class validation {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
    FirebaseAuth auth = FirebaseAuth.instance;
    String errorMessage = '';
   static  errorMsg(msg){
      // MotionToast.error(
      //   title:  Text("System's Notification",style: TextStyle(fontWeight: FontWeight.bold)),
      //   description:  Text(msg),
      //   width:MediaQuery.of(context!).size.width/1.2,
      //   position: MotionToastPosition.top,
      //   animationType:  AnimationType.fromTop,
      // ).show(context!);
     return Text(msg);
    }
    static  validateEmail(String? formEmail) {
      if (formEmail == null || formEmail.isEmpty)
        return errorMsg("Email address is required ");
      String pattern = r'\w+@\w+\.\w+';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
      return null;
    }
    static validatePassword(String? formPassword) {
      if (formPassword == null || formPassword.isEmpty)
        return errorMsg('Password address is required');
      String pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formPassword))
        return errorMsg(
            "Password must be at least 8 characters, include an uppercase letter, number and symbol."
        ) ;
      return null;
    }
  }

