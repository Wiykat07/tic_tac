import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/game_provider.dart';

SizedBox alertBox(bool win, PlayerNumber ai, String winner) {
  return SizedBox(
    child: Builder(
      builder: (context) {
        Future.delayed(const Duration(seconds: 5), () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return winOrTie(win, ai, winner, context);
            },
          );
        });
        return const SizedBox();
      },
    ),
  );
}

AlertDialog winOrTie(
  bool win,
  PlayerNumber ai,
  String winner,
  BuildContext context,
) {
  if (win && ai == PlayerNumber.ai) {
    return AlertDialog(
      title: const Text('Winner!'),
      content: Text(
        '$winner won!',
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Navigator.pushNamed(context, '/single');
              },
              child: const Text('Change Difficulty'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).emptyBoard();
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Quit'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Navigator.pop(context);
              },
              child: const Text('Play Again!'),
            )
          ],
        )
      ],
    );
  }
  if (win && !(ai == PlayerNumber.ai)) {
    return AlertDialog(
      title: const Text('Winner!'),
      content: Text(
        '$winner won!',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Provider.of<GameProvider>(context, listen: false).swapTurns();
                Navigator.pop(context);
              },
              child: const Text('Switch Turns!'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).emptyBoard();
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Quit'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Navigator.pop(context);
              },
              child: const Text('Play Again!'),
            ),
          ],
        )
      ],
    );
  }
  if (!(ai == PlayerNumber.ai)) {
    return AlertDialog(
      title: const Text('Tie?'),
      content: const Text(
        'Nobody won!',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Provider.of<GameProvider>(context, listen: false).swapTurns();
                Navigator.pop(context);
              },
              child: const Text('Switch Turns!'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).emptyBoard();
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Quit'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Navigator.pop(context);
              },
              child: const Text('Play Again!'),
            ),
          ],
        )
      ],
    );
  }
  return AlertDialog(
    title: const Text('Tie?'),
    content: const Text(
      'Nobody won!',
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).resetBoard();
              Navigator.pushNamed(context, '/single');
            },
            child: const Text('Change Difficulty'),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).emptyBoard();
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Quit'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).resetBoard();
              Navigator.pop(context);
            },
            child: const Text('Play Again!'),
          )
        ],
      )
    ],
  );
}
