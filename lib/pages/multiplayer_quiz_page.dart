import 'package:flutter/material.dart';

class MultiplayerPage extends StatelessWidget {
  const MultiplayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiplayer Quiz"),
      ),
      body: Center(
        child: Text(
          "Start a multiplayer quiz here.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
