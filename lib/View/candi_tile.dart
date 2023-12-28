// View/candi_tile.dart
import 'package:flutter/material.dart';
import 'dart:math';

class CandyTile extends StatelessWidget {
  final List<String> assetPaths;
  final VoidCallback onTap;

  CandyTile({Key? key, required this.assetPaths, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final selectedAsset = assetPaths[random.nextInt(assetPaths.length)];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(
          'assets/$selectedAsset',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
