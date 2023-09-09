import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: const CircularProgressIndicator(
        color: Colors.white,
        backgroundColor:  Color(0xff27963c),
      ),
    );
  }
}
