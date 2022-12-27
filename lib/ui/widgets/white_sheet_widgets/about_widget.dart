import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_basic_data.dart';
import 'package:pokemon_flutter/models/pokemon_about_data.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;

import 'pokemon_info_list_widget.dart';
import 'title_and_subtitle_widget.dart';

class AboutWidget extends StatelessWidget {
  final PokemonBasicData pokemon;

  const AboutWidget({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String flavorText;
    late int captureRate;
    late int baseHappiness;
    late String habitat;
    late String growthRate;
    late List<String> eggGroups;
    if (pokemon.pokemonAboutData != null) {

      final PokemonAboutData pokemonAboutData =
          pokemon.pokemonAboutData!;
      flavorText = pokemonAboutData.flavorText?? 'Unknown';
      captureRate = pokemonAboutData.captureRate?? 0;
      baseHappiness = pokemonAboutData.baseHappiness?? 0;
      habitat = pokemonAboutData.habitat?? 'Unknown';
      growthRate = pokemonAboutData.growthRate?? 'Unknown';
      eggGroups = pokemonAboutData.eggGroups?? [];
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
            TitleAndSubtitleWidget(title: 'Description', subtitle: flavorText),
            TitleAndSubtitleWidget(
                title: 'Growth Rate', subtitle: growthRate.toString()),
            TitleAndSubtitleWidget(
                title: 'Habitat', subtitle: habitat.toString()),
            TitleAndSubtitleWidget(
                title: 'Capture Rate', subtitle: '${captureRate.toString()} %'),
            TitleAndSubtitleWidget(
                title: 'Base Happiness',
                subtitle: '${baseHappiness.toString()} point'),
            // egg groups list
            PokemonInfoListWidget(listTitle: 'Egg Groups',pokemonData: eggGroups),
          ],
        ),
      ),
    );
  }
}


