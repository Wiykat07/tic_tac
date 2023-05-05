import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Two extends StatefulWidget {
  const Two({super.key});

  @override
  State<Two> createState() => _TwoState();
}

class _TwoState extends State<Two> {
  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
