import 'package:flutter/material.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;

class PokemonInfoListWidget extends StatelessWidget {
  final List<String> pokemonData;
  final String listTitle;

  const PokemonInfoListWidget({Key? key, required this.pokemonData, required this.listTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$listTitle:',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        ...pokemonData.map((groupName) {
          return Column(
            children: [
              const SizedBox(height: constants.smallPadding),
              Text(groupName),
            ],
          );
        }).toList(),
        const SizedBox(height: constants.mediumPadding),
      ],
    );
  }
}