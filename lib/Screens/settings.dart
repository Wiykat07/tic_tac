import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends ChangeNotifier {
  int _colorScheme = 0;
  int _difficulty = 0;

  int get colorScheme {
    return _colorScheme;
  }

  int get difficulty {
    return _difficulty;
  }

  void updatePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('color', _colorScheme);
    await prefs.setInt('difficulty', _difficulty);

    notifyListeners();
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _ScreenState();
}

class _ScreenState extends State<SettingsScreen> {
  String color = 'Green/Yellow';
  String diff = 'Tic';
  List<String> displayColor = ['Green/Yellow', 'Black/White', 'Blue/Yellow'];
  List<String> difficulty = ['Tic', 'Tac', 'Toe'];

  @override
  Widget build(BuildContext context) {
    return Consumer<Preferences>(
        builder: (BuildContext context, Preferences prefs, Widget? child) {
      int colorPref(String c) {
        if (c == 'Green/Yellow') {
          return 0;
        }
        if (c == 'Black/White') {
          return 1;
        }
        if (c == 'Blue/Yellow') {
          return 2;
        }
        return -1;
      }

      int diffPref(String d) {
        if (d == 'Tic') {
          return 0;
        }
        if (d == 'Tac') {
          return 1;
        }
        if (d == 'Toe') {
          return 2;
        }
        return -1;
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Text('Color Scheme: '),
                DropdownButton(
                    value: color,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: displayColor.map((String color) {
                      return DropdownMenuItem(value: color, child: Text(color));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        color = newValue!;
                        prefs._colorScheme = colorPref(color);
                        prefs.updatePrefs();
                      });
                    }),
              ],
            ),
            Row(
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
                        prefs._difficulty = diffPref(diff);
                        prefs.updatePrefs();
                      });
                    }),
              ],
            ),
          ],
        ),
      );
    });
  }
}
