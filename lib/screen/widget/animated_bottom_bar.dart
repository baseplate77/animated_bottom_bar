import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimatedBottomAppBar extends StatefulWidget {
  const AnimatedBottomAppBar({Key? key}) : super(key: key);

  @override
  State<AnimatedBottomAppBar> createState() => _AnimatedBottomAppBarState();
}

class _AnimatedBottomAppBarState extends State<AnimatedBottomAppBar> {
  SMIInput<bool>? _landInput;
  SMIInput<bool>? _composerInput;
  SMIInput<bool>? _profileInput;
  SMIInput<bool>? _fireInput;
  SMIInput<bool>? _mediationInput;
  Artboard? _landArtboard;
  Artboard? _composerArtboard;
  Artboard? _profileArtboard;
  Artboard? _fireArtboard;
  Artboard? _mediationArtboard;

  int currentActiveIndex = 0;
  @override
  void initState() {
    super.initState();
    // land
    rootBundle.load("assets/land.riv").then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
          StateMachineController.fromArtboard(artboard, "State Machine 1");

      if (controller != null) {
        artboard.addController(controller);
        _landInput = controller.findInput<bool>("status");
        _landInput!.value = true;
      }
      _landArtboard = artboard;
    });
    // composer
    rootBundle.load("assets/composer.riv").then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
          StateMachineController.fromArtboard(artboard, "State Machine 1");

      if (controller != null) {
        artboard.addController(controller);
        _composerInput = controller.findInput<bool>("status");
        _composerInput!.value = true;
      }
      _composerArtboard = artboard;
    });
    // profile
    rootBundle.load("assets/profile.riv").then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
          StateMachineController.fromArtboard(artboard, "State Machine 1");

      if (controller != null) {
        artboard.addController(controller);
        _profileInput = controller.findInput<bool>("status");
        _profileInput!.value = true;
      }
      _profileArtboard = artboard;
    });
    // Fire
    rootBundle.load("assets/fire.riv").then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
          StateMachineController.fromArtboard(artboard, "State Machine 1");

      if (controller != null) {
        artboard.addController(controller);
        _fireInput = controller.findInput<bool>("status");
        _fireInput!.value = true;
      }
      _fireArtboard = artboard;
    });
    // Mediation
    rootBundle.load("assets/mediation.riv").then((data) async {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller =
          StateMachineController.fromArtboard(artboard, "State Machine 1");

      if (controller != null) {
        artboard.addController(controller);
        _mediationInput = controller.findInput<bool>("status");
        _mediationInput!.value = true;
      }
      _mediationArtboard = artboard;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF020828),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // fire
            BottomAppBarItem(
              artboard: _fireArtboard,
              currentIndex: currentActiveIndex,
              tabIndex: 0,
              input: _fireInput,
              text: "Stories",
              cb: () => setState(() {
                currentActiveIndex = 0;
              }),
            ),
            SizedBox(
              width: 5,
            ),
            // land
            BottomAppBarItem(
              artboard: _landArtboard,
              currentIndex: currentActiveIndex,
              tabIndex: 1,
              input: _landInput,
              text: "Sounds",
              cb: () => setState(() {
                currentActiveIndex = 1;
              }),
            ),
            SizedBox(
              width: 5,
            ),
            // Mediation
            BottomAppBarItem(
                artboard: _mediationArtboard,
                currentIndex: currentActiveIndex,
                tabIndex: 2,
                input: _mediationInput,
                text: "Meditation",
                cb: () => setState(() {
                      currentActiveIndex = 2;
                    })),
            SizedBox(
              width: 5,
            ),
            // composer
            BottomAppBarItem(
                artboard: _composerArtboard,
                currentIndex: currentActiveIndex,
                text: "Composer",
                tabIndex: 3,
                input: _composerInput,
                cb: () => setState(() {
                      currentActiveIndex = 3;
                    })),
            SizedBox(
              width: 5,
            ),
            // Profile
            BottomAppBarItem(
                artboard: _profileArtboard,
                currentIndex: currentActiveIndex,
                text: "Profile",
                tabIndex: 4,
                input: _profileInput,
                cb: () => setState(() {
                      currentActiveIndex = 4;
                    })),
          ],
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
    required this.text,
    required this.input,
  }) : super(key: key);
  final Artboard? artboard;
  final VoidCallback cb;
  final int currentIndex;
  final int tabIndex;
  final String text;
  final SMIInput<bool>? input;

  @override
  Widget build(BuildContext context) {
    if (input != null) {
      input!.value = currentIndex == tabIndex;
    }
    return Flexible(
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            // width: 100,
            // height: 100,
            child: GestureDetector(
              onTap: cb,
              child: artboard == null
                  ? const SizedBox()
                  : Rive(artboard: artboard!),
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: currentIndex == tabIndex
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: currentIndex == tabIndex
                    ? Colors.white
                    : const Color(0xFF56586F),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          )
        ],
      ),
    );
  }
}
