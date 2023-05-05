import 'package:flutter/material.dart';
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
                prefs.primary = c;
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
              prefs.secondary = c;
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
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  primaryColor('Orange', Colors.orange),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Black', Colors.black),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('White', Colors.white),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Indigo', Colors.indigo),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  primaryColor('Cyan', Colors.cyan),
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
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  secondaryColor('Orange', Colors.orangeAccent),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('Black', Colors.black),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('White', Colors.white),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('Indigo', Colors.indigoAccent),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  secondaryColor('Cyan', Colors.cyanAccent),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
