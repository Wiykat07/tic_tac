import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/provider.dart';

class Two extends StatelessWidget {
  const Two({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController player1Controller = TextEditingController();
    TextEditingController player2Controller = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    List<String> names = [];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('What are your names?'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                decoration:
                    const InputDecoration(labelText: 'Player One\'s name:'),
                keyboardType: TextInputType.name,
                controller: player1Controller,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z]')),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                decoration:
                    const InputDecoration(labelText: 'Player Two\'s name:'),
                keyboardType: TextInputType.name,
                controller: player2Controller,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z]')),
                ],
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(height * .05),
            ),
            OutlinedButton(
                onPressed: () {
                  names.add(player1Controller.text);
                  names.add(player2Controller.text);
                  Navigator.pushNamed(context, '/roll', arguments: names);
                },
                child: const Text('Who goes first?'))
          ],
        ),
      ),
    );
  }
}

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
      Random random = Random();
      chance = random.nextInt(2) + 1;
      if (chance == 1) {
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(true, names[0]);
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(false, names[1]);
        Provider.of<GameProvider>(context, listen: false).switchTurns(false);
      }
      if (chance == 2) {
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(true, names[1]);
        Provider.of<GameProvider>(context, listen: false)
            .addPlayer(false, names[0]);
        Provider.of<GameProvider>(context, listen: false).switchTurns(false);
      }
    }

    Future<void> rollsResults() async {
      diceRoll();
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Who Goes First?'),
              content: Center(
                  child: Text(
                      '${Provider.of<GameProvider>(context).name} goes first.')),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/board');
                    },
                    child: const Text('Let\'s Play!'))
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Who gets to go first?')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Flipping a coin...'),
          ElevatedButton(
              onPressed: () {
                rollsResults();
              },
              child: const Text('Press to flip')),
        ],
      )),
    );
  }
}
