import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/game_provider.dart';
import 'package:tic_tac/Providers/settings_provider.dart';
import 'package:tic_tac/Widgets/draw_board.dart';

Row buildRows(
  double h,
  double w,
  bool port,
  List<int> i,
  List<String> k,
  List<String> sem,
  bool inter,
) {
  if (inter) {
    if (port) {
      return Row(
        children: [
          interactiveSquare(h * .11, w * .25, i[0], sem[0], k[0]),
          SizedBox(height: h * .115, width: w * .03),
          interactiveSquare(h * .11, w * .25, i[1], sem[1], k[1]),
          SizedBox(height: h * .115, width: w * .03),
          interactiveSquare(h * .11, w * .25, i[2], sem[2], k[2]),
        ],
      );
    }
    return Row(
      children: [
        interactiveSquare(h * .2, w * .125, i[0], sem[0], k[0]),
        SizedBox(height: h * .1, width: w * .012),
        interactiveSquare(h * .2, w * .125, i[1], sem[1], k[1]),
        SizedBox(height: h * .1, width: w * .012),
        interactiveSquare(h * .2, w * .125, i[2], sem[2], k[2]),
      ],
    );
  }
  if (port) {
    return Row(
      children: [
        square(h * .11, w * .25, i[0], sem[0], k[0]),
        SizedBox(height: h * .115, width: w * .03),
        square(h * .11, w * .25, i[1], sem[1], k[1]),
        SizedBox(height: h * .115, width: w * .03),
        square(h * .11, w * .25, i[2], sem[2], k[2]),
      ],
    );
  }
  return Row(
    children: [
      square(h * .2, w * .125, i[0], sem[0], k[0]),
      SizedBox(height: h * .1, width: w * .012),
      square(h * .2, w * .125, i[1], sem[1], k[1]),
      SizedBox(height: h * .1, width: w * .012),
      square(h * .2, w * .125, i[2], sem[2], k[2]),
    ],
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

Builder interactiveSquare(double h, double w, int i, String sem, String k) {
  return Builder(
    builder: (context) {
      return Consumer<GameProvider>(
        builder: (context, game, child) {
          if (game.spaceCheck(i)) {
            if (game.pieceCheck(i)) {
              sem = '$sem O';
            } else {
              sem = '$sem X';
            }
            return Semantics(
              label: sem,
              child: piecePlaced(
                h,
                w,
                game.pieceCheck(i),
                Provider.of<Preferences>(context, listen: false).secondary,
                k,
              ),
            );
          }
          sem = '$sem Empty';
          return GestureDetector(
            onTap: () {
              game.placePieces(game.currentPlayer.piece, i);
              game.switchTurns(!game.currentPlayer.piece);
              if (game.currentPlayer.number == PlayerNumber.ai) {
                game.boardCheck(
                  !game.piece,
                ); //check winstate to make sure there wasn't a winning play
                if (game.winState == 1) {
                  final int spot = game.aiTurn(game.currentPlayer.piece);
                  game.placePieces(game.currentPlayer.piece, spot);
                  game.switchTurns(!game.currentPlayer.piece);
                }
              }
            },
            child: Semantics(
              label: sem,
              child: emptySquare(
                h,
                w,
                Provider.of<Preferences>(context, listen: false).secondary,
                k,
              ),
            ),
          );
        },
      );
    },
  );
}

SizedBox piecePlaced(double h, double w, bool p, Color c, String k) {
  return SizedBox(
    height: h,
    width: w,
    key: Key(k),
    child: CustomPaint(painter: XAndO(false, p, c)),
  );
}

Builder square(double h, double w, int i, String sem, String k) {
  return Builder(
    builder: (context) {
      if (Provider.of<GameProvider>(context, listen: false).spaceCheck(i)) {
        if (Provider.of<GameProvider>(context, listen: false).pieceCheck(i)) {
          sem = '$sem O';
        } else {
          sem = '$sem X';
        }
        return Semantics(
          label: sem,
          child: piecePlaced(
            h,
            w,
            Provider.of<GameProvider>(context, listen: false).pieceCheck(i),
            Provider.of<Preferences>(context, listen: false).secondary,
            k,
          ),
        );
      }
      sem = '$sem Empty';
      return Semantics(
        label: sem,
        child: emptySquare(
          h,
          w,
          Provider.of<Preferences>(context, listen: false).secondary,
          k,
        ),
      );
    },
  );
}
