import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/settings_provider.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/single');
              },
              child: const Text('One Player'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/two');
              },
              child: const Text('Two Player'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Settings'),
            )
          ],
        ),
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
