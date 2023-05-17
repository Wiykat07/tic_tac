import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Two extends StatefulWidget {
  const Two({super.key});

  @override
  State<Two> createState() => TwoState();
}

@visibleForTesting
class TwoState extends State<Two> {
  TextEditingController player1Controller = TextEditingController();
  TextEditingController player2Controller = TextEditingController();
  final _player2Key = GlobalKey<FormState>();
  List<String> names = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('What are your names?'),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _player2Key,
          child: Column(
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please put in a name.';
                    } else {
                      return null;
                    }
                  },
                  key: const Key('First Player'),
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please put in a name.';
                    } else {
                      return null;
                    }
                  },
                  key: const Key('Second Player'),
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
                    if (!_player2Key.currentState!.validate()) {
                      return;
                    }
                    names.add(player1Controller.text);
                    names.add(player2Controller.text);
                    Navigator.pushNamed(context, '/roll', arguments: names);
                  },
                  child: const Text('Who goes first?'))
            ],
          ),
        ),
      ),
    );
  }
}
