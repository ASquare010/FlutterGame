import 'package:flutter/material.dart';
import 'package:flutter_app/ModelClass/ThemeClass.dart';

const _COLOR_NORMAL = VeryLightBlue;

const _COLOR_NULL = Colors.transparent;

const _COLOR_HIGHLIGHT = lightGrey;

class BrikSize extends InheritedWidget {
  const BrikSize({
    Key key,
    @required this.size,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Size size;

  static BrikSize of(BuildContext context) {
    final brikSize = context.dependOnInheritedWidgetOfExactType<BrikSize>();
    assert(brikSize != null, "....");
    return brikSize;
  }

  @override
  bool updateShouldNotify(BrikSize old) {
    return old.size != size;
  }
}

///the basic brik for game panel
class Brick extends StatelessWidget {
  final Color color;

  const Brick._({Key key, this.color}) : super(key: key);

  const Brick.normal() : this._(color: _COLOR_NORMAL);

  const Brick.empty() : this._(color: _COLOR_NULL);

  const Brick.highlight() : this._(color: _COLOR_HIGHLIGHT);

  @override
  Widget build(BuildContext context) {
    final width = BrikSize.of(context).size.width;
    return SizedBox.fromSize(
      size: BrikSize.of(context).size,
      child: Container(
        margin: EdgeInsets.all(0.05 * width),
         padding: EdgeInsets.all(0.3),
         decoration:
            BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                border: Border.all(width: 0.10 * width, color: color)),
        child: Container(
          decoration:
          BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
        ),
      ),
    );
  }
}
