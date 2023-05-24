import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/game_provider.dart';
import 'package:tic_tac/Widgets/board_squares.dart';

import '../Providers/settings_provider.dart';
import 'draw_board.dart';

class LandscapeScaffold extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final bool inter;

  const LandscapeScaffold({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.inter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Provider.of<GameProvider>(context, listen: false).emptyBoard();
            Navigator.of(context).pop();
          },
        ),
        title: Text(title),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: CustomPaint(
              painter: BoardMaker(
                Provider.of<Preferences>(context, listen: false).secondary,
              ),
            ),
          ),
          AlignPositioned(
            alignment: Alignment.topLeft,
            dx: width * .2,
            dy: height * .05,
            child: Column(
              children: [
                buildRows(
                  height,
                  width,
                  false,
                  [0, 1, 2],
                  ['zero', 'one', 'two'],
                  inter,
                ),
                SizedBox(height: height * .03, width: width * .012),
                buildRows(
                  height,
                  width,
                  false,
                  [3, 4, 5],
                  ['three', 'four', 'five'],
                  inter,
                ),
                SizedBox(height: height * .03, width: width * .012),
                buildRows(
                  height,
                  width,
                  false,
                  [6, 7, 8],
                  ['six', 'seven', 'eight'],
                  inter,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PortraitScaffold extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final bool inter;

  const PortraitScaffold({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.inter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (Provider.of<GameProvider>(context, listen: false)
                        .players[1]
                        .number ==
                    PlayerNumber.player2 ||
                Provider.of<GameProvider>(context, listen: false)
                        .players[0]
                        .number ==
                    PlayerNumber.player2) {
              Provider.of<GameProvider>(context, listen: false).emptyBoard();
              Navigator.of(context).pushNamed('/two');
            } else {
              Provider.of<GameProvider>(context, listen: false).emptyBoard();
              Navigator.of(context).pushNamed('/single');
            }
          },
        ),
        title: Text(title),
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: CustomPaint(
                painter: BoardMaker(
                  Provider.of<Preferences>(context, listen: false).secondary,
                ),
              ),
            ),
            AlignPositioned(
              alignment: Alignment.topLeft,
              dx: width * .095,
              dy: height * .18,
              child: Column(
                children: [
                  buildRows(
                    height,
                    width,
                    true,
                    [0, 1, 2],
                    ['zero', 'one', 'two'],
                    inter,
                  ),
                  SizedBox(height: height * .007, width: width * .04),
                  buildRows(
                    height,
                    width,
                    true,
                    [3, 4, 5],
                    ['three', 'four', 'five'],
                    inter,
                  ),
                  SizedBox(height: height * .007, width: width * .04),
                  buildRows(
                    height,
                    width,
                    true,
                    [6, 7, 8],
                    ['six', 'seven', 'eight'],
                    inter,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabletScaffold extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final bool inter;

  const TabletScaffold({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.inter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Provider.of<GameProvider>(context, listen: false).emptyBoard();
            if (Provider.of<GameProvider>(context, listen: false)
                        .players[1]
                        .number ==
                    PlayerNumber.player2 ||
                Provider.of<GameProvider>(context, listen: false)
                        .players[0]
                        .number ==
                    PlayerNumber.player2) {
              Navigator.of(context).pushNamed('/two');
            }
            if (Provider.of<GameProvider>(context, listen: false)
                        .players[1]
                        .number ==
                    PlayerNumber.ai ||
                Provider.of<GameProvider>(context, listen: false)
                        .players[0]
                        .number ==
                    PlayerNumber.ai) {
              Navigator.of(context).pushNamed('/single');
            }
          },
        ),
        title: Text(title),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: CustomPaint(
              painter: BoardMaker(
                Provider.of<Preferences>(context, listen: false).secondary,
              ),
            ),
          ),
          AlignPositioned(
            alignment: Alignment.topLeft,
            dx: width * .2,
            dy: height * .1,
            child: Column(
              children: [
                buildRows(
                  height,
                  width,
                  false,
                  [0, 1, 2],
                  ['zero', 'one', 'two'],
                  inter,
                ),
                SizedBox(height: height * .045, width: width * .012),
                buildRows(
                  height + 50,
                  width,
                  false,
                  [3, 4, 5],
                  ['three', 'four', 'five'],
                  inter,
                ),
                SizedBox(height: height * .03, width: width * .012),
                buildRows(
                  height,
                  width,
                  false,
                  [6, 7, 8],
                  ['six', 'seven', 'eight'],
                  inter,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
