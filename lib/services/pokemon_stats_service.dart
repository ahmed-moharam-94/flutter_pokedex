import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_flutter/models/pokemon_basic_data.dart';
import 'package:pokemon_flutter/models/pokemon_stats_data.dart';

class PokemonStatsService {
  Future<Map<String, dynamic>> fetchPokemonStats(PokemonBasicData pokemon) async {
    Map<String, dynamic> pokemonStats = {};
    // convert the pokemon name to lower case so we can use it in the url
    String pokemonNameLowerCase = pokemon.name.toLowerCase();

    try {
      final Uri url =
          Uri.https('pokeapi.co', 'api/v2/pokemon/$pokemonNameLowerCase');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var pokemonData = json.decode(response.body);
        List statsData = pokemonData['stats'];
        int hp = 0;
        int attack = 0;
        int defence = 0;
        int specialAttack = 0;
        int specialDefence = 0;
        int speed = 0;

        hp = statsData[0]['base_stat'];
        attack = statsData[1]['base_stat'];
        defence = statsData[2]['base_stat'];
        specialAttack = statsData[3]['base_stat'];
        specialDefence = statsData[4]['base_stat'];
        speed = statsData[5]['base_stat'];


        pokemonStats = {
          'hp': hp,
          'attack': attack,
          'defence': defence,
          'specialAttack': specialAttack,
          'specialDefence': specialDefence,
          'speed': speed
        };
      }

      return pokemonStats;

    } catch (error) {
      rethrow;
    }
  }
}
