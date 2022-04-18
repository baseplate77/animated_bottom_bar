import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<SMIInput<bool>?> inputs = [];
  List<Artboard> artboards = [];
  List<String> assetPaths = [
    "assets/fire.riv",
    "assets/land.riv",
    "assets/mediation.riv",
    "assets/composer.riv",
    "assets/profile.riv",
  ];

  int currentActiveIndex = 0;

  initializeArtboard() async {
    for (var path in assetPaths) {
      final data = await rootBundle.load(path);

      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
          StateMachineController.fromArtboard(artboard, "State Machine 1");
      SMIInput<bool>? input;
      if (controller != null) {
        artboard.addController(controller);
        input = controller.findInput<bool>("status");
        input!.value = true;
      }
      inputs.add(input);
      artboards.add(artboard);
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await initializeArtboard();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: artboards.map<Widget>((artboard) {
              final index = artboards.indexOf(artboard);
              return BottomAppBarItem(
                artboard: artboard,
                currentIndex: currentActiveIndex,
                tabIndex: index,
                input: inputs[index],
                cb: () => setState(() {
                  inputs[index]!.value = currentActiveIndex == index;
                  currentActiveIndex = index;
                }),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    Key? key,
    required this.artboard,
    required this.cb,
    required this.currentIndex,
    required this.tabIndex,
    required this.input,
  }) : super(key: key);
  final Artboard? artboard;
  final VoidCallback cb;
  final int currentIndex;
  final int tabIndex;
  final SMIInput<bool>? input;

  @override
  Widget build(BuildContext context) {
    if (input != null) {
      input!.value = currentIndex == tabIndex;
    }
    return SizedBox(
      width: 100,
      height: 100,
      child: GestureDetector(
        onTap: cb,
        child: artboard == null ? const SizedBox() : Rive(artboard: artboard!),
      ),
    );
  }
}
