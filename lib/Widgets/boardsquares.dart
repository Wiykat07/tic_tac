import 'package:flutter/material.dart';
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

Builder square(
    double h, double w, int i, GameProvider game, Preferences preferences) {
  return Builder(builder: ((context) {
    if (game.spaceCheck(i)) {
      return piecePlaced(h, w, game.pieceCheck(i), preferences.secondary);
    }
    return emptySquare(h, w, preferences.secondary);
  }));
}

Builder interactiveSquare(double h, double w, int i, GameProvider game,
    Preferences preferences, int args) {
  return Builder(builder: ((context) {
    if (game.spaceCheck(i)) {
      return piecePlaced(h, w, game.pieceCheck(i), preferences.secondary);
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
              int spot = game.aiTurn(game.isPlayer1, args);
              game.placePieces(game.isPlayer1, spot);
              game.switchTurns(!game.isPlayer1);
            }
          }
        },
        child: emptySquare(h, w, preferences.secondary));
  }));
}

Row buildRows(double h, double w, List<int> i, double sh, double sw, bool inter,
    GameProvider game, Preferences preferences, int args) {
  if (inter) {
    return Row(
      children: [
        interactiveSquare(h, w, i[0], game, preferences, args),
        SizedBox(height: sh, width: sw),
        interactiveSquare(h, w, i[1], game, preferences, args),
        SizedBox(height: sh, width: sw),
        interactiveSquare(h, w, i[2], game, preferences, args),
      ],
    );
  }
  return Row(
    children: [
      square(h, w, i[0], game, preferences),
      SizedBox(height: sh, width: sw),
      square(h, w, i[1], game, preferences),
      SizedBox(height: sh, width: sw),
      square(h, w, i[2], game, preferences),
    ],
  );
}
