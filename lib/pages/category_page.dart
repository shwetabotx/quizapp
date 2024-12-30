import 'package:flutter/material.dart';
import 'single_player_quiz_page.dart';

class CategoryPage extends StatelessWidget {
  final List<String> categories = [
    'General Knowledge',
    'Entertainment: Books',
    'Entertainment: Film',
    'Entertainment: Music',
    'Entertainment: Musical & Theaters',
    'Entertainment: Television',
    'Entertainment: Video Games',
    'Entertainment: Board Games',
    'Science & Nature',
    'Science: Computers',
    'Science: Mathemetics',
    'Mythology',
    'Sports',
    'Geography',
    'History',
    'Politics',
    'Art',
    'Celebrities',
    'Animals',
    'Vehicles',
    'Entertainment: Comics',
    'Science: Gadgets',
    'Entertainment: Japanese Anime & Manga',
    'Entertainment: Cartoon & Animations',
  ];

  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              // Navigate to the quiz page with the selected category
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SinglePlayerPage(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
