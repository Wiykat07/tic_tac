import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/gameprovider.dart';

class Single extends StatefulWidget {
  const Single({super.key});

  @override
  State<Single> createState() => _SingleState();
}

class _SingleState extends State<Single> {
  String diff = 'Tic';
  List<String> difficulty = ['Tic', 'Tac', 'Toe'];
  int ai = -1;
  TextEditingController player1Controller = TextEditingController();
  List<String> names = [];
  String description = 'The best AI you will ever face.';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    int difficult(String c) {
      if (c == 'Tic') {
        description = 'The best AI you will ever face.';
        return 0;
      }
      if (c == 'Tac') {
        description = 'It kind of knows how the game is played.';
        return 1;
      }
      if (c == 'Toe') {
        description = 'About as dumb as a toe. Does what it wants.';
        return 2;
      }
      return -1;
    }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Difficulty: '),
                DropdownButton(
                    value: diff,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: difficulty.map((String diff) {
                      return DropdownMenuItem(value: diff, child: Text(diff));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        diff = newValue!;
                        ai = difficult(diff);
                      });
                    }),
              ],
            ),
            Text(description),
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
                  Navigator.pushNamed(context, '/board', arguments: ai);
                },
                child: const Text('Let\'s play!'))
          ],
        ),
      ),
    );
  }
}
