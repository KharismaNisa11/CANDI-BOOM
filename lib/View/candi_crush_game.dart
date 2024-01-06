import 'package:candiboom/Controller/game_controller.dart';
import 'package:candiboom/Controller/settings_controller.dart';
import 'package:candiboom/View/candi_tile.dart';
import 'package:candiboom/View/menu.dart';
import 'package:flutter/material.dart';

class CandiGame extends StatefulWidget {
  const CandiGame({Key? key}) : super(key: key);

  @override
  _CandiGameState createState() => _CandiGameState();
}

class _CandiGameState extends State<CandiGame> {
  late GameController gameController;
  late SettingsController settingsController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers and settings
    settingsController = SettingsController();

    gameController = GameController(
      onScoreUpdated: _handleScoreUpdated,
      onCandiesUpdated: _handleCandiesUpdated,
      currentLanguage: 'English',
    );
  }

  void _handleScoreUpdated(int newScore) {
    print('Score Updated: $newScore');
    setState(() {});
  }

  void _handleCandiesUpdated() {
    // Rebuild the UI after the fall effect
    setState(() {});
  }

  void _showSettingsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Your settings content here

              // Buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cancel button
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the settings popup
                    },
                    child: Text('Cancel'),
                  ),

                  // Main Menu button with confirmation dialog
                  TextButton(
                    onPressed: () {
                      _showExitConfirmation(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.list), // List icon
                        SizedBox(width: 5), // Add some spacing
                        Text('Main Menu'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to end the game and go back to the main menu?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
                _navigateToMainMenu(); // Navigate back to the main menu
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToMainMenu() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainMenu(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candy Boom'),
        backgroundColor: const Color.fromRGBO(139, 90, 71, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert), // Change to more_vert icon
            onPressed: () {
              _showSettingsPopup(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Score: ${gameController.score}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: gameController.candyModel.boardSize,
                itemBuilder: (context, index) {
                  return CandyTile(
                    assetPaths: const [
                      'Borobudur.png',
                      'Candi Prambanan.png',
                      'cankuang.png',
                      'Rencong.png',
                      'Badik.png',
                    ],
                    onTap: () {
                      setState(() {
                        gameController.onTileTapped(index);
                        // Play tap sound
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
