import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tic_tac/Providers/settingsprovider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _ScreenState();
}

class _ScreenState extends State<SettingsScreen> {
  Container colorContainer(Color c, Key key) {
    return Container(
        key: key,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: c,
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8))));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final colorBox = Hive.box('Colors');

    return Consumer<Preferences>(
        builder: (BuildContext context, Preferences prefs, Widget? child) {
      GestureDetector primaryColor(String col, Color c, Key key) {
        return GestureDetector(
            onTap: () {
              setState(() {
                prefs.db.updatePrimary(c, col);
                prefs.updatePrefs();
              });
            },
            child: colorContainer(c, key));
      }

      GestureDetector secondaryColor(String col, Color c, Key key) {
        return GestureDetector(
          onTap: () {
            setState(() {
              prefs.db.updateSecondary(c, col);
              prefs.updatePrefs();
            });
          },
          child: colorContainer(c, key),
        );
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox.fromSize(
                size: Size.fromHeight(height * .05),
              ),
              const Text(
                'Board Color: ',
                style: TextStyle(fontSize: 28),
              ),
              Text(
                prefs.color,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryColor('Green', Colors.green, const Key('green')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Blue', Colors.blue, const Key('blue')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Red', Colors.red, const Key('red')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Yellow', Colors.yellow, const Key('yellow')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Purple', Colors.purple, const Key('purple')),
                ],
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryColor('Orange', Colors.orange, const Key('orange')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Black', Colors.black, const Key('black')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('White', Colors.white, const Key('white')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Indigo', Colors.indigo, const Key('indigo')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Cyan', Colors.cyan, const Key('cyan')),
                ],
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(height * .05),
              ),
              const Text(
                'Piece Color: ',
                style: TextStyle(fontSize: 28),
              ),
              Text(
                prefs.secondColor,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  secondaryColor(
                      'Green', Colors.greenAccent, const Key('green2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('Blue', Colors.blueAccent, const Key('blue2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('Red', Colors.redAccent, const Key('red2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor(
                      'Yellow', Colors.yellowAccent, const Key('yellow2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor(
                      'Purple', Colors.purpleAccent, const Key('purple2')),
                ],
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  secondaryColor(
                      'Orange', Colors.orangeAccent, const Key('orange2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('Black', Colors.black, const Key('black2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('White', Colors.white, const Key('white2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor(
                      'Indigo', Colors.indigoAccent, const Key('indigo2')),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('Cyan', Colors.cyanAccent, const Key('cyan2')),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
