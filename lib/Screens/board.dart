import 'package:flutter/material.dart';
import 'package:align_positioned/align_positioned.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:tic_tac/Widgets/confetti.dart';
import 'package:tic_tac/Widgets/drawboard.dart';
import 'package:tic_tac/Widgets/boardsquares.dart';

import '../Widgets/winortie.dart';
import 'package:tic_tac/Providers/gameprovider.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<StatefulWidget> createState() => _Board();
}

class _Board extends State<Board> {
  bool isPlayer1 = true; //player 1 is X, player 2 is O
  int winState = 0; //1 is no win, 2 is win, and 3 is tie
  bool update = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<Preferences>(builder: (context, pref, child) {
      return Consumer<GameProvider>(builder: (context, game, child) {
        Builder interactiveSquare(
          double h,
          double w,
          int i,
        ) {
          return Builder(builder: ((context) {
            if (game.spaceCheck(i)) {
              return piecePlaced(h, w, game.pieceCheck(i), pref.secondary);
            }
            return GestureDetector(
                onTap: () {
                  setState(() {});
                  game.placePieces(isPlayer1, i);
                  game.switchTurns(!isPlayer1);
                  if (game.ai == true && game.turn == true) {
                    winState = game.boardCheck(
                        isPlayer1); //check winstate to make sure there wasn't a winning play
                    if (winState == 1) {
                      isPlayer1 = game.piece;
                      int spot = game.aiTurn(isPlayer1, args);
                      game.placePieces(isPlayer1, spot);
                      game.switchTurns(!isPlayer1);
                    }
                  }
                },
                child: emptySquare(h, w, pref.secondary));
          }));
        }

        Row buildRows(
            double h, double w, List<int> i, double sh, double sw, bool inter) {
          if (inter) {
            return Row(
              children: [
                interactiveSquare(h, w, i[0]),
                SizedBox(height: sh, width: sw),
                interactiveSquare(h, w, i[1]),
                SizedBox(height: sh, width: sw),
                interactiveSquare(h, w, i[2]),
              ],
            );
          }
          return Row(
            children: [
              square(h, w, i[0], game, pref),
              SizedBox(height: sh, width: sw),
              square(h, w, i[1], game, pref),
              SizedBox(height: sh, width: sw),
              square(h, w, i[2], game, pref),
            ],
          );
        }

        winState = game.boardCheck(isPlayer1);
        if (winState == 2) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            return Stack(children: [
              SizedBox(child: Builder(
                builder: ((context) {
                  Future.delayed(const Duration(seconds: 5), () {
                    showDialog(
                        context: context,
                        builder: ((BuildContext context) {
                          return winOrTie(true, game, context);
                        }));
                  });
                  return const SizedBox();
                }),
              )),
              Scaffold(
                appBar: AppBar(
                    title: const Text(
                  'Winner!',
                  textAlign: TextAlign.center,
                )),
                body: Center(
                    child: Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: width,
                      child: CustomPaint(painter: BoardMaker(pref.secondary)),
                    ),
                    AlignPositioned(
                      alignment: Alignment.topLeft,
                      dx: width * .095,
                      dy: height * .18,
                      child: Column(children: [
                        buildRows(height * .115, width * .25, [0, 1, 2],
                            height * .1, width * .02, false),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [3, 4, 5],
                            height * .1, width * .02, false),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [6, 7, 8],
                            height * .1, width * .02, false),
                      ]),
                    )
                  ],
                )),
              ),
              const ConfettiWidgets(
                  child: Center(child: SizedBox(height: 50, width: 50))),
            ]);
          } else {
            return Stack(children: [
              SizedBox(child: Builder(
                builder: ((context) {
                  Future.delayed(const Duration(seconds: 5), () {
                    showDialog(
                        context: context,
                        builder: ((BuildContext context) {
                          return winOrTie(true, game, context);
                        }));
                  });
                  return const SizedBox();
                }),
              )),
              Scaffold(
                appBar: AppBar(
                    title: const Text(
                  'Winner!',
                  textAlign: TextAlign.center,
                )),
                body: Center(
                    child: Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: width,
                      child: CustomPaint(painter: BoardMaker(pref.secondary)),
                    ),
                    AlignPositioned(
                      alignment: Alignment.topLeft,
                      dx: width * .2,
                      dy: height * .07,
                      child: Column(children: [
                        buildRows(height * .2, width * .125, [0, 1, 2],
                            height * .1, width * .012, false),
                        SizedBox(height: height * .009, width: width * .012),
                        buildRows(height * .2, width * .125, [3, 4, 5],
                            height * .1, width * .012, false),
                        SizedBox(height: height * .03, width: width * .012),
                        buildRows(height * .2, width * .125, [6, 7, 8],
                            height * .1, width * .012, false),
                      ]),
                    )
                  ],
                )),
              ),
              const ConfettiWidgets(
                  child: Center(child: SizedBox(height: 50, width: 50))),
            ]);
          }
        }
        if (winState == 1) {
          isPlayer1 = game.piece;
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            return Scaffold(
                appBar: AppBar(
                    leading: BackButton(
                      onPressed: () {
                        game.emptyBoard();
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text('${game.name}\'s turn')),
                body: Stack(children: [
                  SizedBox(
                    height: height,
                    width: width,
                    child: CustomPaint(painter: BoardMaker(pref.secondary)),
                  ),
                  AlignPositioned(
                      alignment: Alignment.topLeft,
                      dx: width * .095,
                      dy: height * .18,
                      child: Column(children: [
                        buildRows(height * .115, width * .25, [0, 1, 2],
                            height * .1, width * .02, true),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [3, 4, 5],
                            height * .1, width * .02, true),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [6, 7, 8],
                            height * .1, width * .02, true),
                      ]))
                ]));
          }
          if (MediaQuery.of(context).orientation == Orientation.landscape) {
            return Scaffold(
                appBar: AppBar(
                    leading: BackButton(
                      onPressed: () {
                        game.emptyBoard();
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text('${game.name}\'s turn')),
                body: Stack(children: [
                  SizedBox(
                    height: height,
                    width: width,
                    child: CustomPaint(painter: BoardMaker(pref.secondary)),
                  ),
                  AlignPositioned(
                      alignment: Alignment.topLeft,
                      dx: width * .2,
                      dy: height * .07,
                      child: Column(children: [
                        buildRows(height * .2, width * .125, [0, 1, 2],
                            height * .1, width * .012, true),
                        SizedBox(height: height * .009, width: width * .012),
                        buildRows(height * .2, width * .125, [3, 4, 5],
                            height * .1, width * .012, true),
                        SizedBox(height: height * .03, width: width * .012),
                        buildRows(height * .2, width * .125, [6, 7, 8],
                            height * .1, width * .012, true),
                      ]))
                ]));
          }
        }

        if (winState == 3) {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            return Stack(
              children: [
                SizedBox(child: Builder(
                  builder: ((context) {
                    Future.delayed(const Duration(seconds: 5), () {
                      showDialog(
                          context: context,
                          builder: ((BuildContext context) {
                            return winOrTie(false, game, context);
                          }));
                    });
                    return const SizedBox();
                  }),
                )),
                Scaffold(
                  appBar: AppBar(
                      title: const Text(
                    'Tie?',
                    textAlign: TextAlign.center,
                  )),
                  body: Center(
                      child: Stack(
                    children: [
                      SizedBox(
                        height: height,
                        width: width,
                        child: CustomPaint(painter: BoardMaker(pref.secondary)),
                      ),
                      AlignPositioned(
                        alignment: Alignment.topLeft,
                        dx: width * .095,
                        dy: height * .18,
                        child: Column(children: [
                          buildRows(height * .115, width * .25, [0, 1, 2],
                              height * .1, width * .02, false),
                          SizedBox(height: height * .007, width: width * .04),
                          buildRows(height * .115, width * .25, [3, 4, 5],
                              height * .1, width * .02, false),
                          SizedBox(height: height * .007, width: width * .04),
                          buildRows(height * .115, width * .25, [6, 7, 8],
                              height * .1, width * .02, false),
                        ]),
                      )
                    ],
                  )),
                ),
              ],
            );
          } else {
            return Stack(children: [
              SizedBox(child: Builder(
                builder: ((context) {
                  Future.delayed(const Duration(seconds: 5), () {
                    showDialog(
                        context: context,
                        builder: ((BuildContext context) {
                          return winOrTie(false, game, context);
                        }));
                  });
                  return const SizedBox();
                }),
              )),
              Scaffold(
                appBar: AppBar(
                    title: const Text(
                  'Tie?',
                  textAlign: TextAlign.center,
                )),
                body: Center(
                    child: Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: width,
                      child: CustomPaint(painter: BoardMaker(pref.secondary)),
                    ),
                    AlignPositioned(
                      alignment: Alignment.topLeft,
                      dx: width * .2,
                      dy: height * .07,
                      child: Column(children: [
                        buildRows(height * .2, width * .125, [0, 1, 2],
                            height * .1, width * .012, false),
                        SizedBox(height: height * .009, width: width * .012),
                        buildRows(height * .2, width * .125, [3, 4, 5],
                            height * .1, width * .012, false),
                        SizedBox(height: height * .03, width: width * .012),
                        buildRows(height * .2, width * .125, [6, 7, 8],
                            height * .1, width * .012, false),
                      ]),
                    )
                  ],
                )),
              ),
            ]);
          }
        }
        return const SizedBox();
      });
    });
  }
}
