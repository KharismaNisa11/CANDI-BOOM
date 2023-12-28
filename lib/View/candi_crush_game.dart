import 'package:candiboom/Controller/game_controller.dart';
import 'package:candiboom/Controller/settings_controller.dart';
import 'package:candiboom/View/candi_tile.dart';
import 'package:flutter/material.dart';

class CandiGame extends StatefulWidget {
  const CandiGame({super.key});

  @override
  _CandiGameState createState() => _CandiGameState();
}

class _CandiGameState extends State<CandiGame> {
  late GameController gameController;
  late SettingsController settingsController;// Add sound controller

  @override
  void initState() {
    super.initState();

    // Initialize controllers and settings
    settingsController = SettingsController(
    );  


    gameController = GameController(
      onScoreUpdated: _handleScoreUpdated,
      onCandiesUpdated: _handleCandiesUpdated, currentLanguage: 'English',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candy Crush'),
        backgroundColor: const Color.fromRGBO(139, 90, 71, 1),
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
                        gameController.onTileTapped(index);// Play tap sound
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