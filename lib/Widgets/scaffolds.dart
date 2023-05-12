import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Widgets/boardsquares.dart';

import '../Providers/settingsprovider.dart';
import 'drawboard.dart';

class LandscapeScaffold extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final bool inter;

  const LandscapeScaffold(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.inter});

  @override
  State<LandscapeScaffold> createState() => _LandscapeScaffoldState();
}

class _LandscapeScaffoldState extends State<LandscapeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
      return Scaffold(
          appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  game.emptyBoard();
                  Navigator.of(context).pop();
                },
              ),
              title: Text(widget.title)),
          body: Stack(children: [
            SizedBox(
              height: widget.height,
              width: widget.width,
              child: CustomPaint(
                  painter: BoardMaker(
                      Provider.of<Preferences>(context, listen: false)
                          .secondary)),
            ),
            AlignPositioned(
                alignment: Alignment.topLeft,
                dx: widget.width * .2,
                dy: widget.height * .07,
                child: Column(children: [
                  buildRows(widget.height, widget.width, false, [0, 1, 2],
                      widget.inter, game),
                  SizedBox(
                      height: widget.height * .009, width: widget.width * .012),
                  buildRows(widget.height, widget.width, false, [3, 4, 5],
                      widget.inter, game),
                  SizedBox(
                      height: widget.height * .03, width: widget.width * .012),
                  buildRows(widget.height, widget.width, false, [6, 7, 8],
                      widget.inter, game),
                ]))
          ]));
    });
  }
}

class PortraitScaffold extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final bool inter;

  const PortraitScaffold(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.inter});

  @override
  State<PortraitScaffold> createState() => _PortraitScaffoldState();
}

class _PortraitScaffoldState extends State<PortraitScaffold> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(builder: (context, game, child) {
      return Scaffold(
        appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                game.emptyBoard();
                Navigator.of(context).pop();
              },
            ),
            title: Text(widget.title)),
        body: Center(
            child: Stack(
          children: [
            SizedBox(
              height: widget.height,
              width: widget.width,
              child: CustomPaint(
                  painter: BoardMaker(
                      Provider.of<Preferences>(context, listen: false)
                          .secondary)),
            ),
            AlignPositioned(
              alignment: Alignment.topLeft,
              dx: widget.width * .095,
              dy: widget.height * .18,
              child: Column(children: [
                buildRows(widget.height, widget.width, true, [0, 1, 2],
                    widget.inter, game),
                SizedBox(
                    height: widget.height * .007, width: widget.width * .04),
                buildRows(widget.height, widget.width, true, [3, 4, 5],
                    widget.inter, game),
                SizedBox(
                    height: widget.height * .007, width: widget.width * .04),
                buildRows(widget.height, widget.width, true, [6, 7, 8],
                    widget.inter, game),
              ]),
            )
          ],
        )),
      );
    });
  }
}
