import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SinglePlayerPage extends StatefulWidget {
  const SinglePlayerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SinglePlayerPageState createState() => _SinglePlayerPageState();
}

class _SinglePlayerPageState extends State<SinglePlayerPage> {
  List<Map<String, Object>> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswerSelected = false;
  String _selectedAnswer = "";
  late Timer _timer;
  int _timerSeconds = 10;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    const url = 'https://opentdb.com/api.php?amount=10&type=multiple';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _questions = (data['results'] as List)
              .map((question) {
                final incorrectAnswers = (question['incorrect_answers'] as List)
                    .map((e) => e as Object)
                    .toList();
                final correctAnswer = question['correct_answer'] as Object;
                final allAnswers = [...incorrectAnswers, correctAnswer];
                allAnswers.shuffle();
                return {
                  'question': question['question'] as Object,
                  'answers': allAnswers,
                  'correctAnswer': correctAnswer,
                };
              })
              .toList()
              .cast<Map<String, Object>>();
          _isLoading = false;
          _startTimer();
        });
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error fetching questions: $error');
    }
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
        _selectedAnswer = "";
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
        title: Text(
          "Quiz Finished",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Your final score is $_score/${_questions.length}.",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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

      // Delay before moving to the next question
      Future.delayed(Duration(seconds: 2), () {
        _nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Single Player Quiz"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Single Player Quiz",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
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
                color: Colors.deepPurpleAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Question text
            Text(
              currentQuestion['question'] as String,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // Answer buttons
            for (var answer in currentQuestion['answers'] as List<Object>)
              AnimatedButton(
                onPressed: () => _selectAnswer(answer),
                text: answer as String,
                isSelected: _selectedAnswer == answer,
                isCorrect: _isAnswerSelected &&
                    answer == currentQuestion['correctAnswer'],
                isIncorrect: _isAnswerSelected &&
                    answer == _selectedAnswer &&
                    answer != currentQuestion['correctAnswer'],
              ),
            Spacer(),
            // Current score
            Text(
              "Score: $_score/${_questions.length}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
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
            : (isCorrect ? Colors.green : Colors.deepPurpleAccent),
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
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
