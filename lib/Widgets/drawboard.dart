import 'package:flutter/material.dart';

class XAndO extends CustomPainter {
  bool oOrX = false;
  bool isStart = false;
  Color s = Colors.yellowAccent;

  XAndO(this.isStart, this.oOrX, this.s);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > size.height) {
      final paint = Paint()
        ..strokeWidth = 5
        ..color = s
        ..style = PaintingStyle.stroke;
      if (!isStart) {
        if (oOrX) {
          canvas.drawCircle(Offset(size.width * .5, size.height * .5),
              size.height * .35, paint,);
        }
        if (!oOrX) {
          final piece = Path();
          piece.relativeMoveTo(size.width * .1, size.height * .1);
          piece.relativeLineTo(size.width * .8, size.height * .8);
          piece.relativeMoveTo(-(size.width * .8), 0);
          piece.relativeLineTo(size.width * .8, -(size.height * .8));

          canvas.drawPath(piece, paint);
        }
      }
    }
    if (size.width <= size.height) {
      final paint = Paint()
        ..strokeWidth = 5
        ..color = s
        ..style = PaintingStyle.stroke;
      if (!isStart) {
        if (oOrX) {
          canvas.drawCircle(Offset(size.width * .2, size.height * .2),
              size.width * .2, paint,);
        }
        if (!oOrX) {
          final piece = Path();
          piece.relativeMoveTo(size.height * .1, size.height * .1);
          piece.relativeLineTo(size.width * .2, size.height * .8);
          piece.relativeMoveTo(-(size.width * .2), 0);
          piece.relativeLineTo(size.width * .2, -(size.height * .8));

          canvas.drawPath(piece, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(XAndO oldDelegate) => false;
}

class BoardMaker extends CustomPainter {
  Color s = Colors.yellowAccent;
  BoardMaker(this.s);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= size.height) {
      final paint = Paint()
        ..strokeWidth = 5
        ..color = s
        ..style = PaintingStyle.stroke;

      final board = Path();
      board.moveTo(size.width * .35, size.height * .2);
      board.relativeLineTo(0, size.height * .135);
      board.relativeLineTo(-(size.width * .25), 0);
      board.relativeLineTo(size.width * .55, 0);
      board.relativeLineTo(0, -(size.height * .135));
      board.relativeMoveTo(0, size.height * .135);
      board.relativeLineTo(size.width * .25, 0);

      board.moveTo(size.width * .35, size.height * .33);
      board.relativeLineTo(0, size.height * .135);
      board.relativeLineTo(-(size.width * .25), 0);
      board.relativeLineTo(size.width * .55, 0);
      board.relativeLineTo(0, -(size.height * .135));
      board.relativeMoveTo(0, size.height * .135);
      board.relativeLineTo(size.width * .25, 0);

      board.moveTo(size.width * .35, size.height * .465);
      board.relativeLineTo(0, size.height * .135);
      board.moveTo(size.width * .65, size.height * .465);
      board.relativeLineTo(0, size.height * .135);

      canvas.drawPath(board, paint);
    }
    if (size.width > size.height) {
      final paint = Paint()
        ..strokeWidth = 5
        ..color = s
        ..style = PaintingStyle.stroke;

      final board = Path();
      board.moveTo(size.width * .2, size.height * .35);
      board.relativeLineTo(size.width * .135, 0);
      board.relativeLineTo(0, -(size.height * .25));
      board.relativeLineTo(0, size.height * .55);
      board.relativeLineTo(-(size.width * .135), 0);
      board.relativeMoveTo(size.width * .135, 0);
      board.relativeLineTo(0, size.height * .25);

      board.moveTo(size.width * .33, size.height * .35);
      board.relativeLineTo(size.width * .135, 0);
      board.relativeLineTo(0, -(size.height * .25));
      board.relativeLineTo(0, size.height * .55);
      board.relativeLineTo(-(size.width * .135), 0);
      board.relativeMoveTo(size.width * .135, 0);
      board.relativeLineTo(0, size.height * .25);

      board.moveTo(size.width * .465, size.height * .35);
      board.relativeLineTo(size.width * .135, 0);
      board.moveTo(size.width * .465, size.height * .65);
      board.relativeLineTo(size.width * .135, 0);

      canvas.drawPath(board, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
