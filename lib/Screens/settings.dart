import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends ChangeNotifier {
  int _primary = 0;
  int _secondary = 0;

  int get primary {
    return _primary;
  }

  int get secondary {
    return _secondary;
  }

  void updatePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('color', _primary);
    await prefs.setInt('second color', _secondary);

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
  String color = 'Green';
  String secondColor = 'Yellow';

  Container colorContainer(Color c) {
    return Container(
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

    return Consumer<Preferences>(
        builder: (BuildContext context, Preferences prefs, Widget? child) {
      int colorPref(String c) {
        if (c == 'Green') {
          return 0;
        }
        if (c == 'Blue') {
          return 1;
        }
        if (c == 'Red') {
          return 2;
        }
        if (c == 'Yellow') {
          return 3;
        }
        if (c == 'Purple') {
          return 4;
        }
        return -1;
      }

      GestureDetector primaryColor(String col, Color c) {
        return GestureDetector(
            onTap: () {
              setState(() {
                color = col;
                prefs._primary = colorPref(col);
                prefs.updatePrefs();
              });
            },
            child: colorContainer(c));
      }

      GestureDetector secondaryColor(String col, Color c) {
        return GestureDetector(
          onTap: () {
            setState(() {
              secondColor = col;
              prefs._secondary = colorPref(col);
              prefs.updatePrefs();
            });
          },
          child: colorContainer(c),
        );
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Settings'),
        ),
        body: Column(
          children: [
            SizedBox.fromSize(
              size: Size.fromHeight(height * .05),
            ),
            const Text(
              'Board Color: ',
              style: TextStyle(fontSize: 28),
            ),
            Text(
              color,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                primaryColor('Green', Colors.green),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                primaryColor('Blue', Colors.blue),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                primaryColor('Red', Colors.red),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                primaryColor('Yellow', Colors.yellow),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                primaryColor('Purple', Colors.purple),
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
              secondColor,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                secondaryColor('Green', Colors.greenAccent),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                secondaryColor('Blue', Colors.blueAccent),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                secondaryColor('Red', Colors.redAccent),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                secondaryColor('Yellow', Colors.yellowAccent),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                secondaryColor('Purple', Colors.purpleAccent),
              ],
            )
          ],
        ),
      );
    });
  }
}
