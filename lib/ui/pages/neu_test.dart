import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuTest extends StatefulWidget {
  const NeuTest({Key? key}) : super(key: key);

  static const String routeName = '/neu_test_page';

  @override
  State<NeuTest> createState() => _NeuTestState();
}

class _NeuTestState extends State<NeuTest> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NeumorphicButton(
              duration: Duration(milliseconds: 180),
              child: NeumorphicIcon(
                Icons.skip_previous,
                size: 40,
                style: NeumorphicStyle(
                  color: Colors.black45,
                ),
              ),
              style: NeumorphicStyle(
                // border: NeumorphicBorder(
                //   isEnabled: true,
                //   color: Colors.grey,
                //   width: 0.3,
                // ),
                color: Colors.white,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              onPressed: () => print('Neumorphic test'),
            ),
            NeumorphicButton(
              provideHapticFeedback: true,
              duration: Duration(milliseconds: 180),
              child: isPlaying
                  ? Icon(Icons.pause, size: 60)
                  : Icon(Icons.play_arrow, size: 60),
              style: NeumorphicStyle(
                color: Colors.white,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              onPressed: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              drawSurfaceAboveChild: true,
            ),
            NeumorphicButton(
              duration: Duration(milliseconds: 180),
              child: NeumorphicIcon(
                Icons.skip_next,
                size: 40,
                style: NeumorphicStyle(
                  color: Colors.black45,
                ),
              ),
              style: NeumorphicStyle(
                color: Colors.white,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              onPressed: () => print('Neumorphic test'),
            ),
          ],
        ),
      ),
    );
  }
}
