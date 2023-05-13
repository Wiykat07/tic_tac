import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/gameprovider.dart';

SizedBox alertBox(bool win, bool ai) {
  return SizedBox(child: Builder(builder: ((context) {
    Future.delayed(const Duration(seconds: 5), () {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: ((BuildContext context) {
            return winOrTie(win, ai, context);
          }));
    });
    return const SizedBox();
  })));
}

AlertDialog winOrTie(bool win, bool ai, BuildContext context) {
  if (win && ai) {
    return AlertDialog(
      title: const Text('Winner!'),
      content: Text(
        '${Provider.of<GameProvider>(context, listen: false).winnerName} won!',
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Provider.of<GameProvider>(context, listen: false)
                      .resetBoard();
                  Navigator.pushNamed(context, '/single');
                },
                child: const Text('Change Difficulty')),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Quit')),
          TextButton(
              onPressed: () {
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Navigator.pop(context);
              },
              child: const Text('Play Again!'))
        ])
      ],
    );
  }
  if (win && !ai) {
    return AlertDialog(
      title: const Text('Winner!'),
      content: Text(
        '${Provider.of<GameProvider>(context, listen: false).winnerName} won!',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Provider.of<GameProvider>(context, listen: false)
                      .resetBoard();
                  Provider.of<GameProvider>(context, listen: false).swapTurns();
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
                  Provider.of<GameProvider>(context, listen: false)
                      .resetBoard();
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Quit')),
            TextButton(
                onPressed: () {
                  Provider.of<GameProvider>(context, listen: false)
                      .resetBoard();
                  Navigator.pop(context);
                },
                child: const Text('Play Again!')),
          ],
        )
      ],
    );
  }
  if (!ai) {
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
                  Provider.of<GameProvider>(context, listen: false)
                      .resetBoard();
                  Provider.of<GameProvider>(context, listen: false).swapTurns();
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
                  Provider.of<GameProvider>(context, listen: false)
                      .resetBoard();
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Quit')),
            TextButton(
                onPressed: () {
                  Provider.of<GameProvider>(context, listen: false)
                      .resetBoard();
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
                Provider.of<GameProvider>(context, listen: false).resetBoard();
                Navigator.pushNamed(context, '/single');
              },
              child: const Text('Change Difficulty')),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).resetBoard();
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Quit')),
        TextButton(
            onPressed: () {
              Provider.of<GameProvider>(context, listen: false).resetBoard();
              Navigator.pop(context);
            },
            child: const Text('Play Again!'))
      ])
    ],
  );
}
