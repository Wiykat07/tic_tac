import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/provider.dart';

class Single extends StatelessWidget {
  const Single({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController player1Controller = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    List<String> names = [];

    return Scaffold(
      appBar: AppBar(title: const Text('Enter your name')),
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
            SizedBox.fromSize(
              size: Size.fromHeight(height * .05),
            ),
            OutlinedButton(
                onPressed: () {
                  names.add(player1Controller.text);
                  names.add('Computer');
                  Provider.of<GameProvider>(context, listen: false).aiOn();
                  Provider.of<GameProvider>(context, listen: false)
                      .addPlayer(true, names[1]);
                  Provider.of<GameProvider>(context, listen: false)
                      .addPlayer(false, names[0]);
                  Provider.of<GameProvider>(context, listen: false)
                      .switchTurns(false);
                  Navigator.pushNamed(context, '/board');
                },
                child: const Text('Let\'s play!'))
          ],
        ),
      ),
    );
  }
}
