import 'package:candiboom/Model/candi_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GameController {
  CandiModel candyModel;
  final Function(int) onScoreUpdated;
  final VoidCallback onCandiesUpdated;
  int score;

  GameController({
    required this.onScoreUpdated,
    required this.onCandiesUpdated,
    required String currentLanguage,
  })   : candyModel = CandiModel(),
        score = 0;

  void onTileTapped(int tappedIndex) {
    final List<int> matchingIndices = getMatchingIndices(tappedIndex);

    if (matchingIndices.length >= 3) {
      candyModel.removeCandies(matchingIndices);
      updateScore(matchingIndices);
      onScoreUpdated(score); // Notify the UI about the updated score

      // Trigger the fall effect immediately for the matched candies
      triggerFallEffect(matchingIndices);

      // After the fall effect, generate new candies to fill the empty spaces
      generateNewCandies(matchingIndices);
    }
  }

  void updateScore(List<int> matchingIndices) {
    score += matchingIndices.isNotEmpty ? 1 : 0;
  }

  Future<void> triggerFallEffect(List<int> affectedIndices) async {
    // Apply gravity only for the affected indices
    candyModel.applyGravity(affectedIndices);
    onCandiesUpdated(); // Notify the UI after the fall effect
  }

  void generateNewCandies(List<int> emptyIndices) {
    // Generate new candies only for the provided empty indices
    for (int emptyIndex in emptyIndices) {
      candyModel.candies[emptyIndex] = getRandomCandyAsset();
    }

    onCandiesUpdated(); // Notify the UI after generating new candies
  }

  String getRandomCandyAsset() {
    // Replace this with your logic to get a random candy asset
    final List<String> candyAssets = ["Borobudur.png", "Candi Prambanan.png", "cankuang.png"];
    final Random random = Random();
    return candyAssets[random.nextInt(candyAssets.length)];
  }

  List<int> getAdjacentIndices(int index) {
    final List<int> adjacentIndices = [];
    if (index % candyModel.rowSize > 0) {
      adjacentIndices.add(index - 1); // Left
    }
    if (index % candyModel.rowSize < candyModel.rowSize - 1) {
      adjacentIndices.add(index + 1); // Right
    }
    if (index >= candyModel.rowSize) {
      adjacentIndices.add(index - candyModel.rowSize); // Up
    }
    if (index < candyModel.boardSize - candyModel.rowSize) {
      adjacentIndices.add(index + candyModel.rowSize); // Down
    }
    return adjacentIndices;
  }

  List<int> getMatchingIndices(int tappedIndex) {
    final List<int> matchingIndices = [tappedIndex];
    final String targetAsset = candyModel.getCandyAsset(tappedIndex);

    void checkNeighbor(int index) {
      final List<int> adjacentIndices = getAdjacentIndices(index);
      for (int adjacentIndex in adjacentIndices) {
        if (!matchingIndices.contains(adjacentIndex) &&
            candyModel.getCandyAsset(adjacentIndex) == targetAsset) {
          matchingIndices.add(adjacentIndex);
          checkNeighbor(adjacentIndex);
        }
      }
    }

    checkNeighbor(tappedIndex);
    return matchingIndices;
  }
}