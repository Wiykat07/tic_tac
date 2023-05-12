import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:tic_tac/Widgets/drawboard.dart';
import 'package:tic_tac/Providers/gameprovider.dart';

SizedBox piecePlaced(double h, double w, bool p, Color c) {
  return SizedBox(
    height: h,
    width: w,
    child: CustomPaint(painter: XAndO(false, p, c)),
  );
}

SizedBox emptySquare(double h, double w, Color c) {
  return SizedBox(
    height: h,
    width: w,
    child: CustomPaint(painter: XAndO(true, false, c)),
  );
}

Builder square(double h, double w, int i) {
  return Builder(builder: ((context) {
    if (Provider.of<GameProvider>(context, listen: false).spaceCheck(i)) {
      return piecePlaced(
          h,
          w,
          Provider.of<GameProvider>(context, listen: false).pieceCheck(i),
          Provider.of<Preferences>(context, listen: false).secondary);
    }
    return emptySquare(
        h, w, Provider.of<Preferences>(context, listen: false).secondary);
  }));
}

Builder interactiveSquare(double h, double w, int i) {
  return Builder(builder: ((context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
      if (game.spaceCheck(i)) {
        return piecePlaced(h, w, game.pieceCheck(i),
            Provider.of<Preferences>(context, listen: false).secondary);
      }
      return GestureDetector(
          onTap: () {
            game.placePieces(game.isPlayer1, i);
            game.switchTurns(!game.isPlayer1);
            if (game.ai == true && game.turn == true) {
              game.boardCheck(game
                  .isPlayer1); //check winstate to make sure there wasn't a winning play
              if (game.winState == 1) {
                game.isPlayer1 = game.piece;
                int spot = game.aiTurn(game.isPlayer1);
                game.placePieces(game.isPlayer1, spot);
                game.switchTurns(!game.isPlayer1);
              }
            }
          },
          child: emptySquare(h, w,
              Provider.of<Preferences>(context, listen: false).secondary));
    });
  }));
}

Row buildRows(double h, double w, bool port, List<int> i, bool inter) {
  if (inter) {
    if (port) {
      return Row(
        children: [
          interactiveSquare(h * .115, w * .25, i[0]),
          SizedBox(height: h * .1, width: w * .02),
          interactiveSquare(h * .115, w * .25, i[1]),
          SizedBox(height: h * .1, width: w * .02),
          interactiveSquare(h * .115, w * .25, i[2]),
        ],
      );
    }
    return Row(
      children: [
        interactiveSquare(h * .2, w * .125, i[0]),
        SizedBox(height: h * .1, width: w * .012),
        interactiveSquare(h * .2, w * .125, i[1]),
        SizedBox(height: h * .1, width: w * .012),
        interactiveSquare(h * .2, w * .125, i[2]),
      ],
    );
  }
  if (port) {
    return Row(
      children: [
        square(h * .115, w * .25, i[0]),
        SizedBox(height: h * .1, width: w * .02),
        square(h * .115, w * .25, i[1]),
        SizedBox(height: h * .1, width: w * .02),
        square(h * .115, w * .25, i[2]),
      ],
    );
  }
  return Row(
    children: [
      square(h * .2, w * .125, i[0]),
      SizedBox(height: h * .1, width: w * .012),
      square(h * .2, w * .125, i[1]),
      SizedBox(height: h * .1, width: w * .012),
      square(h * .2, w * .125, i[2]),
    ],
  );
}
