import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/game_provider.dart';

class Roll extends StatefulWidget {
  const Roll({super.key});

  @override
  State<StatefulWidget> createState() => _Roll();
}

class _Roll extends State<Roll> {
  @override
  Widget build(BuildContext context) {
    final names = ModalRoute.of(context)!.settings.arguments as List<String>;

    void diceRoll() {
      int chance = 0;
      final Random random = Random();
      chance = random.nextInt(2) + 1;
      if (chance == 1) {
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(false, names[0], PlayerNumber.player1);
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(true, names[1], PlayerNumber.player2);
        Provider.of<GameProvider>(context, listen: false).switchTurns(false);
      }
      if (chance == 2) {
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(false, names[1], PlayerNumber.player1);
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(true, names[0], PlayerNumber.player2);
        Provider.of<GameProvider>(context, listen: false).switchTurns(false);
      }
    }

    Future<void> rollsResults() async {
      diceRoll();
      return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Who Goes First?'),
            content: Text(
              '${Provider.of<GameProvider>(context).name} goes first.',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/board');
                },
                child: const Text('Let\'s Play!'),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Who gets to go first?')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Flipping a coin...'),
            OutlinedButton(
              onPressed: () {
                rollsResults();
              },
              child: const Text('Press to flip'),
            ),
          ],
        ),
      ),
    );
  }
}
