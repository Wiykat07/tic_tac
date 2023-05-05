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
