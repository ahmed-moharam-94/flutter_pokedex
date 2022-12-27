import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_flutter/models/pokemon_about_data.dart';

import '../models/pokemon_basic_data.dart';

class PokemonAboutDataService {
  // Fetch pokemon (about tab) data
  Future<Map<String, dynamic>> getPokemonAboutData(
      PokemonBasicData pokemon) async {
    Map<String, dynamic> pokemonAboutData = {};

    // convert the pokemon name to lower case so we can use it in the url
    String pokemonNameLowerCase = pokemon.name.toLowerCase();
    Uri url =
        Uri.http('pokeapi.co', 'api/v2/pokemon-species/$pokemonNameLowerCase');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var pokemonInfo = json.decode(response.body);
        int baseHappiness = pokemonInfo['base_happiness'];
        int captureRate = pokemonInfo['capture_rate'];
        var habitatData = pokemonInfo['habitat'];
        String habitat = 'Unknown'; // not every pokemon has this data
        if (habitatData != null) {
           habitat = habitatData['name'];
        }
        String growthRate = pokemonInfo['growth_rate']['name'];
        // get only the first text
        String flavorText =
            pokemonInfo['flavor_text_entries'][0]['flavor_text'];
        // replace text '\n' with space
        String flavorTextEdited = flavorText.replaceAll(RegExp('\n'), '');

        // extract egg groups names from the map
        List<String> eggGroupNames = [];
        List eggGroups = pokemonInfo['egg_groups'];
        for (var eggGroup in eggGroups) {
          eggGroupNames.add(eggGroup['name']);
        }

        pokemonAboutData = {
          'baseHappiness': baseHappiness,
          'captureRate': captureRate,
          'habitat': habitat,
          'growthRate': growthRate,
          'flavorText': flavorTextEdited,
          'eggGroups': eggGroupNames,
        };
      }
      return pokemonAboutData;
    } catch (error) {
      rethrow;
    }
  }
}
