import 'package:flutter/material.dart';

class SinglePlayerPage extends StatelessWidget {
  const SinglePlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Single Player Quiz"),
      ),
      body: Center(
        child: Text(
          "Start a single-player quiz here.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
