import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'quiz_categories_page.dart';
import 'single_player_quiz_page.dart';
import 'multiplayer_quiz_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Greeting or App Name
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Quiz Categories
            ElevatedButton(
              onPressed: () {
                // Navigate to quiz categories
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizCategoriesPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Quiz Categories'),
            ),
            SizedBox(height: 10),
            // Play Single Player
            ElevatedButton(
              onPressed: () {
                // Navigate to single player quiz
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SinglePlayerPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Play Single Player'),
            ),
            SizedBox(height: 10),
            // Play with a Friend
            ElevatedButton(
              onPressed: () {
                // Navigate to multiplayer quiz
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MultiplayerPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Play with a Friend'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
