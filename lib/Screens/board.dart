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
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<Preferences>(builder: (context, pref, child) {
      return Consumer<GameProvider>(builder: (context, game, child) {
        game.boardCheck(game.isPlayer1);
        if (game.winState == 2) {
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
                            height * .1, width * .02, false, game, pref, args),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [3, 4, 5],
                            height * .1, width * .02, false, game, pref, args),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [6, 7, 8],
                            height * .1, width * .02, false, game, pref, args),
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
                            height * .1, width * .012, false, game, pref, args),
                        SizedBox(height: height * .009, width: width * .012),
                        buildRows(height * .2, width * .125, [3, 4, 5],
                            height * .1, width * .012, false, game, pref, args),
                        SizedBox(height: height * .03, width: width * .012),
                        buildRows(height * .2, width * .125, [6, 7, 8],
                            height * .1, width * .012, false, game, pref, args),
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
        if (game.winState == 1) {
          game.isPlayer1 = game.piece;
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
                            height * .1, width * .02, true, game, pref, args),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [3, 4, 5],
                            height * .1, width * .02, true, game, pref, args),
                        SizedBox(height: height * .007, width: width * .04),
                        buildRows(height * .115, width * .25, [6, 7, 8],
                            height * .1, width * .02, true, game, pref, args),
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
                            height * .1, width * .012, true, game, pref, args),
                        SizedBox(height: height * .009, width: width * .012),
                        buildRows(height * .2, width * .125, [3, 4, 5],
                            height * .1, width * .012, true, game, pref, args),
                        SizedBox(height: height * .03, width: width * .012),
                        buildRows(height * .2, width * .125, [6, 7, 8],
                            height * .1, width * .012, true, game, pref, args),
                      ]))
                ]));
          }
        }

        if (game.winState == 3) {
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
                          buildRows(
                              height * .115,
                              width * .25,
                              [0, 1, 2],
                              height * .1,
                              width * .02,
                              false,
                              game,
                              pref,
                              args),
                          SizedBox(height: height * .007, width: width * .04),
                          buildRows(
                              height * .115,
                              width * .25,
                              [3, 4, 5],
                              height * .1,
                              width * .02,
                              false,
                              game,
                              pref,
                              args),
                          SizedBox(height: height * .007, width: width * .04),
                          buildRows(
                              height * .115,
                              width * .25,
                              [6, 7, 8],
                              height * .1,
                              width * .02,
                              false,
                              game,
                              pref,
                              args),
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
                            height * .1, width * .012, false, game, pref, args),
                        SizedBox(height: height * .009, width: width * .012),
                        buildRows(height * .2, width * .125, [3, 4, 5],
                            height * .1, width * .012, false, game, pref, args),
                        SizedBox(height: height * .03, width: width * .012),
                        buildRows(height * .2, width * .125, [6, 7, 8],
                            height * .1, width * .012, false, game, pref, args),
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
