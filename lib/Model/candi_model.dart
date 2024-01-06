import 'dart:math';

class CandiModel {
  final int rowSize = 9;
  List<String> candies = [];

  CandiModel() {
    // Initialize candies with random asset identifiers
    generateRandomCandies();
  }

  void generateRandomCandies() {
    // Initialize candies with random asset identifiers
    final random = Random();
    for (int i = 0; i < rowSize * rowSize; i++) {
      candies.add(getRandomCandyAsset(random));
    }
  }

  String getRandomCandyAsset(Random random) {
    // Replace this with your logic to get a random candy asset
    final List<String> candyAssets = ["Borobudur.png", "Candi Prambanan.png", "cankuang.png"];
    return candyAssets[random.nextInt(candyAssets.length)];
  }

  String getCandyAsset(int index) {
    return candies[index];
  }

  void removeCandies(List<int> indices) {
    // Remove candies at given indices
    for (int index in indices) {
      candies[index] = "empty"; // Assuming "empty" is an identifier for an empty cell
    }
  }

  Future<void> applyGravity(List<int> affectedIndices) async {
    for (int col = 0; col < rowSize; col++) {
      for (int row = rowSize - 1; row > 0; row--) {
        if (affectedIndices.contains(row * rowSize + col) && candies[row * rowSize + col] == "empty") {
          // Find the nearest non-empty candy above and make it fall down
          int nonEmptyRow = row - 1;
          while (nonEmptyRow >= 0 && candies[nonEmptyRow * rowSize + col] == "empty") {
            nonEmptyRow--;
          }

          if (nonEmptyRow >= 0) {
            // Introduce a delay for a falling effect
            await Future.delayed(const Duration(milliseconds: 200)); // Adjust the delay duration as needed

            candies[row * rowSize + col] = candies[nonEmptyRow * rowSize + col];
            candies[nonEmptyRow * rowSize + col] = "empty";
          }
        }
      }
    }
  }

  void breakDownCandies(List<int> clickedIndices) {
    // Check if three candies of the same type are clicked, then remove them
    List<String> clickedCandies = clickedIndices.map((index) => candies[index]).toList();

    if (clickedCandies.toSet().length == 1 && clickedCandies.first != "empty") {
      // Three candies of the same type are clicked
      removeCandies(clickedIndices);
      applyGravity(clickedIndices);
    }
  }

  int get boardSize => candies.length;
}
