import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';
import 'package:tic_tac/Widgets/confetti.dart';
import 'package:tic_tac/Widgets/scaffolds.dart';

import '../Widgets/winortie.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<StatefulWidget> createState() => _Board();
}

class _Board extends State<Board> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<GameProvider>(builder: (context, game, child) {
      game.difficultySet(args);
      game.boardCheck(!game.piece);

      if (game.winState == 1) {
        if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return PortraitScaffold(
              title: '${game.name}\'s turn',
              height: height,
              width: width,
              inter: true,);
        } else {
          return LandscapeScaffold(
              title: '${game.name}\'s turn',
              height: height,
              width: width,
              inter: true,);
        }
      }
      if (game.winState == 2) {
        if (game.winnerName == 'Computer') {
          if (!game.here) {
            game.here = true;
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              return Stack(children: [
                alertBox(true, game.currentPlayer.number, game.winnerName),
                PortraitScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
              ],);
            } else {
              return Stack(children: [
                alertBox(true, game.currentPlayer.number, game.winnerName),
                LandscapeScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
              ],);
            }
          } else {
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              return Stack(children: [
                PortraitScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
              ],);
            } else {
              return Stack(children: [
                LandscapeScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
              ],);
            }
          }
        }
        if (game.winnerName != 'Computer') {
          if (!game.here) {
            game.here = true;
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              return Stack(children: [
                alertBox(true, game.currentPlayer.number, game.winnerName),
                PortraitScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
                const ConfettiWidgets(
                    child: Center(child: SizedBox(height: 50, width: 50)),),
              ],);
            } else {
              return Stack(children: [
                alertBox(true, game.currentPlayer.number, game.winnerName),
                LandscapeScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
                const ConfettiWidgets(
                    child: Center(child: SizedBox(height: 50, width: 50)),),
              ],);
            }
          } else {
            if (MediaQuery.of(context).orientation == Orientation.portrait) {
              return Stack(children: [
                PortraitScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
                const ConfettiWidgets(
                    child: Center(child: SizedBox(height: 50, width: 50)),),
              ],);
            } else {
              return Stack(children: [
                LandscapeScaffold(
                    title: 'Winner!',
                    height: height,
                    width: width,
                    inter: false,),
                const ConfettiWidgets(
                    child: Center(child: SizedBox(height: 50, width: 50)),),
              ],);
            }
          }
        }
      }

      if (game.winState == 3) {
        if (!game.here) {
          game.here = true;
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            return Stack(
              children: [
                alertBox(false, game.currentPlayer.number, game.winnerName),
                PortraitScaffold(
                    title: 'Tie?', height: height, width: width, inter: false,)
              ],
            );
          } else {
            return Stack(children: [
              alertBox(false, game.currentPlayer.number, game.winnerName),
              LandscapeScaffold(
                  title: 'Tie?', height: height, width: width, inter: false,)
            ],);
          }
        } else {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            return Stack(
              children: [
                PortraitScaffold(
                    title: 'Tie?', height: height, width: width, inter: false,)
              ],
            );
          } else {
            return Stack(children: [
              LandscapeScaffold(
                  title: 'Tie?', height: height, width: width, inter: false,)
            ],);
          }
        }
      }
      return const SizedBox();
    },);
  }
}
