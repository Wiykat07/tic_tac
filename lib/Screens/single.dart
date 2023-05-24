import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/game_provider.dart';

class Single extends StatefulWidget {
  const Single({super.key});

  @override
  State<Single> createState() => SingleState();
}

@visibleForTesting
class SingleState extends State<Single> {
  String diff = 'Tic';
  List<String> difficulty = ['Tic', 'Tac', 'Toe'];
  int ai = 0;
  TextEditingController player1Controller = TextEditingController();
  List<String> names = [];
  String description = 'The best AI you will ever face.';
  final _player1Key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
        ),
        title: const Text('Enter your name'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _player1Key,
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please put in a name.';
                      } else {
                        return null;
                      }
                    },
                    decoration:
                        const InputDecoration(labelText: 'Player One\'s name:'),
                    keyboardType: TextInputType.name,
                    controller: player1Controller,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z]')),
                    ],
                  ),
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
                    },
                  ),
                ],
              ),
              Text(description),
              SizedBox.fromSize(
                size: Size.fromHeight(height * .05),
              ),
              OutlinedButton(
                onPressed: () {
                  if (!_player1Key.currentState!.validate()) {
                    return;
                  }
                  names.add(player1Controller.text);
                  names.add('Computer');
                  Provider.of<GameProvider>(context, listen: false)
                      .addPlayer(true, names[1], PlayerNumber.ai);
                  Provider.of<GameProvider>(context, listen: false)
                      .addPlayer(false, names[0], PlayerNumber.player1);
                  Provider.of<GameProvider>(context, listen: false)
                      .switchTurns(false);
                  Provider.of<GameProvider>(context, listen: false)
                      .difficultySet(ai);
                  Navigator.pushNamed(context, '/board');
                },
                child: const Text('Let\'s play!'),
              )
            ],
          ),
        ),
      ),
    );
  }

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
}
