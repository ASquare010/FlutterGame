 import 'package:flutter/material.dart';
 import 'package:flutter_app/Games/Tetris/panel/page_portrait.dart';
   import 'package:flutter_localizations/flutter_localizations.dart';
 import 'gamer/gamer.dart';
import 'gamer/keyboard.dart';
import 'generated/TetrasModalClass.dart';
import 'material/audios.dart';
import 'panel/page_portrait.dart';
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class Tetras extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       localizationsDelegates: [TetrasModalClass.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
      navigatorObservers: [routeObserver],
      supportedLocales: TetrasModalClass.delegate.supportedLocales,
      home: Scaffold(
        body: Sound(child: Game(child: KeyboardController(child: _HomePage()))),
      ),
    );
  }
}

const SCREEN_BORDER_WIDTH = 3.0;


class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //only Android/iOS support land mode
    return   PagePortrait();
  }
}

