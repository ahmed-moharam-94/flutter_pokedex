import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_flutter/models/pokemon_basic_data.dart';

class PokemonMoreInfoService {
  // Fetch pokemon (more info) data
  Future<Map<String, dynamic>> fetchPokemonMoreIndoData(
      PokemonBasicData pokemon) async {

    Map<String, dynamic> moreInfo = {};

    // convert the pokemon name to lower case so we can use it in the url
    String pokemonNameLowerCase = pokemon.name.toLowerCase();

    try {
      final Uri url =
      Uri.https('pokeapi.co', 'api/v2/pokemon/$pokemonNameLowerCase');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var pokemonData = json.decode(response.body);
        int height = pokemonData['height'];
        int weight = pokemonData['weight'];

        // extract types names
        List<String> typesNames = [];
        List types = pokemonData['types'];
        for (var typeName in types) {
          typesNames.add(typeName['type']['name']);
        }

        // extract moves names
        List<String> movesNames = [];
        List moves = pokemonData['moves'];
        for (var moveName in moves) {
          movesNames.add(moveName['move']['name']);
        }

        // extract abilities names
        List<String> abilitiesNames = [];
        List abilities = pokemonData['abilities'];
        for (var abilityName in abilities) {
          abilitiesNames.add(abilityName['ability']['name']);
        }

        moreInfo = {
          'height': height,
          'weight': weight,
          'types': typesNames,
          'moves': movesNames,
          'abilities': abilitiesNames,
        };
      }
      return moreInfo;
    } catch (error) {
      rethrow;
    }
  }
}