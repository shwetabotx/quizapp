import 'package:flutter/material.dart';

class QuizCategoriesPage extends StatelessWidget {
  const QuizCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Categories"),
      ),
      body: Center(
        child: Text(
          "Select a quiz category here.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
