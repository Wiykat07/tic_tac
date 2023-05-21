import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Widgets/boardsquares.dart';

import '../Providers/settingsprovider.dart';
import 'drawboard.dart';

class LandscapeScaffold extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final bool inter;

  const LandscapeScaffold(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.inter,});

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
            title: Text(title),),
        body: Stack(children: [
          SizedBox(
            height: height,
            width: width,
            child: CustomPaint(
                painter: BoardMaker(
                    Provider.of<Preferences>(context, listen: false)
                        .secondary,),),
          ),
          AlignPositioned(
              alignment: Alignment.topLeft,
              dx: width * .2,
              dy: height * .07,
              child: Column(children: [
                buildRows(height, width, false, [0, 1, 2],
                    ['zero', 'one', 'two'], inter,),
                SizedBox(height: height * .009, width: width * .012),
                buildRows(height, width, false, [3, 4, 5],
                    ['three', 'four', 'five'], inter,),
                SizedBox(height: height * .03, width: width * .012),
                buildRows(height, width, false, [6, 7, 8],
                    ['six', 'seven', 'eight'], inter,),
              ],),)
        ],),);
  }
}

class PortraitScaffold extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final bool inter;

  const PortraitScaffold(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.inter,});

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
          title: Text(title),),
      body: Center(
          child: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: CustomPaint(
                painter: BoardMaker(
                    Provider.of<Preferences>(context, listen: false)
                        .secondary,),),
          ),
          AlignPositioned(
            alignment: Alignment.topLeft,
            dx: width * .095,
            dy: height * .18,
            child: Column(children: [
              buildRows(height, width, true, [0, 1, 2], ['zero', 'one', 'two'],
                  inter,),
              SizedBox(height: height * .007, width: width * .04),
              buildRows(height, width, true, [3, 4, 5],
                  ['three', 'four', 'five'], inter,),
              SizedBox(height: height * .007, width: width * .04),
              buildRows(height, width, true, [6, 7, 8],
                  ['six', 'seven', 'eight'], inter,),
            ],),
          )
        ],
      ),),
    );
  }
}
