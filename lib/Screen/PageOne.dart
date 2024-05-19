import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Games/Snake/SnakeGame.dart';
import 'package:flutter_app/Games/Tetris/tetris.dart';
 import 'package:flutter_app/ModelClass/ThemeClass.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  var isSelected = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [lightGrey, darkGrey])),
          child: Align(
              alignment: Alignment(-0.8, -0.65),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Powered By:",
                      style: TextStyle(color: grey.withOpacity(0.6), fontSize: 20),
                    ),
                    Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'A Square,',
                          style: TextStyle(
                            fontSize: 35,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = grey,
                          ),
                        ),
                        Text(
                          'A Square,',
                          style: TextStyle(
                            fontSize: 35,
                            color: midGrey,
                          ),
                        ),
                      ],
                    ),
                  ])),
        ),
        Container(
          alignment: Alignment.bottomRight,
          height: height * 0.8,
          width: width * 0.45,
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
            child: Text(
              "AppName",
              style: TextStyle(color: white.withOpacity(0.06), fontSize: width * 0.25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 35),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListHighScore(
                        gameLogo: "assets/images/Cristels.svg",
                        highScore: "10k",
                      ),
                      ListHighScore(
                        gameLogo: "assets/images/snakeLogo.svg",
                        highScore: "0",
                      ),
                      ListHighScore(
                        gameLogo: "assets/images/Tetras.svg",
                        highScore: "2",
                      ),
                      ListHighScore(
                        gameLogo: "assets/images/trap.svg",
                        highScore: "42k",
                      ),
                      ListHighScore(
                        gameLogo: "assets/images/Cristels.svg",
                        highScore: "10",
                      ),
                    ],
                  )),
              SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 80),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GameTileButton(navigateGame: SnakeGame(),title: "Snake Game",svgString: "assets/images/snakeLogo.svg",),
                      GameTileButton(navigateGame: Tetras(),title: "Tetras Game",svgString: "assets/images/Tetras.svg",),

                    ],
                  )),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                      elevation: 4,
                      color: midGrey,
                      shadowColor: black,
                      shape: CircleBorder(),
                      child: IconButton(
                        splashColor: darkBlue,
                        splashRadius: 20,
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: grey,
                        ),
                      )),
                  Material(
                    elevation: 4,
                    color: lightGrey,
                    shadowColor: black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(60), right: Radius.circular(60))),
                    child: Row(
                      children: [
                        if (isSelected)
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: Text(
                              "56K",
                              style: TextStyle(color: white),
                            ),
                          ),
                        Material(
                          color: midGrey,
                          shape: CircleBorder(),
                          child: IconButton(
                            splashColor: darkBlue,
                            splashRadius: 20,
                            onPressed: () {
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            icon: SvgPicture.asset(
                              "assets/images/Cristels.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}

// ignore: must_be_immutable
class GameTileButton extends StatelessWidget {
  GameTileButton({this.navigateGame,this.svgString,this.title});
  Widget navigateGame;
  String title , svgString ;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: width*0.65,
      width: width*0.65,
        child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => navigateGame));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/itled-1.svg",
            ),
            Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(child: SvgPicture.asset(svgString)),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        color: grey,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListHighScore extends StatefulWidget {
  String highScore, gameLogo;

  ListHighScore({this.highScore, this.gameLogo});

  @override
  _ListHighScoreState createState() => _ListHighScoreState(highScore, gameLogo);
}

class _ListHighScoreState extends State<ListHighScore> {
  String _highScore, _gameLogo;

  _ListHighScoreState(this._highScore, this._gameLogo);

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        elevation: 4,
        color: lightGrey,
        shadowColor: black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(60), right: Radius.circular(60))),
        child: Row(
          children: [
            Material(
              color: midGrey,
              shape: CircleBorder(),
              child: IconButton(
                iconSize: 40,
                splashColor: darkBlue,
                splashRadius: 25,
                onPressed: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                icon: SvgPicture.asset(
                  _gameLogo,
                ),
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Text(
                  "HighScore : $_highScore",
                  style: TextStyle(color: white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
