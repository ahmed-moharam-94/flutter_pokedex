
import 'package:flutter/material.dart';
import 'package:pokemon_flutter/models/pokemon_about_data.dart';
import 'package:pokemon_flutter/models/pokemon_more_info_data.dart';
import 'package:pokemon_flutter/models/pokemon_stats_data.dart';

class PokemonBasicData {
  final String name;
  final String url;
  String id;
  String imageUrl;
  Color? cardColor;
  PokemonAboutData? pokemonAboutData;
  PokemonMoreInfoData? pokemonMoreInfoData;
  PokemonStatsData? pokemonStatsData;

  PokemonBasicData({
    required this.name,
    required this.url,
    this.id = '000',
    this.imageUrl = '',
    this.cardColor = Colors.grey,
    this.pokemonAboutData,
    this.pokemonMoreInfoData,
    this.pokemonStatsData,
  });
}
