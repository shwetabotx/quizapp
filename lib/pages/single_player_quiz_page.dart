import 'dart:async';
import 'package:flutter/material.dart';

class SinglePlayerPage extends StatefulWidget {
  const SinglePlayerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SinglePlayerPageState createState() => _SinglePlayerPageState();
}

class _SinglePlayerPageState extends State<SinglePlayerPage> {
  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is the capital of France?',
      'answers': ['Paris', 'London', 'Berlin', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'Who wrote "1984"?',
      'answers': [
        'George Orwell',
        'J.K. Rowling',
        'F. Scott Fitzgerald',
        'Ernest Hemingway'
      ],
      'correctAnswer': 'George Orwell',
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'answers': ['Earth', 'Jupiter', 'Mars', 'Saturn'],
      'correctAnswer': 'Jupiter',
    },
    {
      'question': 'What is the surname of shweta?',
      'answers': ['Zala', 'Jadeja', 'Parmar', 'Solanki'],
      'correctAnswer': 'Jadeja',
    },
    {
      'question': 'konse color ki chaddi pehne ho ? hmmm...',
      'answers': ['Red', 'Green', 'Pink', 'Blue'],
      'correctAnswer': 'Pink',
    },
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswerSelected = false;
  late Timer _timer;
  int _timerSeconds = 10;
  String _selectedAnswer = "";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _nextQuestion();
        }
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _timerSeconds = 10;
        _isAnswerSelected = false;
        _selectedAnswer = ""; // Reset the selected answer
      });
      _stopTimer();
      _startTimer();
    } else {
      _showFinalScore();
    }
  }

  void _showFinalScore() {
    _stopTimer();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Finished",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text("Your final score is $_score/${_questions.length}.",
            style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text("OK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _selectAnswer(String selectedAnswer) {
    if (!_isAnswerSelected) {
      setState(() {
        _isAnswerSelected = true;
        _selectedAnswer = selectedAnswer;
      });

      if (selectedAnswer ==
          _questions[_currentQuestionIndex]['correctAnswer']) {
        setState(() {
          _score++;
        });
      }

      Future.delayed(Duration(seconds: 2), _nextQuestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Single Player Quiz",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer
            Text(
              "Time: $_timerSeconds s",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Question text
            Text(
              currentQuestion['question'] as String,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // Answer buttons
            for (var answer in currentQuestion['answers'] as List<String>)
              AnimatedButton(
                onPressed: () => _selectAnswer(answer),
                text: answer,
                isSelected: _isAnswerSelected && _selectedAnswer == answer,
                isCorrect: answer ==
                    _questions[_currentQuestionIndex]['correctAnswer'],
                isIncorrect: answer == _selectedAnswer &&
                    answer !=
                        _questions[_currentQuestionIndex]['correctAnswer'],
              ),
            Spacer(),
            // Current score
            Text(
              "Score: $_score/${_questions.length}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class AnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isCorrect;
  final bool isIncorrect;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
    required this.isCorrect,
    required this.isIncorrect,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected
            ? (isCorrect
                ? Colors.green
                : (isIncorrect ? Colors.red : Colors.deepPurpleAccent))
            : Colors.deepPurpleAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor:
              Colors.transparent, // We use the decoration color here
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: Colors.transparent, // To remove the shadow of the button
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
