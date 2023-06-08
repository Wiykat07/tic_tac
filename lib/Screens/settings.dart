import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/Providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _ScreenState();
}

class _ScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

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
            child: colorContainer(c, key),
          );
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
                    Semantics(
                      label: 'Green',
                      child: primaryColor(
                          'Green', Colors.green, const Key('green')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Blue',
                      child:
                          primaryColor('Blue', Colors.blue, const Key('blue')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Red',
                      child: primaryColor('Red', Colors.red, const Key('red')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Yellow',
                      child: primaryColor(
                          'Yellow', Colors.yellow, const Key('yellow')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Purple',
                      child: primaryColor(
                          'Purple', Colors.purple, const Key('purple')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      label: 'Orange',
                      child: primaryColor(
                          'Orange', Colors.orange, const Key('orange')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Black',
                      child: primaryColor(
                          'Black', Colors.black, const Key('black')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'White',
                      child: primaryColor(
                          'White', Colors.white, const Key('white')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Indigo',
                      child: primaryColor(
                          'Indigo', Colors.indigo, const Key('indigo')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Cyan',
                      child:
                          primaryColor('Cyan', Colors.cyan, const Key('cyan')),
                    ),
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
                    Semantics(
                      label: 'Green',
                      child: secondaryColor(
                        'Green',
                        Colors.greenAccent,
                        const Key('green2'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Blue',
                      child: secondaryColor(
                        'Blue',
                        Colors.blueAccent,
                        const Key('blue2'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Red',
                      child: secondaryColor(
                        'Red',
                        Colors.redAccent,
                        const Key('red2'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Yellow',
                      child: secondaryColor(
                        'Yellow',
                        Colors.yellowAccent,
                        const Key('yellow2'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Purple',
                      child: secondaryColor(
                        'Purple',
                        Colors.purpleAccent,
                        const Key('purple2'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      label: 'Orange',
                      child: secondaryColor(
                        'Orange',
                        Colors.orangeAccent,
                        const Key('orange2'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Black',
                      child: secondaryColor(
                          'Black', Colors.black, const Key('black2')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'White',
                      child: secondaryColor(
                          'White', Colors.white, const Key('white2')),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Indigo',
                      child: secondaryColor(
                        'Indigo',
                        Colors.indigoAccent,
                        const Key('indigo2'),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 20,
                    ),
                    Semantics(
                      label: 'Cyan',
                      child: secondaryColor(
                        'Cyan',
                        Colors.cyanAccent,
                        const Key('cyan2'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container colorContainer(Color c, Key key) {
    return Container(
      key: key,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: c,
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<Preferences>(context, listen: false).initialPrefs();
  }

  @override
  void initState() {
    super.initState();
  }
}
