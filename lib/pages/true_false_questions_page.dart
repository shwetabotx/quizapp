import 'package:flutter/material.dart';

class TrueFalseQuestionsPage extends StatelessWidget {
  const TrueFalseQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        )),
      ),
    );
  }
}