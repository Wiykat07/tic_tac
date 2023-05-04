import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends ChangeNotifier {
  int _colorScheme = 0;

  int get colorScheme {
    return _colorScheme;
  }

  void updatePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('color', _colorScheme);

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
  List<String> displayColor = ['Green/Yellow', 'Black/White', 'Blue/Yellow'];

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
          ],
        ),
      );
    });
  }
}
