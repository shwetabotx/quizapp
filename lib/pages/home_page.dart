import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // Sign out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            });
          },
        ),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: "Single Player Zone"),
            CustomCardButton(
              title: "Single Player Mode",
              subtitle: "Play the quiz smarty",
              icon: Icons.emoji_people_outlined,
              onTap: () {
                debugPrint("Single Player Mode Clicked!");
              },
            ),
            CustomCardButton(
              title: "Exam Mode",
              subtitle: "Let us see how much have you learned!",
              icon: Icons.school,
              onTap: () {
                debugPrint("Exam Mode clicked!");
              },
            ),
            const SectionTitle(title: "Multiplayer Zone"),
            CustomCardButton(
              title: "Group Battle",
              subtitle: "Let us see who wins!",
              icon: Icons.groups_3,
              onTap: () {
                debugPrint("Group Battle clicked!");
              },
            ),
            CustomCardButton(
              title: "Two Player Mode",
              subtitle: "Who is the smarter one?",
              icon: Icons.group,
              onTap: () {
                debugPrint("Two Player Mode clicked!");
              },
            ),
            const SectionTitle(title: "Fun Zone"),
            CustomCardButton(
              title: "Daily Quiz",
              subtitle: "Play and get smarter everyday",
              icon: Icons.assignment_rounded,
              onTap: () {
                debugPrint("Fun 'N' Learn clicked!");
              },
            ),
            CustomCardButton(
              title: "Guess The Word",
              subtitle: "Fun vocabulary game",
              icon: Icons.abc,
              onTap: () {
                debugPrint("Guess The Word clicked!");
              },
            ),
            CustomCardButton(
              title: "Audio Questions",
              subtitle: "Quiz with audio",
              icon: Icons.multitrack_audio_sharp,
              onTap: () {
                debugPrint("Audio Questions clicked!");
              },
            ),
            CustomCardButton(
              title: "True/False Questions",
              subtitle: "Yay Or Nay?",
              icon: Icons.close,
              onTap: () {
                debugPrint("True/False Questions clicked!");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomCardButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const CustomCardButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 36.0,
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
