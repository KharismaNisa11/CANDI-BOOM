// main_menu.dart
import 'package:candiboom/View/candi_crush_game.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        backgroundColor: Color.fromRGBO(139, 90, 71, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _startGame(context, 1);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(139, 90, 71, 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text('Level 1', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 20), // Add space above Level 2 button
              ElevatedButton(
                onPressed: () {
                  _navigateToSeeYouSoon(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(139, 90, 71, 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text('Level 2', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 20), // Add space above Level 3 button
              ElevatedButton(
                onPressed: () {
                  _navigateToSeeYouSoon(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(139, 90, 71, 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text('Level 3', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(height: 20), // Add space above Level 4 button
              ElevatedButton(
                onPressed: () {
                  _navigateToSeeYouSoon(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(139, 90, 71, 1),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text('Level 4', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startGame(BuildContext context, int level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CandiGame(),
      ),
    );
  }

  void _navigateToSeeYouSoon(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeeYouSoonPage(),
      ),
    );
  }
}

class SeeYouSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('See You Soon'),
      ),
      body: Center(
        child: Text(
          'See You Soon!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
