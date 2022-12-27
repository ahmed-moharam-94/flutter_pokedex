import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorsGenerator {
  // generate a color for the card dynamically based on the Pokemon color
  Future<Color> generateCardColor(
      String pokemonImageUrl, bool isDarkTheme) async {
    // set default color if the palette can't generate color if the image didn't load successfully.
    Color cardColor = Colors.black.withOpacity(0.5);
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
          NetworkImage(pokemonImageUrl));
      // get the domain color from the pokemon image
      if (paletteGenerator.dominantColor != null) {
        if (isDarkTheme) {
          cardColor = paletteGenerator.dominantColor!.color.withAlpha(500);
        } else {
          cardColor = paletteGenerator.dominantColor!.color.withOpacity(0.25);
        }
      }
    } catch (error) {
      rethrow;
    }
    return cardColor;
  }
}