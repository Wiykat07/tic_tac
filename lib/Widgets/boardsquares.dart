import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:tic_tac/Widgets/drawboard.dart';
import 'package:tic_tac/Providers/gameprovider.dart';

SizedBox piecePlaced(double h, double w, bool p, Color c, String k) {
  return SizedBox(
    height: h,
    width: w,
    key: Key(k),
    child: CustomPaint(painter: XAndO(false, p, c)),
  );
}

SizedBox emptySquare(double h, double w, Color c, String k) {
  return SizedBox(
    height: h,
    width: w,
    key: Key(k),
    child: CustomPaint(painter: XAndO(true, false, c)),
  );
}

Builder square(double h, double w, int i, String k) {
  return Builder(builder: ((context) {
    if (Provider.of<GameProvider>(context, listen: false).spaceCheck(i)) {
      return piecePlaced(
          h,
          w,
          Provider.of<GameProvider>(context, listen: false).pieceCheck(i),
          Provider.of<Preferences>(context, listen: false).secondary,
          k);
    }
    return emptySquare(
        h, w, Provider.of<Preferences>(context, listen: false).secondary, k);
  }));
}

Builder interactiveSquare(double h, double w, int i, String k) {
  return Builder(builder: ((context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
      if (game.spaceCheck(i)) {
        return piecePlaced(h, w, game.pieceCheck(i),
            Provider.of<Preferences>(context, listen: false).secondary, k);
      }
      return GestureDetector(
          onTap: () {
            game.placePieces(game.currentPlayer.piece, i);
            game.switchTurns(!game.currentPlayer.piece);
            if (game.currentPlayer.number == PlayerNumber.ai) {
              game.boardCheck(!game
                  .piece); //check winstate to make sure there wasn't a winning play
              if (game.winState == 1) {
                int spot = game.aiTurn(game.currentPlayer.piece);
                game.placePieces(game.currentPlayer.piece, spot);
                game.switchTurns(!game.currentPlayer.piece);
              }
            }
          },
          child: emptySquare(h, w,
              Provider.of<Preferences>(context, listen: false).secondary, k));
    });
  }));
}

Row buildRows(
    double h, double w, bool port, List<int> i, List<String> k, bool inter) {
  if (inter) {
    if (port) {
      return Row(
        children: [
          interactiveSquare(h * .115, w * .25, i[0], k[0]),
          SizedBox(height: h * .1, width: w * .02),
          interactiveSquare(h * .115, w * .25, i[1], k[1]),
          SizedBox(height: h * .1, width: w * .02),
          interactiveSquare(h * .115, w * .25, i[2], k[2]),
        ],
      );
    }
    return Row(
      children: [
        interactiveSquare(h * .2, w * .125, i[0], k[0]),
        SizedBox(height: h * .1, width: w * .012),
        interactiveSquare(h * .2, w * .125, i[1], k[1]),
        SizedBox(height: h * .1, width: w * .012),
        interactiveSquare(h * .2, w * .125, i[2], k[2]),
      ],
    );
  }
  if (port) {
    return Row(
      children: [
        square(h * .115, w * .25, i[0], k[0]),
        SizedBox(height: h * .1, width: w * .02),
        square(h * .115, w * .25, i[1], k[1]),
        SizedBox(height: h * .1, width: w * .02),
        square(h * .115, w * .25, i[2], k[2]),
      ],
    );
  }
  return Row(
    children: [
      square(h * .2, w * .125, i[0], k[0]),
      SizedBox(height: h * .1, width: w * .012),
      square(h * .2, w * .125, i[1], k[1]),
      SizedBox(height: h * .1, width: w * .012),
      square(h * .2, w * .125, i[2], k[2]),
    ],
  );
}
