import 'package:animated_bottom_bar/animated_bottom_bar.dart';
import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(height: 90, child: AnimatedBottomAppBar()),
      body: Center(
        child: Text(
          "Temp Screen",
        ),
      ),
    );
  }
}
