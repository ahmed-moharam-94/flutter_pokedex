import 'dart:convert';

import 'package:http/http.dart' as http;

class PokemonsSearchService {

  Future<List<String>> getAllAbilities() async {
    List<String> pokemonsNames = [];
    try {
      final url = Uri.https('pokeapi.co', 'api/v2/pokemon', {'limit': '1000'});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final fetchedPokemons = json.decode(response.body)['results'];
        for (var pokemonData in fetchedPokemons) {

          // convert first letter to uppercase
          final String pokemonName = pokemonData['name'].substring(0, 1).toUpperCase() +
              pokemonData['name'].substring(1);
          pokemonsNames.add(pokemonName);
        }
      }
    } catch (error) {
      rethrow;
    }
    return pokemonsNames;
  }

  Future<List<String>> getAllPokemonsNames() async {
    List<String> pokemonsAbilities = [];
    try {
      final url = Uri.https('pokeapi.co', 'api/v2/ability', {'limit': '1000'});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final fetchedAbilities = json.decode(response.body)['results'];
        for (var pokemonData in fetchedAbilities) {
          // convert first letter to uppercase
          final String ability = pokemonData['name'].substring(0, 1).toUpperCase() +
              pokemonData['name'].substring(1);
          pokemonsAbilities.add(ability);
        }
      }
    } catch (error) {
      rethrow;
    }
    return pokemonsAbilities;
  }

  Future<Map<String, dynamic>> getAbilityData(String ability) async {
    Map<String, dynamic> abilityData = {};
    final List<String> pokemonsNames = [];
    try {
      final String abilityLowerCase = ability.toLowerCase();
      final url = Uri.https('pokeapi.co', 'api/v2/ability/$abilityLowerCase');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final fetchedData = json.decode(response.body);
        // get only the first flavor text
        final String flavorText = fetchedData['flavor_text_entries'][0]['flavor_text'];
        // get the pokemons who have the ability
        final fetchedPokemons = fetchedData['pokemon'];
        for (var pokemon in fetchedPokemons) {
          // convert the pokemon name first letter to upper case and add it to the list of pokemons
          pokemonsNames.add(pokemon['pokemon']['name'].substring(0, 1).toUpperCase() +
              pokemon['pokemon']['name'].substring(1));
        }

        abilityData = {
          'flavorText': flavorText,
          'pokemonsNames': pokemonsNames,
        };
      }
    } catch (error) {
      rethrow;
    }
    return abilityData;
  }

}