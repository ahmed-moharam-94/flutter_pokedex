import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_more_info_data.dart';

import '../../../models/pokemon_basic_data.dart';
import 'pokemon_info_list_widget.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;

class MovesWidget
    extends StatelessWidget {
  final PokemonBasicData pokemon;

  const MovesWidget({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> moves = [];
    if (pokemon.pokemonMoreInfoData != null) {
      final PokemonMoreInfoData pokemonMoreInfoData =
      pokemon.pokemonMoreInfoData!;
      moves = pokemonMoreInfoData.moves!;
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: constants.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // moves names list
            PokemonInfoListWidget(listTitle: 'Moves', pokemonData: moves),
          ],
        ),
      ),
    );
  }
}
