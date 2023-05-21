import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiWidgets extends StatefulWidget {
  final Widget child;

  const ConfettiWidgets({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _ConfettiWidgetsState();
}

class _ConfettiWidgetsState extends State<ConfettiWidgets> {
  late ConfettiController confettiX;

  @override
  void initState() {
    super.initState();
    confettiX = ConfettiController(duration: const Duration(seconds: 20));
    confettiX.play();
  }

  @override
  void dispose() {
    confettiX.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: confettiX,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 20,
              shouldLoop: true,
              colors: const [
                Colors.blue,
                Colors.greenAccent,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),),
        widget.child,
      ],
    );
  }
}
