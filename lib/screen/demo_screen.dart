import 'widget/animated_bottom_bar.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(height: 90, child: AnimatedBottomAppBar()),
      body: Center(
        child: Text(
          "Demo Screen",
        ),
      ),
    );
  }
}
