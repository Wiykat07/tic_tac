import 'package:flutter/material.dart';

import '../Providers/gameprovider.dart';

SizedBox alertBox(bool win, GameProvider game) {
  return SizedBox(child: Builder(builder: ((context) {
    Future.delayed(const Duration(seconds: 5), () {
      showDialog(
          context: context,
          builder: ((BuildContext context) {
            return winOrTie(true, game, context);
          }));
    });
    return const SizedBox();
  })));
}

AlertDialog winOrTie(bool win, GameProvider game, BuildContext context) {
  if (win && game.ai) {
    return AlertDialog(
      title: const Text('Winner!'),
      content: Text(
        '${game.winnerName} won!',
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  game.resetBoard();
                  Navigator.pushNamed(context, '/single');
                },
                child: const Text('Change Difficulty')),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
              onPressed: () {
                game.resetBoard();
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Quit')),
          TextButton(
              onPressed: () {
                game.resetBoard();
                Navigator.pop(context);
              },
              child: const Text('Play Again!'))
        ])
      ],
    );
  }
  if (win && !game.ai) {
    return AlertDialog(
      title: const Text('Winner!'),
      content: Text(
        '${game.winnerName} won!',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  game.resetBoard();
                  game.swapTurns();
                  Navigator.pop(context);
                },
                child: const Text('Switch Turns!')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  game.resetBoard();
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Quit')),
            TextButton(
                onPressed: () {
                  game.resetBoard();
                  Navigator.pop(context);
                },
                child: const Text('Play Again!')),
          ],
        )
      ],
    );
  }
  if (!game.ai) {
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
                  game.resetBoard();
                  game.swapTurns();
                  Navigator.pop(context);
                },
                child: const Text('Switch Turns!')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  game.resetBoard();
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Quit')),
            TextButton(
                onPressed: () {
                  game.resetBoard();
                  Navigator.pop(context);
                },
                child: const Text('Play Again!')),
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
                game.resetBoard();
                Navigator.pushNamed(context, '/single');
              },
              child: const Text('Change Difficulty')),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () {
              game.resetBoard();
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Quit')),
        TextButton(
            onPressed: () {
              game.resetBoard();
              Navigator.pop(context);
            },
            child: const Text('Play Again!'))
      ])
    ],
  );
}
