import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'package:flutter_app/ModelClass/ThemeClass.dart';
import 'package:flutter_svg/svg.dart';

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  final int squaresPerRow = 25;
  final int squaresPerCol = 40;
  final fontStyle = TextStyle(color: Colors.white, fontSize: 20);
  final randomGen = Random();

  var snake = [
    [0, 1],
    [0, 0]
  ];
  var food = [0, 2];
  var direction = 'up';
  var isPlaying = false;

  void startGame() {
    const duration = Duration(milliseconds: 300);

    snake = [
      // Snake head
      [(squaresPerRow / 2).floor(), (squaresPerCol / 2).floor()]
    ];

    snake.add([snake.first[0], snake.first[1] + 1]); // Snake body

    createFood();

    isPlaying = true;
    Timer.periodic(duration, (Timer timer) {
      moveSnake();
      if (checkGameOver()) {
        timer.cancel();
        endGame();
      }
    });
  }

  void moveSnake() {
    setState(() {
      switch (direction) {
        case 'up':
          snake.insert(0, [snake.first[0], snake.first[1] - 1]);
          break;

        case 'down':
          snake.insert(0, [snake.first[0], snake.first[1] + 1]);
          break;

        case 'left':
          snake.insert(0, [snake.first[0] - 1, snake.first[1]]);
          break;

        case 'right':
          snake.insert(0, [snake.first[0] + 1, snake.first[1]]);
          break;
      }

      if (snake.first[0] != food[0] || snake.first[1] != food[1]) {
        snake.removeLast();
      } else {
        createFood();
      }
    });
  }

  void createFood() {
    food = [randomGen.nextInt(squaresPerRow), randomGen.nextInt(squaresPerCol)];
  }

  bool checkGameOver() {
    if (!isPlaying ||
        snake.first[1] < 0 ||
        snake.first[1] >= squaresPerCol ||
        snake.first[0] < 0 ||
        snake.first[0] > squaresPerRow) {
      return true;
    }

    for (var i = 1; i < snake.length; ++i) {
      if (snake[i][0] == snake.first[0] && snake[i][1] == snake.first[1]) {
        return true;
      }
    }

    return false;
  }

  void endGame() {
    isPlaying = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: darkGrey,
            title: Text('Game Over',style: TextStyle( color: grey),),
            content: Text(
              'Score: ${snake.length - 2}',
              style: TextStyle(fontSize: 20, color: grey),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close',style: TextStyle( color: grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton:
        isPlaying?Container():
        FloatingActionButton(
          onPressed: (){
            Navigator.pop(context);
          },
          mini: true,backgroundColor: midGrey,
          child: Icon(Icons.arrow_back_ios_outlined,color: grey,size: 15,),
        ),
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [lightGrey, darkGrey])),
              child: Align(
                  alignment: Alignment(-0.8, 0),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Now Playing -",
                            style: TextStyle(color: grey.withOpacity(0.6), fontSize: 45),
                          ),
                          Stack(
                            children: <Widget>[
                              // Stroked text as border.
                              Text(
                                'Snake,',
                                style: TextStyle(
                                  fontSize: 55,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 3
                                    ..color = grey,
                                ),
                              ),
                              Text(
                                'Snake,',
                                style: TextStyle(
                                  fontSize: 55,
                                  color: midGrey,
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )),
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
                  'Score: ${snake.length - 2}',
                  style: TextStyle(color: white.withOpacity(0.5), fontSize: width * 0.25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: GestureDetector(

                onVerticalDragUpdate: (details) {
                  print("do");
                  if (direction != 'up' && details.delta.dy > 0) {
                    direction = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    direction = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  print("do");

                  if (direction != 'left' && details.delta.dx > 0) {
                    direction = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    direction = 'left';
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: AspectRatio(
                    aspectRatio: squaresPerRow / (squaresPerCol + 1),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: squaresPerRow,
                        ),
                        itemCount: squaresPerRow * squaresPerCol,
                        itemBuilder: (BuildContext context, int index) {
                          var color;
                          var x = index % squaresPerRow;
                          var y = (index / squaresPerRow).floor();

                          bool isSnakeBody = false;
                          for (var pos in snake) {
                            if (pos[0] == x && pos[1] == y) {
                              isSnakeBody = true;
                              break;
                            }
                          }

                          if (snake.first[0] == x && snake.first[1] == y) {
                            color = VeryLightBlue;
                          } else if (isSnakeBody) {
                            color = darkGrey;
                          } else if (food[0] == x && food[1] == y) {
                            color = Colors.pink;
                          } else {
                            color = lightGrey.withOpacity(0.5);
                          }

                          return Container(
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
                          );
                        }),
                  ),
                ),
              ),
            ),
            if (!isPlaying)
              Align(
                  alignment: Alignment.bottomCenter,
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
                              onPressed: () {
                                if (isPlaying) {
                                  isPlaying = false;
                                } else {
                                  startGame();
                                }
                              },
                              icon: isPlaying
                                  ? Icon(
                                      Icons.play_arrow_outlined,
                                      color: grey,
                                    )
                                  : Icon(
                                      Icons.pause,
                                      color: grey,
                                    ),
                            )),
                        Material(
                          elevation: 4,
                          color: lightGrey,
                          shadowColor: black,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.horizontal(left: Radius.circular(60), right: Radius.circular(60))),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 10),
                                child: Text(
                                  'Gems : ${snake.length - 2}',
                                  style: TextStyle(color: white),
                                ),
                              ),
                              Material(
                                color: midGrey,
                                shape: CircleBorder(),
                                child: IconButton(
                                  splashColor: darkBlue,
                                  splashRadius: 20,
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
        ),
      ),
    );
  }
}
