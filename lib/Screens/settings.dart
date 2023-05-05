import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Preferences extends ChangeNotifier {
  Color _primary = Colors.green;
  Color _secondary = Colors.yellowAccent;
  String colors = 'Green';
  String secondColors = 'Yellow';

  Box colorBox = Hive.box('Colors');

  Color get primary {
    return _primary;
  }

  Color get secondary {
    return _secondary;
  }

  String get color {
    return colors;
  }

  String get secondColor {
    return secondColors;
  }

  void updatePrefs() async {
    await Hive.openBox('Colors');
    colorBox.put(1, _primary);
    colorBox.put(2, _secondary);
    colorBox.put(3, colors);
    colorBox.put(4, secondColors);

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
      GestureDetector primaryColor(String col, Color c) {
        return GestureDetector(
            onTap: () {
              setState(() {
                prefs.colors = col;
                prefs._primary = c;
                prefs.updatePrefs();
              });
            },
            child: colorContainer(c));
      }

      GestureDetector secondaryColor(String col, Color c) {
        return GestureDetector(
          onTap: () {
            setState(() {
              prefs.secondColors = col;
              prefs._secondary = c;
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
