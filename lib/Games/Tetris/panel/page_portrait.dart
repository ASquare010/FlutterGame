import 'package:flutter/material.dart';
  import 'package:flutter_app/Games/Tetris/panel/controller.dart';
import 'package:flutter_app/Games/Tetris/panel/screen.dart';
import 'package:flutter_app/ModelClass/ThemeClass.dart';
import '../tetris.dart';

class PagePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    final screenW = size.width * 0.8;

    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [lightGrey, darkGrey])),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              alignment: Alignment.bottomRight,              height: height * 0.97,
              width: width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
                gradient:
                LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [lightBlue, darkBlue]),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    color: black.withOpacity(0.3),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "Tetras",
                    style: TextStyle(color: white.withOpacity(0.1), fontSize: width * 0.3, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: <Widget>[
                  ScreenDecoration(child: Screen(width: screenW)),
                  Spacer(flex: 2),
                  GameController(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ScreenDecoration extends StatelessWidget {
  final Widget child;

  const ScreenDecoration({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFF15191F), width: SCREEN_BORDER_WIDTH),
          left: BorderSide(color: const Color(0xFF1F252D), width: SCREEN_BORDER_WIDTH),
          right: BorderSide(color: const Color(0xFF222831), width: SCREEN_BORDER_WIDTH),
          bottom: BorderSide(color: const Color(0xFF20262F), width: SCREEN_BORDER_WIDTH),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: Container(
          padding: const EdgeInsets.all(3),
          color: VeryLightBlue,
          child: child,
        ),
      ),
    );
  }
}
